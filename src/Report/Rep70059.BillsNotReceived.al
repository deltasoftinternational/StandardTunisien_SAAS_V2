report 71059 "Bills Not Received"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Factures achat non parvenues';
    UseRequestPage = true;
    ProcessingOnly = true;
    Permissions = tabledata "Purch. Rcpt. Line" = RIMD, tabledata "G/L Entry" = rm;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) order(Ascending) where(Number = CONST(1));

            trigger OnPreDataItem()
            begin
                onBeforeBillsNotReceived();
            end;

            trigger OnAfterGetRecord()

            begin
                IF GDatGCompta = 0D then
                    ERROR(TEXT001);
                IF NOT GAutomaticExecution THEN
                    IF NOT CONFIRM(TEXT002, FALSE) THEN
                        EXIT;
                Window.Open(TEXT003 + TEXT004);
                Window.Update(2, STRSUBSTNO('%1', TEXT005));
                CancelFNP(GDatGCompta);
                Window.Update(2, STRSUBSTNO('%1', TEXT006));
                Window.Update(3, STRSUBSTNO('%1', TEXT005));
                GenerateFNP(GDatGCompta);
                Window.Update(3, STRSUBSTNO('%1', TEXT006));
                Window.Close();
                IF NOT GAutomaticExecution THEN
                    MESSAGE(TEXT006);
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field("Date Comptabilisation"; GDatGCompta)
                {
                    ApplicationArea = All;
                }
                field("Amount Calculation Method"; GMethodAmount)
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Montant HT,Montant TTC';

                }
                field("Purchase Receipt No."; GPurchaseReceiptNo)
                {
                    ApplicationArea = All;
                    Caption = 'N° réception achat';
                    TableRelation = "Purch. Rcpt. Header";
                }

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforeBillsNotReceived()
    begin
    end;

    var
        GGenPostSetup: Record "General Posting Setup";
        GVATPostingSetup: Record "VAT Posting Setup";
        GGenJnlLn: Record "Gen. Journal Line";
        GGLSetup: Record "General Ledger Setup";
        GPurchRcptHdr: Record "Purch. Rcpt. Header";
        GCurrExchRate: Record "Currency Exchange Rate";
        GItem: Record Item;
        GCurrency: Record Currency;
        //GINIINRPstdLines: Record "INI INR Posted Lines";
        GPurchPayablesSetup: Record "Purchases & Payables Setup";
        GGLEntry: Record "G/L Entry";

        GGLEntry1: Record "G/L Entry";

        GGLEntry2: Record "G/L Entry";
        GDimMgt: Codeunit DimensionManagement;
        GGenJnlPostLn: Codeunit "Gen. Jnl.-Post Line";
        GNoSeriesMgt: Codeunit "No. Series";

        GEntryApply: Codeunit "G/L Entry Application";
        GDatGCompta: date;
        GMethodAmount: option "Amount HT","Amount TTC";
        GPurchaseReceiptNo: Code[20];
        GAutomaticExecution: Boolean;
        GINRTransaction: Integer;

        GNumSeq: Integer;

        GPurchaseReceiptLineNo: Integer;
        GPostingDocNo: Code[20];
        GNumDom: Code[20];

        GLetterToSet: Text[8];

        Window: Dialog;

        TEXT001: Label 'Veuillez renseigner la date';
        TEXT002: Label 'Voulez-vous annuler et regénérer les FNP';
        TEXT003: Label 'Annul. FNP       #2##################\';
        TEXT004: Label 'Génération FNP       #3##################\';

        TEXT005: Label 'Traitement en-cours';
        TEXT006: Label 'Traitement terminé';
        TEXT007: Label 'FNP relative au BR n°';
        TEXT008: Label 'Annul. FNP- BR N°:';

    procedure CancelFNP(PDateLCompta: date);
    var
        LPurchRcptHeader: Record "Purch. Rcpt. Header";
        LPurchRcptLine: Record "Purch. Rcpt. Line";
        LIncVATAmount: Decimal;
        LExcVATAmount: Decimal;
        LQuantity: Decimal;
        LNewDoc: Boolean;
        LVendor: Record Vendor;
        LVendorPostingGroup: Record "Vendor Posting Group";
        LDiscLineAmt: Decimal;
        LAmount: Decimal;
        LCostCenter: Code[20];
        LDimensionManagement: Codeunit DimensionManagement;
    begin
        GGLSetup.GET(GGLSetup."Primary Key");
        GCurrency.RESET();
        GCurrency.InitRoundingPrecision();
        LPurchRcptHeader.RESET();
        LPurchRcptHeader.SETRANGE(LPurchRcptHeader.FNP, TRUE);
        IF GPurchaseReceiptNo <> '' THEN
            LPurchRcptHeader.SetRange("No.", GPurchaseReceiptNo);
        IF LPurchRcptHeader.FINDFIRST() THEN
            REPEAT
                Window.UPDATE(2, LPurchRcptHeader."No.");
                LPurchRcptLine.Reset();
                IF LVendor.Get(LPurchRcptHeader."Buy-from Vendor No.") THEN
                    IF LVendorPostingGroup.GET(LVendor."Vendor Posting Group") THEN
                        LVendorPostingGroup.TestField("ST Accrual Account");
                LIncVATAmount := 0;
                LNewDoc := true;
                LPurchRcptLine.RESET();
                LPurchRcptLine.SetFilter("Document No.", LPurchRcptHeader."No.");
                LPurchRcptLine.SetFilter(LPurchRcptLine.Type, '<>%1&<>%2', LPurchRcptLine.Type::" ", LPurchRcptLine.Type::"Fixed Asset");
                IF GPurchaseReceiptLineNo <> 0 then
                    LPurchRcptLine.SetRange("Line No.", GPurchaseReceiptLineNo);
                IF LPurchRcptLine.FindFirst() then
                    REPEAT
                        IF LPurchRcptLine."ST INR Quantity" <> 0 THEN BEGIN
                            LQuantity := LPurchRcptLine."ST INR Quantity";
                            IF LPurchRcptLine.Type = LPurchRcptLine.Type::Item THEN BEGIN
                                GItem.GET(LPurchRcptLine."No.");
                                GGenPostSetup.GET(LPurchRcptLine."Gen. Bus. Posting Group", GItem."Gen. Prod. Posting Group");
                            END ELSE
                                GGenPostSetup.GET(LPurchRcptLine."Gen. Bus. Posting Group", LPurchRcptLine."Gen. Prod. Posting Group");
                            LAmount := LPurchRcptLine."ST INR Amount";
                            GGenJnlLn.INIT();
                            GGenJnlLn."Source Code" := GGLSetup."ST INR Source Code";
                            GGenJnlLn."Posting Date" := PDateLCompta;
                            GGenJnlLn."System-Created Entry" := TRUE;
                            IF GPostingDocNo <> '' THEN
                                GNumDom := GPostingDocNo
                            ELSE
                                IF LNewDoc THEN BEGIN
                                    GNumDom := GNoSeriesMgt.GetNextNo(GGLSetup."ST INR Series", PDateLCompta, TRUE);
                                    LNewDoc := FALSE;
                                END;
                            GGenJnlLn."Document No." := GNumDom;
                            GGenJnlLn."Account Type" := GGenJnlLn."Account Type"::"G/L Account";
                            IF GGenPostSetup."Purch. Account" = '' THEN
                                MESSAGE(GGenPostSetup."Gen. Prod. Posting Group");
                            GGenJnlLn.Validate(GGenJnlLn."Account No.", GGenPostSetup."Purch. Account");
                            GGenJnlLn.Description := TEXT008 + ' ' + LPurchRcptLine."Document No." + '/' + LPurchRcptLine."Buy-from Vendor No.";
                            GGenJnlLn."External Document No." := LPurchRcptLine."Document No.";
                            GGenJnlLn.Validate(GGenJnlLn.Amount, -LAmount);
                            GGenJnlLn."Source Type" := GGenJnlLn."Source Type"::Vendor;
                            GGenJnlLn."Source No." := LPurchRcptLine."Buy-from Vendor No.";
                            GGenJnlLn.Validate("Dimension Set ID", LPurchRcptLine."Dimension Set ID");
                            GGenJnlLn."Shortcut Dimension 1 Code" := LPurchRcptLine."Shortcut Dimension 1 Code";
                            GGenJnlLn."Shortcut Dimension 2 Code" := LPurchRcptLine."Shortcut Dimension 2 Code";
                            GGenJnlPostLn.RunWithCheck(GGenJnlLn);
                            Apply(LVendorPostingGroup."ST Accrual Account", GGLSetup."ST INR Source Code", LVendorPostingGroup."ST Accrual Account");
                            LPurchRcptLine."ST INR Quantity" := 0;
                            LPurchRcptLine."ST INR Amount" := 0;
                            LPurchRcptLine.Modify();
                            IF GMethodAmount = GMethodAmount::"Amount HT" then
                                LIncVATAmount := LIncVATAmount + LAmount;

                        END
                    UNTIL LPurchRcptLine.Next() = 0;
                IF LIncVATAmount <> 0 THEN BEGIN
                    GGenJnlLn.INIT();
                    GGenJnlLn."Source Code" := GGLSetup."ST INR Source Code";
                    GGenJnlLn."Posting Date" := PDateLCompta;
                    GGenJnlLn."System-Created Entry" := TRUE;
                    GGenJnlLn."Document No." := GNumDom;
                    GGenJnlLn."Account Type" := GGenJnlLn."Account Type"::"G/L Account";
                    GGenJnlLn.Validate("Account No.", LVendorPostingGroup."ST Accrual Account");
                    GGenJnlLn.Description := TEXT008 + ' ' + LPurchRcptHeader."No." + '/' +
                                 LPurchRcptHeader."Buy-from Vendor No.";
                    GGenJnlLn."External Document No." := LPurchRcptHeader."No.";
                    GGenJnlLn.VALIDATE(GGenJnlLn.Amount, LIncVATAmount);
                    GGenJnlLn."Source Type" := GGenJnlLn."Source Type"::Vendor;
                    GGenJnlLn."Source No." := LPurchRcptHeader."Buy-from Vendor No.";
                    GGenJnlLn."ST PR Date" := LPurchRcptHeader."Posting Date";
                    GGenJnlLn."ST Accrual" := TRUE;
                    GGenJnlLn.VALIDATE("Dimension Set ID", LPurchRcptHeader."Dimension Set ID");
                    GGenJnlLn."Shortcut Dimension 1 Code" := LPurchRcptHeader."Shortcut Dimension 1 Code";
                    GGenJnlLn."Shortcut Dimension 2 Code" := LPurchRcptHeader."Shortcut Dimension 2 Code";
                    GGenJnlPostLn.RunWithCheck(GGenJnlLn);
                    Apply(LVendorPostingGroup."ST Accrual Account", GGLSetup."ST INR Source Code", LVendorPostingGroup."ST Accrual Account");
                END;
            UNTIL LPurchRcptHeader.Next() = 0;
    end;

    procedure Apply(PAccountNo: Code[20]; PSourceCode: Code[10]; PVendorPostGrpAccrualAccount: Code[20]);
    begin
        GNumSeq := 0;
        GetLetterFNP(PAccountNo, GLetterToSet);
        GGLSetup.Get();
        GGLEntry.SetCurrentKey("G/L Account No.", "Source Code", "Journal Batch Name", letter, Amount);
        GGLEntry.SetFilter("G/L Account No.", PAccountNo);
        GGLEntry.SetFilter("Source Code", PSourceCode);
        GGLEntry.SetFilter("Journal Batch Name", '%1', '');
        GGLEntry.SetFilter(Letter, '=%1', '');
        IF PAccountNo = PVendorPostGrpAccrualAccount THEN
            GGLEntry.SetFilter(Amount, '<%1', 0)
        else
            GGLEntry.SetFilter(Amount, '>%1', 0);
        IF GGLEntry.FindFirst() THEN
            REPEAT
                GGLEntry1.SetCurrentKey("G/L Account No.", "Source Code", "Journal Batch Name", "External Document No.", "Source No.", Amount);
                GGLEntry1.SETFILTER("Entry No.", '>%1', GNumSeq);
                GGLEntry1.SETFILTER("G/L Account No.", GGLEntry."G/L Account No.");
                GGLEntry1.SETFILTER("Source Code", PSourceCode);
                GGLEntry1.SETFILTER("Journal Batch Name", '=%1', '');
                GGLEntry1.SETFILTER(Letter, '=%1', '');
                GGLEntry1.SETFILTER("External Document No.", GGLEntry."External Document No.");
                GGLEntry1.SETFILTER("Source No.", GGLEntry."Source No.");
                GGLEntry1.SETRANGE(Amount, -GGLEntry.Amount);
                IF GGLEntry1.FINDFIRST() THEN BEGIN
                    GGLEntry.Letter := GLetterToSet;
                    GGLEntry."Letter Date" := WORKDATE();
                    GGLEntry.MODIFY();
                    GNumSeq := GGLEntry1."Entry No.";
                    GGLEntry1.Letter := GLetterToSet;
                    GGLEntry1."Letter Date" := WORKDATE();
                    GGLEntry1.MODIFY();
                END;
            UNTIL GGLEntry.NEXT() = 0;
    end;

    procedure GetLetterFNP(PCodLAccountNum: Code[20]; VAR PLetterSet: Text[8]);

    begin
        IF PLetterSet <> '' THEN
            EXIT;
        GgLEntry2.SETFILTER("G/L Account No.", PCodLAccountNum);
        GGLEntry2.SETCURRENTKEY("G/L Account No.", Letter);
        IF GGLEntry2.FINDLAST() THEN
            PLetterSet := GGLEntry2.Letter;
        IF GGLEntry2.FINDLAST() THEN
            IF PLetterSet < UPPERCASE(GGLEntry2.Letter) THEN
                PLetterSet := UPPERCASE(GGLEntry2.Letter);
        NextLetter(PLetterSet);
    end;

    procedure SetParameters(PPostingDate: Date; PPostingDocNo: Code[20]; PReceiptNo: Code[20]; PReceiptLineNo: integer);
    begin
        GDatGCompta := PPostingDate;
        GPurchaseReceiptNo := PReceiptNo;
        GAutomaticExecution := true;
        GPurchaseReceiptLineNo := PReceiptLineNo;
        GPostingDocNo := PPostingDocNo;
    end;

    procedure NextLetter(VAR Letter: Text[8]);
    var
        i: Integer;
    begin
        IF Letter = 'ZZZZZZZZ' THEN
            EXIT;
        IF (Letter = '') OR (STRLEN(Letter) = 3) THEN BEGIN
            Letter := 'AAAAAAAA';
            EXIT;
        END;
        IF Letter[8] <> 'Z' THEN BEGIN
            i := Letter[8];
            i := i + 1;
            Letter[8] := i;
        END ELSE
            IF Letter[7] <> 'Z' THEN BEGIN
                i := Letter[7];
                i := i + 1;
                Letter[7] := i;
                Letter[8] := 'A';
            END ELSE

                IF Letter[6] <> 'Z' THEN BEGIN
                    i := Letter[6];
                    i := i + 1;
                    Letter[6] := i;
                    Letter[7] := 'A';
                END ELSE


                    IF Letter[5] <> 'Z' THEN BEGIN
                        i := Letter[5];
                        i := i + 1;
                        Letter[5] := i;
                        Letter[6] := 'A';
                    END ELSE


                        IF Letter[4] <> 'Z' THEN BEGIN
                            i := Letter[4];
                            i := i + 1;
                            Letter[4] := i;
                            Letter[5] := 'A';
                        END ELSE


                            IF Letter[3] <> 'Z' THEN BEGIN
                                i := Letter[2];
                                i := i + 1;
                                Letter[3] := i;
                                Letter[4] := 'A';


                            END ELSE
                                IF Letter[2] <> 'Z' THEN BEGIN
                                    i := Letter[2];
                                    i := i + 1;
                                    Letter[2] := i;
                                    Letter[3] := 'A';
                                END ELSE BEGIN
                                    i := Letter[1];
                                    i := i + 1;
                                    Letter[1] := i;
                                    Letter[2] := 'A';
                                    Letter[3] := 'A';
                                    Letter[4] := 'A';
                                    Letter[5] := 'A';
                                    Letter[6] := 'A';
                                    Letter[7] := 'A';
                                    Letter[8] := 'A';
                                END;

    end;

    procedure GenerateFNP(PDateLCompta: date);
    var
        LPurchRcptHeader: Record "Purch. Rcpt. Header";
        LPurchRcptLine: Record "Purch. Rcpt. Line";
        lpurchInvLine: Record "Purch. Inv. Line";
        LIncVATAmount: Decimal;
        LExcVATAmount: Decimal;
        LQuantity: Decimal;
        LOldInvQty: Decimal;
        LNewDoc: Boolean;
        LVendor: Record Vendor;
        LVendorPostingGroup: Record "Vendor Posting Group";
        LDiscLineAmt: Decimal;
        LAmount: Decimal;
        LCostCenter: Code[20];
        LDimensionManagement: Codeunit DimensionManagement;
    begin
        GGLSetup.GET(GGLSetup."Primary Key");
        GCurrency.RESET();
        GCurrency.InitRoundingPrecision();
        //GINRTransaction := GINIINRPstdLines.GetLastTransaction(0);
        LPurchRcptHeader.RESET();
        LPurchRcptHeader.SETRANGE(LPurchRcptHeader."Posting Date", 0D, PDateLCompta);
        IF GPurchaseReceiptNo <> '' THEN
            LPurchRcptHeader.SETFILTER("No.", '%1', GPurchaseReceiptNo);
        IF LPurchRcptHeader.Findfirst() THEN
            REPEAT
                LIncVATAmount := 0;
                LNewDoc := TRUE;
                Window.Update(3, LPurchRcptHeader."No.");
                LPurchRcptLine.RESET();
                LPurchRcptLine.SetFilter("Document No.", LPurchRcptHeader."No.");
                LPurchRcptLine.SetFilter(LPurchRcptLine.Type, '<>%1&<>%2', LPurchRcptLine.Type::" ", LPurchRcptLine.Type::"Fixed Asset");
                LPurchRcptLine.SetRange(LPurchRcptLine.Correction, False);
                LPurchRcptLine.SetFilter("ST Last Invoice Date", '%1|>=%2', 0D, PDateLCompta);
                IF GPurchaseReceiptLineNo <> 0 then
                    LPurchRcptLine.SetRange("Line No.", GPurchaseReceiptLineNo);
                IF LPurchRcptLine.Findfirst() then
                    REPEAT
                        IF ((LPurchRcptLine.Quantity - LPurchRcptLine."Quantity Invoiced") <> 0)
                         OR (((LPurchRcptLine.Quantity - LPurchRcptLine."Quantity Invoiced") = 0) AND (LPurchRcptLine."ST Last Invoice Date" > PDateLCompta))
                         THEN BEGIN
                            LQuantity := LPurchRcptLine.Quantity - LPurchRcptLine."Quantity Invoiced";
                            IF (LPurchRcptLine."ST Last Invoice Date" > PDateLCompta) AND (LPurchRcptLine."ST Last Invoice Date" <> 0D) THEN begin
                                LOldInvQty := 0;
                                lpurchInvLine.SetRange("Receipt No.", LPurchRcptLine."Document No.");
                                lpurchInvLine.SetRange("Receipt Line No.", LPurchRcptLine."Line No.");
                                lpurchInvLine.SetFilter("Posting Date", '<=%1', GDatGCompta);
                                if lpurchInvLine.FindSet() then begin
                                    repeat
                                        LOldInvQty := LOldInvQty + lpurchInvLine.Quantity;
                                    until lpurchInvLine.Next() = 0;
                                    LQuantity := LPurchRcptLine.Quantity - LOldInvQty;
                                end;
                            end;

                            IF LPurchRcptLine.Type = LPurchRcptLine.Type::Item THEN BEGIN
                                GItem.GET(LPurchRcptLine."No.");
                                GGenPostSetup.GET(LPurchRcptLine."Gen. Bus. Posting Group", GItem."Gen. Prod. Posting Group");
                            END ELSE
                                GGenPostSetup.GET(LPurchRcptLine."Gen. Bus. Posting Group", LPurchRcptLine."Gen. Prod. Posting Group");
                            LAmount := ROUND((LPurchRcptLine."Direct Unit Cost" * LQuantity * (1 - LPurchRcptLine."Line Discount %" / 100)), GCurrency."Amount Rounding Precision");
                            IF LPurchRcptHeader."Currency Factor" <> 0 THEN
                                LAmount := ROUND(LAmount / LPurchRcptHeader."Currency Factor", GCurrency."Amount Rounding Precision");
                            GGenJnlLn.INIT();
                            GGenJnlLn."Source Code" := GGLSetup."ST INR Source Code";
                            GGenJnlLn."Posting Date" := PDateLCompta;
                            GGenJnlLn."System-Created Entry" := TRUE;
                            IF GPostingDocNo <> '' THEN
                                GNumDom := GPostingDocNo
                            ELSE

                                IF LNewDoc THEN BEGIN
                                    GNumDom := GNoSeriesMgt.GetNextNo(GGLSetup."ST INR Series", PDateLCompta, TRUE);
                                    LNewDoc := FALSE;
                                END;
                            GGenJnlLn."Document No." := GNumDom;
                            GGenJnlLn."Account Type" := GGenJnlLn."Account Type"::"G/L Account";
                            GGenPostSetup.TestField("Purch. Account");
                            GGenJnlLn.Validate(GGenJnlLn."Account No.", GGenPostSetup."Purch. Account");
                            GGenJnlLn.Description := TEXT007 + LPurchRcptLine."Document No." + '/' + LPurchRcptLine."Buy-from Vendor No.";
                            GGenJnlLn."External Document No." := LPurchRcptLine."Document No.";
                            GGenJnlLn.Validate(GGenJnlLn.Amount, LAmount);
                            GGenJnlLn."Source Type" := GGenJnlLn."Source Type"::Vendor;
                            GGenJnlLn."Source No." := LPurchRcptLine."Buy-from Vendor No.";
                            GGenJnlLn.Validate("Dimension Set ID", LPurchRcptLine."Dimension Set ID");
                            GGenJnlLn."Shortcut Dimension 1 Code" := LPurchRcptLine."Shortcut Dimension 1 Code";
                            GGenJnlLn."Shortcut Dimension 2 Code" := LPurchRcptLine."Shortcut Dimension 2 Code";
                            GGenJnlPostLn.RunWithCheck(GGenJnlLn);
                            LPurchRcptLine."ST INR Quantity" := LQuantity;
                            LPurchRcptLine."ST INR Amount" := LAmount;
                            LPurchRcptLine.Modify();
                            //GINIINRPstdLines.InsertINRPostedLine(LPurchRcptLine, PDateLCompta, GNumDom, GINRTransaction);
                            IF GMethodAmount = GMethodAmount::"Amount HT" then
                                LIncVATAmount := LIncVATAmount + LAmount;
                        END;
                    UNTIL LPurchRcptLine.Next() = 0;
                IF LIncVATAmount <> 0 THEN BEGIN
                    GGenJnlLn.INIT();
                    GGenJnlLn."Source Code" := GGLSetup."ST INR Source Code";
                    GGenJnlLn."Posting Date" := PDateLCompta;
                    GGenJnlLn."System-Created Entry" := TRUE;
                    GGenJnlLn."Document No." := GNumDom;
                    GGenJnlLn."Account Type" := GGenJnlLn."Account Type"::"G/L Account";
                    IF lVendor.GET(LPurchRcptHeader."Buy-from Vendor No.") THEN
                        IF lVendorPostingGroup.GET(lVendor."Vendor Posting Group") THEN BEGIN
                            lVendorPostingGroup.TESTFIELD("ST Accrual Account");
                            GGenJnlLn.VALIDATE("Account No.", lVendorPostingGroup."ST Accrual Account");
                        END;
                    GGenJnlLn.Description := TEXT007 + ' ' + LPurchRcptHeader."No." + '/' +
                                  LPurchRcptHeader."Buy-from Vendor No.";
                    GGenJnlLn."External Document No." := LPurchRcptHeader."No.";
                    GGenJnlLn.VALIDATE(GGenJnlLn.Amount, -LIncVATAmount);
                    GGenJnlLn."Source Type" := GGenJnlLn."Source Type"::Vendor;
                    GGenJnlLn."Source No." := LPurchRcptHeader."Buy-from Vendor No.";
                    GGenJnlLn."ST PR Date" := LPurchRcptHeader."Posting Date";
                    GGenJnlLn."ST Accrual" := TRUE;
                    GGenJnlLn.VALIDATE("Dimension Set ID", LPurchRcptHeader."Dimension Set ID");
                    GGenJnlLn."Shortcut Dimension 1 Code" := LPurchRcptHeader."Shortcut Dimension 1 Code";
                    GGenJnlLn."Shortcut Dimension 2 Code" := LPurchRcptHeader."Shortcut Dimension 2 Code";
                    GGenJnlPostLn.RunWithCheck(GGenJnlLn);
                END;

            UNTIL LPurchRcptHeader.NEXT() = 0;
    end;

}