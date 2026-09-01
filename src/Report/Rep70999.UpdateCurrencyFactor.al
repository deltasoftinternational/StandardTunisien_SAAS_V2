report 71999 "Update Currency Factor"
{
    ApplicationArea = Hide;
    Caption = 'Mise à jour taux de change facture achat enregistrée';

    UsageCategory = Tasks;
    ProcessingOnly = true;
    Permissions = TableData "Vendor Ledger Entry" = m, TableData "Detailed Vendor Ledg. Entry" = m,
                  TableData "G/L Entry" = m, tabledata "Purch. Inv. Header" = m;
    dataset
    {

        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = WHERE("Document type" = FILTER(invoice));
            RequestFilterFields = "Document No.";

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemTableView = sorting("Vendor Ledger Entry No.", "Posting Date") WHERE("Document type" = FILTER(invoice), "Entry Type" = filter("Initial entry"));
                DataItemLink = "Vendor Ledger Entry No." = field("Entry No.");

                trigger OnPreDataItem()
                begin
                    IF NewFactor = 0 THEN ERROR('Le nouveau taux de change ne peut pas être égal à zéro');
                end;

                trigger OnAfterGetRecord()
                begin
                    "Detailed Vendor Ledg. Entry"."Amount (LCY)" := ("Detailed Vendor Ledg. Entry"."Amount (LCY)" * OldFactor) * NewFactor;
                    "Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" := ("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" * OldFactor) * NewFactor;
                    "Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" := ("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" * OldFactor) * NewFactor;
                    "Detailed Vendor Ledg. Entry".modify();
                end;

            }


            dataitem("G/L Entry"; "G/L Entry")
            {

                DataItemTableView = sorting("Document Type", "Document No.") WHERE("Document type" = FILTER(invoice));
                DataItemLink = "Document No." = field("Document No.");
                trigger OnAfterGetRecord()
                begin

                    "G/L Entry".Amount := ("G/L Entry".Amount * OldFactor) * NewFactor;
                    "G/L Entry"."Debit Amount" := ("G/L Entry"."Debit Amount" * OldFactor) * NewFactor;
                    "G/L Entry"."Credit Amount" := ("G/L Entry"."Credit Amount" * OldFactor) * NewFactor;

                    "G/L Entry".MODIFY();


                end;

            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {

                DataItemTableView = sorting("no.");
                DataItemLink = "No." = field("Document No.");
                trigger OnAfterGetRecord()
                begin


                    "Purch. Inv. Header"."Currency Factor" := 1 / NewFactor;
                    "Purch. Inv. Header".MODIFY();


                end;

                trigger OnPostDataItem()
                begin
                    if DifferenceLCY <> 0 then
                        CreatePurchInvHeader("Vendor Ledger Entry", DifferenceLCY)
                end;

            }

            trigger OnPreDataItem()
            begin
                if GetFilter("Document No.") = '' then
                    Error('Merci de séléctionner un document de  facture achat enregistrée');
            end;

            trigger OnAfterGetRecord()
            begin

                OldFactor := "Vendor Ledger Entry"."Original Currency Factor";
                OldAmountLCY := -"Vendor Ledger Entry"."Purchase (LCY)";
                "Vendor Ledger Entry"."Purchase (LCY)" := ("Vendor Ledger Entry"."Purchase (LCY)" * OldFactor) * NewFactor;
                NewAmountLCY := -"Vendor Ledger Entry"."Purchase (LCY)";
                DifferenceLCY := NewAmountLCY - OldAmountLCY;
                "Vendor Ledger Entry"."Original Currency Factor" := 1 / NewFactor;
                "Vendor Ledger Entry".MODIFY();

            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Setup)
                {
                    field(NewFactor; NewFactor)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }


    }


    var
        CurrencyFactor: Decimal;
        OldAmountLCY: Decimal;
        NewAmountLCY: Decimal;
        DifferenceLCY: Decimal;
        OldFactor: Decimal;
        NewFactor: Decimal;
        Currency: Record Currency;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        NoSeriesMgt: Codeunit "No. Series";
        PurchPost: Codeunit "Purch.-Post";



    Procedure CreatePurchInvHeader(VLE: Record "Vendor Ledger Entry"; AmountLCY: Decimal)
    Var
        PurchInvcHdr: Record "Purchase Header";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchInvLine: Record "Purch. Inv. Line";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PurchaseReceiptBuffer: Record "Purch. Rcpt. Header" temporary;
        ReceiptNoTextFilter: Text;
    begin
        PurchasesPayablesSetup.GET();
        PurchasesPayablesSetup.TESTFIELD("Vendor Cur. Factor Adj");
        PurchasesPayablesSetup.TESTFIELD("Item Charge Cur. Factor Adj");
        Vendor.GET(PurchasesPayablesSetup."Vendor Cur. Factor Adj");

        IF (AmountLCY = 0) THEN
            EXIT;


        IF PurchInvcHdr."No." = '' THEN BEGIN
            PurchInvcHdr.INIT();
            If AmountLCY > 0 then
                PurchInvcHdr."Document Type" := PurchInvcHdr."Document Type"::Invoice
            else
                PurchInvcHdr."Document Type" := PurchInvcHdr."Document Type"::"Credit Memo";
            //PurchInvcHdr."Deal Type Code" := TransferHeader."Deal Type Code";
            //PurchInvcHdr."Document Profile" := TransferHeader."Document Profile"::"Vehicles Trade";
            //PurchInvcHdr."No." := VLE."document No.";

            IF PurchInvcHdr.INSERT(TRUE) THEN BEGIN
                IF PurchInvcHdr."Document Type" = PurchInvcHdr."Document Type"::Invoice THEN Begin

                    PurchInvcHdr.Receive := TRUE;
                    PurchInvcHdr.Invoice := TRUE;
                    PurchInvcHdr."Vendor Invoice No." := PurchInvcHdr."No.";
                End
                else begin
                    PurchInvcHdr.ship := TRUE;
                    PurchInvcHdr.Invoice := TRUE;
                    PurchInvcHdr."Vendor Cr. Memo No." := PurchInvcHdr."No.";
                end;


                PurchInvcHdr.TESTFIELD("Posting No. Series");
                PurchInvcHdr."Posting No." := NoSeriesMgt.GetNextNo(PurchInvcHdr."Posting No. Series", PurchInvcHdr."Posting Date", TRUE);
                //PurchInvcHdr."Auto Created Doc" := TRUE;
                PurchInvcHdr."Posting Date" := VLE."Posting Date";
                PurchInvcHdr."Document Date" := VLE."Posting Date";
                PurchInvcHdr.VALIDATE("Buy-from Vendor No.", Vendor."No.");
                PurchInvcHdr."Prices Including VAT" := FALSE;
                PurchInvcHdr.MODIFY();
            END;
        END;

        CreatePurchInvLine(VLE, PurchInvcHdr, PurchLine, Abs(AmountLCY), PurchasesPayablesSetup."Item Charge Cur. Factor Adj");
        PurchInvLine.SetRange("Document No.", VLE."Document No.");
        PurchInvLine.SetFilter("Receipt No.", '<>%1', '');
        if PurchInvLine.FindFirst() then Begin
            repeat
                //ReceiptNo := PurchInvLine."Receipt No.";
                PurchaseReceiptBuffer.Init();
                PurchaseReceiptBuffer."No." := PurchInvLine."Receipt No.";
                If PurchaseReceiptBuffer.Insert() then;
            until PurchInvLine.next() = 0;
            ReceiptNoTextFilter := 'A';
            IF PurchaseReceiptBuffer.FindFirst() then
                repeat
                    ReceiptNoTextFilter := ReceiptNoTextFilter + '|' + PurchaseReceiptBuffer."No.";
                until PurchaseReceiptBuffer.Next() = 0;

        end
        else begin
            ValueEntry.SetRange("Document No.", VLE."Document No.");
            IF ValueEntry.FindFirst() then
                IF ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                    ReceiptNoTextFilter := ItemLedgerEntry."Document No.";

        end;

        CreateItemChargeAssgnt(PurchInvcHdr, PurchLine, ReceiptNoTextFilter);

        PurchHeader.SetRange("No.", PurchInvcHdr."No.");
        IF PurchHeader.FindFirst() Then
            if PurchHeader."No." <> '' then begin

                Codeunit.Run(Codeunit::"Release Purchase Document", PurchHeader);
                PurchPost.Run(PurchHeader);

            end;

    end;




    Procedure CreatePurchInvLine(VLE: Record "Vendor Ledger Entry"; VAR PurchInvcHdr: Record "Purchase Header"; var PurchInvcLine: Record "Purchase Line"; pAmount: Decimal; ItemChargeNo: Code[20])
    Var

        ItemCharge: record "item charge";
        PostPurchInvc: Boolean;
        ChApplyToDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Transfer Receipt","Return Shipment","Sales Shipment","Return Receipt";
        ChApplyToDocNo: Code[20];
        ChApplyToLineNo: Integer;
        ChApplyToItemNo: Code[20];


    Begin
        PurchInvcLine.INIT();
        PurchInvcLine.VALIDATE("Document Type", PurchInvcHdr."Document Type");
        PurchInvcLine.VALIDATE("Document No.", PurchInvcHdr."No.");
        PurchInvcLine."Line No." := 10000;
        //"Document Profile" := PurchInvcHdr."Document Profile";
        //VALIDATE("Line Type", "Line Type"::"Charge (Item)");
        PurchInvcLine.VALIDATE(Type, PurchInvcLine.Type::"Charge (Item)");
        PurchInvcLine.VALIDATE("No.", ItemChargeNo);
        ItemCharge.GET(ItemChargeNo);
        //VALIDATE("Posting Group", ItemCharge."Inventory Posting Group");
        PurchInvcLine.VALIDATE(Quantity, 1);
        PurchInvcLine.VALIDATE("Buy-from Vendor No.", PurchInvcHdr."Buy-from Vendor No.");
        PurchInvcLine.VALIDATE("Direct Unit Cost", pAmount);
        PurchInvcLine."System-Created Entry" := TRUE;
        //"Deal Type Code" := TransferHeader."Deal Type Code";
        PurchInvcLine.Description := 'AJustement Taux de change';
        PurchInvcLine."Location Code" := PurchInvcHdr."Location Code";
        PurchInvcLine.VALIDATE("Dimension Set ID", VLE."Dimension Set ID");
        //         "Vehicle Serial No." := TransferLine."Vehicle Serial No.";
        //         "Vehicle Accounting Cycle No." := TransferLine."Vehicle Accounting Cycle No.";

        PurchInvcLine.INSERT(TRUE);
    End;



    procedure CreateItemChargeAssgnt(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line"; ReceiptNo: Text)
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        FromPurchRcptLine: Record "Purch. Rcpt. Line";
        AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
        ItemChargeAssgnts: Page "Item Charge Assignment (Purch)";
        ItemChargeAssgntLineAmt: Decimal;
        IsHandled: Boolean;
        Currency: Record Currency;
        Selection: Integer;
        SelectionTxt: Text;
        SuggestItemChargeMenuTxt: Text;
        EquallyTok: Label 'Répartir';
        ByAmountTok: Label 'par montant';
        ByWeightTok: Label 'par poids';
        ByVolumeTok: Label 'par Volume';
        ItemChargeAssignedMenu4Lbl: Label '%1,%2,%3,%4', Locked = true;

    begin
        //Get("Document Type", "Document No.", "Line No.");





        if PurchHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision()
        else
            Currency.Get(PurchHeader."Currency Code");
        if (PurchLine."Inv. Discount Amount" = 0) and
           (PurchLine."Line Discount Amount" = 0) and
           (not PurchHeader."Prices Including VAT")
        then
            ItemChargeAssgntLineAmt := PurchLine."Line Amount"
        else
            if PurchHeader."Prices Including VAT" then
                ItemChargeAssgntLineAmt :=
                  Round(PurchLine.CalcLineAmount() / (1 + PurchLine."VAT %" / 100), Currency."Amount Rounding Precision")
            else
                ItemChargeAssgntLineAmt := PurchLine.CalcLineAmount();

        ItemChargeAssgntPurch.Reset();
        ItemChargeAssgntPurch.SetRange("Document Type", PurchLine."Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", PurchLine."Document No.");
        ItemChargeAssgntPurch.SetRange("Document Line No.", PurchLine."Line No.");
        ItemChargeAssgntPurch.SetRange("Item Charge No.", PurchLine."No.");
        if not ItemChargeAssgntPurch.FindLast() then begin
            ItemChargeAssgntPurch."Document Type" := PurchLine."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchLine."Document No.";
            ItemChargeAssgntPurch."Document Line No." := PurchLine."Line No.";
            ItemChargeAssgntPurch."Item Charge No." := PurchLine."No.";
            ItemChargeAssgntPurch."Unit Cost" :=
              Round(ItemChargeAssgntLineAmt / PurchLine.Quantity,
                Currency."Unit-Amount Rounding Precision");
        end;

        IsHandled := false;

        if not IsHandled then
            ItemChargeAssgntLineAmt :=
                Round(ItemChargeAssgntLineAmt * (PurchLine."Qty. to Invoice" / PurchLine.Quantity), Currency."Amount Rounding Precision");



        FromPurchRcptLine.SetFilter("Document No.", ReceiptNo);
        IF FromPurchRcptLine.FindFirst() then
            AssignItemChargePurch.CreateRcptChargeAssgnt(FromPurchRcptLine, ItemChargeAssgntPurch);


        Selection := 2;
        SuggestItemChargeMenuTxt :=
              StrSubstNo(ItemChargeAssignedMenu4Lbl, AssignItemChargePurch.AssignEquallyMenuText(), AssignItemChargePurch.AssignByAmountMenuText(), AssignItemChargePurch.AssignByWeightMenuText(), AssignItemChargePurch.AssignByVolumeMenuText());
        SelectionTxt := SelectStr(Selection, SuggestItemChargeMenuTxt);
        AssignItemChargePurch.AssignItemCharges(PurchLine, PurchLine.Quantity, PurchLine."Line Amount", SelectionTxt);
    end;




    local procedure GetCurrency(CurrencyCode: Code[10])
    begin
        if CurrencyCode = '' then
            Currency.InitRoundingPrecision()
        else begin
            Currency.Get(CurrencyCode);
            Currency.TestField("Amount Rounding Precision");
        end;
    end;
}
