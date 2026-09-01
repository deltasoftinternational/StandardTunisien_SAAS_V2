codeunit 70003 "ST Sales&PurchaseHook"
{
    procedure SalesPostTimbre(VAR SalesHeader: Record "Sales Header"; GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; GenJOurnalLine: Record "Gen. Journal Line")

    var
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        CustomerPostingGroup: Record "Customer Posting Group";
        SrcCode: code[10];
        CompteTimbre: Code[20];
        MntTimbre: Decimal;
        ishandle: Boolean;
    begin

        SourceCodeSetup.GET();
        SrcCode := SourceCodeSetup.Sales;

        //Replace Fct CalcTimbre Here
        CustomerPostingGroup.GET(SalesHeader."Customer Posting Group");
        IF SalesHeader."STApply Stamp Fiscal" THEN BEGIN
            CustomerPostingGroup.TestField("STApply Stamp Fiscal"); //MMOK
            CustomerPostingGroup.TESTFIELD("STStamp Fiscal Account");

            onbeforesalesamountstamp(MntTimbre, SalesHeader, ishandle);

            if not ishandle then begin
                CustomerPostingGroup.TESTFIELD("STStamp Fiscal Amount");
                MntTimbre := 0;
                MntTimbre := CustomerPostingGroup."STStamp Fiscal Amount";
            end;

            CompteTimbre := CustomerPostingGroup."STStamp Fiscal Account";


            IF (MntTimbre <> 0) THEN BEGIN

                GenJnlLine.INIT();
                GenJnlLine."Posting Date" := SalesHeader."Posting Date";
                GenJnlLine."Document Date" := SalesHeader."Document Date";
                GenJnlLine.Description := SalesHeader."Posting Description";
                GenJnlLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := SalesHeader."Shortcut Dimension 2 Code";
                GenJnlLine."Reason Code" := SalesHeader."Reason Code";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := CompteTimbre;
                GenJnlLine."Document Type" := GenJOurnalLine."Document Type"; //MMOK
                GenJnlLine."Document No." := GenJOurnalLine."Document No."; //MMOK 
                GenJnlLine."External Document No." := SalesHeader."External Document No."; //MMOK
                GenJnlLine."Currency Code" := SalesHeader."Currency Code";
                IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
                    GenJnlLine.Amount := MntTimbre;
                    GenJnlLine."Source Currency Code" := GenJnlLine."Currency Code";
                    GenJnlLine."Source Currency Amount" := MntTimbre;
                    GenJnlLine."Amount (LCY)" := MntTimbre;
                END
                ELSE BEGIN
                    GenJnlLine.Amount := -MntTimbre;
                    GenJnlLine."Source Currency Code" := GenJnlLine."Currency Code";
                    GenJnlLine."Source Currency Amount" := -MntTimbre;
                    GenJnlLine."Amount (LCY)" := -MntTimbre;
                END;
                IF GenJnlLine."Currency Code" = '' THEN
                    GenJnlLine."Currency Factor" := 1
                ELSE
                    GenJnlLine."Currency Factor" := GenJnlLine."Currency Factor";
                GenJnlLine.Correction := GenJnlLine.Correction; //FIXME:
                GenJnlLine."Sales/Purch. (LCY)" := 0;
                GenJnlLine."Profit (LCY)" := 0;
                GenJnlLine."Inv. Discount (LCY)" := 0;
                GenJnlLine."Sell-to/Buy-from No." := SalesHeader."Sell-to Customer No.";
                GenJnlLine."Bill-to/Pay-to No." := SalesHeader."Bill-to Customer No.";
                GenJnlLine."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
                GenJnlLine."System-Created Entry" := TRUE;
                GenJnlLine."On Hold" := GenJnlLine."On Hold"; //FIXME:
                GenJnlLine."Allow Application" := GenJnlLine."Bal. Account No." = '';
                GenJnlLine."Due Date" := SalesHeader."Due Date";
                GenJnlLine."Payment Terms Code" := SalesHeader."Payment Terms Code";
                GenJnlLine."Source Type" := GenJnlLine."Source Type"::Customer;
                GenJnlLine."Source No." := SalesHeader."Bill-to Customer No.";
                GenJnlLine."Source Code" := SrcCode;
                GenJnlLine."Posting No. Series" := SalesHeader."Posting No. Series";
                //GenJnlLine."Vehicle Serial No." := TempInvoicePostBuffer."Vehicle Serial No.";
                // GenJnlLine."Vehicle Accounting Cycle No." := TempInvoicePostBuffer."Vehicle Accounting Cycle No.";
                SalesPostTimbreOnbeforeRunwithCheck(GenJnlLine, SalesHeader);
                GenJnlPostLine.RunWithCheck(GenJnlLine);
            END;
        END;
    end;

    procedure PurchPostTimbre(VAR PurchaseHeader: Record "Purchase Header"; GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        VendorPostingGroup: Record "Vendor Posting Group";
        SrcCode: code[10];
        CompteTimbre: Code[20];
        MntTimbre: Decimal;
        ishandle: Boolean;
    begin

        SourceCodeSetup.GET();
        SrcCode := SourceCodeSetup.Purchases;


        VendorPostingGroup.GET(PurchaseHeader."Vendor Posting Group");
        IF PurchaseHeader."STApply Stamp Fiscal" THEN BEGIN
            VendorPostingGroup.TestField("STApply Stamp Fiscal"); //MMOK            
            VendorPostingGroup.TESTFIELD("STStamp Fiscal Account");
            onbeforePurchamountstamp(MntTimbre, CompteTimbre, PurchaseHeader, ishandle);

            if not ishandle then begin
                VendorPostingGroup.TESTFIELD("STStamp Fiscal Amount"); //MMOK
                MntTimbre := 0;
                MntTimbre := VendorPostingGroup."STStamp Fiscal Amount";
                CompteTimbre := VendorPostingGroup."STStamp Fiscal Account";
            end;

            IF (MntTimbre <> 0) THEN BEGIN


                GenJnlLine.INIT();
                GenJnlLine."Posting Date" := PurchaseHeader."Posting Date";
                GenJnlLine."Document Date" := PurchaseHeader."Document Date";
                GenJnlLine.Description := PurchaseHeader."Posting Description";
                GenJnlLine."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code"; //FIXME:
                GenJnlLine."Shortcut Dimension 2 Code" := PurchaseHeader."Shortcut Dimension 2 Code"; //FIXME:
                GenJnlLine."Dimension Set ID" := PurchaseHeader."Dimension Set ID";
                GenJnlLine."Reason Code" := GenJnlLine."Reason Code"; //FIXME:
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                GenJnlLine."Account No." := CompteTimbre;
                GenJnlLine."Document Type" := GenJournalLine."Document Type";
                GenJnlLine."Document No." := GenJournalLine."Document No.";
                GenJnlLine."External Document No." := GenJournalLine."External Document No.";
                GenJnlLine."Currency Code" := GenJnlLine."Currency Code"; //FIXME:
                GenJnlLine.Amount := MntTimbre;
                GenJnlLine."Source Currency Code" := GenJnlLine."Currency Code";
                IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"invoice" THEN BEGIN
                    GenJnlLine.Amount := Mnttimbre;
                    GenJnlLine."Source Currency Amount" := MntTimbre;
                    GenJnlLine."Amount (LCY)" := MntTimbre;
                end
                else
                    IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
                        GenJnlLine.Amount := -Mnttimbre;
                        GenJnlLine."Source Currency Amount" := -MntTimbre;
                        GenJnlLine."Amount (LCY)" := -MntTimbre;
                    end;
                IF PurchaseHeader."Currency Code" = '' THEN
                    GenJnlLine."Currency Factor" := 1
                ELSE
                    GenJnlLine."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJnlLine.Correction := GenJnlLine.Correction; //FIXME:
                GenJnlLine."Sales/Purch. (LCY)" := 0;
                GenJnlLine."Profit (LCY)" := 0;
                GenJnlLine."Inv. Discount (LCY)" := 0;
                GenJnlLine."Sell-to/Buy-from No." := PurchaseHeader."Buy-from Vendor No.";
                GenJnlLine."Bill-to/Pay-to No." := PurchaseHeader."Pay-to Vendor No.";
                GenJnlLine."Salespers./Purch. Code" := PurchaseHeader."Purchaser Code";
                GenJnlLine."System-Created Entry" := TRUE;
                GenJnlLine."On Hold" := GenJnlLine."On Hold"; //FIXME:
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"; //FIXME:
                GenJnlLine."Applies-to Doc. No." := GenJnlLine."Applies-to Doc. No."; //FIXME:
                GenJnlLine."Applies-to ID" := GenJnlLine."Applies-to ID"; //FIXME:
                GenJnlLine."Allow Application" := GenJnlLine."Bal. Account No." = '';
                GenJnlLine."Due Date" := GenJnlLine."Due Date"; //FIXME:
                GenJnlLine."Payment Terms Code" := GenJnlLine."Payment Terms Code"; //FIXME:
                GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
                GenJnlLine."Source No." := PurchaseHeader."Pay-to Vendor No.";
                GenJnlLine."Source Code" := SrcCode;
                GenJnlLine."Posting No. Series" := GenJnlLine."Posting No. Series"; //FIXME:
                                                                                    // GenJnlLine."Vehicle Serial No." := InvPostingBuffer[1]."Vehicle Serial No.";
                PurchPostTimbreOnbeforeRunwithCheck(GenJnlLine, PurchaseHeader);                                                                  //GenJnlLine."Vehicle Accounting Cycle No." := InvPostingBuffer[1]."Vehicle Accounting Cycle No.";
                GenJnlPostLine.RunWithCheck(GenJnlLine);
            end
        END;

    END;

    [IntegrationEvent(false, false)]
    local procedure SalesPostTimbreOnbeforeRunwithCheck(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure PurchPostTimbreOnbeforeRunwithCheck(var GenJnlLine: Record "Gen. Journal Line"; var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure onbeforesalesamountstamp(var stamp: decimal; SalesHeader: Record "Sales Header"; var ishandle: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure onbeforePurchamountstamp(var stamp: decimal; var comptimbre: code[20]; PurchHeader: Record "Purchase Header"; var ishandle: Boolean)
    begin
    end;
}