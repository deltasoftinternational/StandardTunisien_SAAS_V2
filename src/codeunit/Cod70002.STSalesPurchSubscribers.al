codeunit 70002 "ST Sales&PurchSubscribers"
{
    Permissions = tabledata "Purch. Rcpt. Line" = rmd,
                  tabledata "G/L Entry" = rmd,
                  tabledata "Cust. Ledger Entry" = rmd;

    //HH FIXME:

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateBilltoCustomerTemplCodeOnBeforeRecreateSalesLines', '', false, false)]
    local procedure OnValidateBilltoCustomerTemplCodeOnBeforeRecreateSalesLines(var SalesHeader: Record "Sales Header"; CallingFieldNo: Integer)
    var
        lCustomerPostingGroup: Record "Customer Posting Group";
        // BillToCustTemplate: Record "Customer Template";
        BillToCustTemplate: Record "Customer Templ.";
        handled: Boolean;
    begin
        handled := false;
        onbeforeapplystampfromcust(SalesHeader, handled);
        if handled Then
            exit;

        if BillToCustTemplate.Get(SalesHeader."Bill-to Customer Templ. Code") then
            IF lCustomerPostingGroup.GET(SalesHeader."Customer Posting Group") THEN BEGIN
                SalesHeader."STApply Stamp Fiscal" := lCustomerPostingGroup."STApply Stamp Fiscal";
                SalesHeader."STStamp Amount" := lCustomerPostingGroup."STStamp Fiscal Amount";
            END;

    end;


    //HH FIXME:
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopyFromNewSellToCustTemplate', '', false, false)]
    local procedure OnAfterCopyFromNewSellToCustTemplate(var SalesHeader: Record "Sales Header"; SellToCustTemplate: Record "Customer Templ.")
    var
        lCustomerPostingGroup: Record "Customer Posting Group";
        handled: Boolean;
    begin
        handled := false;
        onbeforeapplystampfromcust(SalesHeader, handled);
        if handled Then
            exit;
        IF lCustomerPostingGroup.GET(SalesHeader."Customer Posting Group") THEN BEGIN
            SalesHeader."STApply Stamp Fiscal" := lCustomerPostingGroup."STApply Stamp Fiscal";
            SalesHeader."STStamp Amount" := lCustomerPostingGroup."STStamp Fiscal Amount";

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure OnAfterSetFieldsBilltoCustomerApplyStamp(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    var
        lCustomerPostingGroup: Record "Customer Posting Group";
        handled: Boolean;
    begin
        handled := false;
        onbeforeapplystampfromcust(SalesHeader, handled);
        if handled Then
            exit;
        lCustomerPostingGroup.GET(SalesHeader."Customer Posting Group");
        SalesHeader."STApply Stamp Fiscal" := lCustomerPostingGroup."STApply Stamp Fiscal";
        IF lCustomerPostingGroup."STApply Stamp Fiscal" THEN
            SalesHeader."STStamp Amount" := lCustomerPostingGroup."STStamp Fiscal Amount";
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    // local procedure OnAfterSalesInvHeaderInsertCopyDocumentFields(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    // var
    //     GenJnlLine: Record 81;
    //     GenJnlLineDocTypeEnum: Enum "Gen. Journal Document Type";
    //     SingleInstanceSales: Codeunit 50005;
    // begin
    //     GenJnlLineDocTypeEnum := GenJnlLine."Document Type"::Invoice;

    //     SingleInstanceSales.SetGenJnlLineDocType(GenJnlLineDocTypeEnum.AsInteger());

    //     SingleInstanceSales.SetGenJnlLineDocNo(SalesInvHeader."No.");
    //     SingleInstanceSales.SetGenJnlLineExtDocNo(SalesInvHeader."External Document No.");
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    // local procedure OnAfterSalesCrMemoHeaderInsertCopyDocumentFields(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    // var
    //     GenJnlLine: Record 81;
    //     GenJnlLineDocTypeEnum: Enum "Gen. Journal Document Type";
    //     SingleInstanceSales: Codeunit 50005;

    // begin
    //     GenJnlLineDocTypeEnum := GenJnlLine."Document Type"::"Credit Memo";

    //     SingleInstanceSales.SetGenJnlLineDocType(GenJnlLineDocTypeEnum.AsInteger());
    //     SingleInstanceSales.SetGenJnlLineDocNo(SalesCrMemoHeader."No.");
    //     SingleInstanceSales.SetGenJnlLineExtDocNo(SalesCrMemoHeader."External Document No.");
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnPostLedgerEntryOnAfterGenJnlPostLine, '', false, false)]
    local procedure "Sales Post Invoice Events_OnPostLedgerEntryOnAfterGenJnlPostLine"(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        SalesFunctions: Codeunit "ST Sales&PurchaseHook";
    begin
        SalesFunctions.SalesPostTimbre(SalesHeader, GenJnlPostLine, GenJnlLine);
        // , MntTimbre); MMOK
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure "Sales Post Invoice Events_OnPostLedgerEntryOnBeforeGenJnlPostLine"(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        UpdateCustLedgerEntry(GenJnlLine, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        CustomerPostingGroup: Record "Customer Posting Group";
        MntTimbre: Decimal;
        ishandle: Boolean;
    begin

        CustomerPostingGroup.GET(SalesHeader."Customer Posting Group"); //TODO: faire une fct singleInstance
        IF SalesHeader."STApply Stamp Fiscal" THEN BEGIN
            CustomerPostingGroup.TestField("STApply Stamp Fiscal"); //MMOK
            CustomerPostingGroup.TESTFIELD("STStamp Fiscal Account");
            onbeforesalesamountstamp(MntTimbre, SalesHeader, ishandle);
            if not ishandle then begin
                CustomerPostingGroup.TESTFIELD("STStamp Fiscal Amount");
                MntTimbre := 0;
                if SalesInvHeader."Currency Code" <> '' then begin
                    SalesInvHeader.TestField("Currency Factor");
                    MntTimbre := Round(CurrExchRate.ExchangeAmtLCYToFCY(SalesInvHeader."Posting Date", SalesInvHeader."Currency Code", CustomerPostingGroup."STStamp Fiscal Amount", SalesInvHeader."Currency Factor"))
                end else
                    MntTimbre := CustomerPostingGroup."STStamp Fiscal Amount";
            end;

            SalesInvHeader."STStamp Amount" := MntTimbre;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeaderApllyStamp(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader."STApply Stamp Fiscal" := SalesQuoteHeader."STApply Stamp Fiscal";
        SalesOrderHeader."STStamp Amount" := SalesQuoteHeader."STStamp Amount";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice Statistics", 'OnBeforeCalculateTotals', '', false, false)]
    local procedure OnBeforeCalculateTotalsAddStamp(SalesInvoiceHeader: Record "Sales Invoice Header"; var CustAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var CostLCY: Decimal; var TotalAdjCostLCY: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var IsHandled: Boolean)
    Var
        lIsHandled: Boolean;
    begin
        lIsHandled := true;
        OnBeforeAddStampAmountInclVAT(lIsHandled);
        if lIsHandled then
            AmountInclVAT += SalesInvoiceHeader."STStamp Amount";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Invoice Statistics", 'OnBeforeCalculateTotals', '', false, false)]
    local procedure OnBeforeCalculateTotals(PurchInvHeader: Record "Purch. Inv. Header"; var VendAmount: Decimal; var AmountInclVAT: Decimal; var InvDiscAmount: Decimal; var LineQty: Decimal; var TotalNetWeight: Decimal; var TotalGrossWeight: Decimal; var TotalVolume: Decimal; var TotalParcels: Decimal; var IsHandled: Boolean)

    begin
        //AmountInclVAT += PurchInvHeader."STStamp Fiscal Amount";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLedgerEntryOnAfterGenJnlPostLine, '', false, false)]
    local procedure "Purch Post Invoice Events_OnPostLedgerEntryOnAfterGenJnlPostLine"(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        PurChaseFunctions: Codeunit "ST Sales&PurchaseHook";
    begin
        PurChaseFunctions.PurchPostTimbre(PurchHeader, GenJnlPostLine, GenJnlLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure "Purch Post Invoice Events_OnPostLedgerEntryOnBeforeGenJnlPostLine"(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; SuppressCommit: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin

        UpdateVendorLedgerEntry(GenJnlLine, PurchHeader);
    end;


    [EventSubscriber(ObjectType::Page, Page::"Purchase Statistics", 'OnAfterCalculateTotals', '', false, false)]
    local procedure OnAfterCalculateTotalsAddStamp(var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line"; var TotalAmt1: Decimal; var TotalAmt2: Decimal)
    begin
        TotalAmt2 += PurchHeader."STStamp Fiscal Amount";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderValidateOrderNo(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."STOrder No." := SalesHeader."No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', false, false)]
    local procedure OnBeforeInsertDtldCustLedgEntryValidateOrderNo(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry."STOrder No." := GenJournalLine."STOrder No.";
        DtldCustLedgEntry."STPayment Method Code" := GenJournalLine."Payment Method Code";
        DtldCustLedgEntry.STOption := GenJournalLine.STOption;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure OnBeforeCustLedgEntryInsertValidateOrderNo(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        CustLedgerEntry."STOrder No." := GenJournalLine."STOrder No.";
        CustLedgerEntry."STPayment Method Code" := GenJournalLine."Payment Method Code";
        CustLedgerEntry."STPayment terms Code" := GenJournalLine."Payment Terms Code";
        CustLedgerEntry.STOption := GenJournalLine.STOption;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLineValidateOrderNo(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."STOrder No." := GenJournalLine."STOrder No.";
        CustLedgerEntry.STOption := GenJournalLine.STOption;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure OnBeforeInsertDtldVendLedgEntryInsertOrderNo(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldVendLedgEntry."STOrder No." := GenJournalLine."STOrder No.";
        DtldVendLedgEntry."STPayment Method Code" := GenJournalLine."Payment Method Code";
        DtldVendLedgEntry.STOption := GenJournalLine.STOption;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeVendLedgEntryInsert', '', false, false)]
    local procedure OnBeforeVendorLedgEntryInsertValidateOrderNo(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register")
    begin
        VendorLedgerEntry."STOrder No." := GenJournalLine."STOrder No.";
        VendorLedgerEntry."STPayment Method Code" := GenJournalLine."Payment Method Code";
        VendorLedgerEntry."STPayment terms Code" := GenJournalLine."Payment Terms Code";
        VendorLedgerEntry.STOption := GenJournalLine.STOption;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostGLAccOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnPostGLAccOnBeforeInsertGLEntryValidateOrderNo(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var IsHandled: Boolean)
    begin
        GLEntry."STOrder No." := GenJournalLine."STOrder No.";
        GLEntry."Due Date" := GenJournalLine."Due Date";
        GLEntry."ST adjt cost" := GenJournalLine."ST adjt cost";
        GLEntry.STOption := GenJournalLine.STOption;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterInitGLEntry, '', false, false)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal; var GLRegister: Record "G/L Register")
    begin
        GLEntry.STOption := GenJournalLine.STOption;
    end;

    //Commenté par RC
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterDivideAmount', '', false, false)]
    // local procedure OnAfterDivideAmount(var PurchLine: Record "Purchase Line"; var TempVATAmountLine: Record "VAT Amount Line"; var TempVATAmountLineRemainder: Record "VAT Amount Line")
    // begin
    //     PurchLine."Line Amount" := (PurchLine."Unit Cost" * PurchLine.Quantity) + PurchLine."Montant Fodec";
    //     PurchLine.Amount := PurchLine."Line Amount";
    //     PurchLine.Modify();
    // end;



    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterRecreateLines', '', false, false)]
    local procedure OnValidateBuyFromVendorNoOnAfterRecreateLines(var PurchaseHeader: Record "Purchase Header")
    var
        lVendorPostingGroup: Record "Vendor Posting Group";

    begin
        IF lVendorPostingGroup.GET(PurchaseHeader."Vendor Posting Group") THEN BEGIN
            PurchaseHeader."STApply Stamp Fiscal" := lVendorPostingGroup."STApply Stamp Fiscal";
            PurchaseHeader."STStamp Fiscal Amount" := lVendorPostingGroup."STStamp Fiscal Amount";

        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::AccSchedManagement, 'OnAfterSetGLAccRowFilters', '', false, false)]
    local procedure OnAfterSetGLAccRowFilters(var AccScheduleLine: Record "Acc. Schedule Line"; var GLAccount: Record "G/L Account")
    begin
        IF AccScheduleLine."Totaling Type" = AccScheduleLine."Totaling Type"::"Posting Accounts" then begin
            IF AccScheduleLine."STTotalisation debiteur" <> '' THEN
                GLAccount.SETFILTER(GLAccount."Net Change", '>%1', 0);
            IF AccScheduleLine."STTotalisation Crediteur" <> '' THEN
                GLAccount.SETFILTER(GLAccount."Net Change", '<%1', 0);

        END;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    var
        VatPostingSetupBuffer: Record "VAT Posting Setup" temporary;
        ST: Codeunit "ST Sales&PurchSubscribers";
        FodecPurchLine: Record "Purchase Line";

    begin

        PurchaseSetup.get();
        if (PurchaseSetup."Activer Fodec") Then
            If (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice)
           or (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo")
            OR ((PurchaseHeader.Invoice = true) AND (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order)) Then Begin
                //>> Insert New Line item Charge
                CalcFodec(PurchaseHeader, VatPostingSetupBuffer);
                InsertFodecLine(PurchaseHeader, FodecPurchLine, VatPostingSetupBuffer);

                //>> Assigne Item Charge per Fodec Line
                FodecPurchLine.RESET();
                FodecPurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
                FodecPurchLine.SetRange("Document No.", PurchaseHeader."No.");
                FodecPurchLine.SetRange(Type, FodecPurchLine.type::"Charge (Item)");
                FodecPurchLine.SetRange("No.", PurchaseSetup."Fodec Charge Item");
                If FodecPurchLine.FindSet() then
                    repeat
                        CreateItemChargeAssgnt(PurchaseHeader, FodecPurchLine)
                    until FodecPurchLine.Next() = 0;
            End;
    end;

    procedure InsertFodecLine(PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VatPostingSetupBuffer: Record "VAT Posting Setup" temporary);
    var
        NextNo: Integer;
    begin
        PurchaseSetup.get();
        PurchLine.Setrange("Document Type", PurchHeader."Document Type");
        PurchLine.Setrange("Document No.", PurchHeader."No.");
        if PurchLine.FindLast() then
            NextNo := PurchLine."Line No." + 10000;

        if VatPostingSetupBuffer.FindFirst() then
            repeat
            Begin
                PurchLine.INIT();

                PurchLine.VALIDATE("Document Type", PurchLine."Document Type");
                PurchLine.VALIDATE("Document No.", PurchHeader."No.");
                PurchLine."System-Created Entry" := TRUE;
                PurchLine."Line No." := NextNo;
                NextNo += 10000;

                //      "Document Profile" := PurchHeader."Document Profile";
                PurchLine.VALIDATE("Type", PurchLine."Type"::"Charge (Item)");
                PurchLine.VALIDATE("No.", PurchaseSetup."Fodec Charge Item");
                PurchLine.VALIDATE("VAT Prod. Posting Group", VatPostingSetupBuffer."VAT Prod. Posting Group");
                PurchLine.Description := PurchLine.Description + ' : ' + VatPostingSetupBuffer."VAT Prod. Posting Group";
                PurchLine.VALIDATE(Quantity, 1);
                PurchLine.VALIDATE("Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
                PurchLine.VALIDATE("Direct Unit Cost", VatPostingSetupBuffer."VAT %");
                PurchLine."System-Created Entry" := false;
                PurchLine.VALIDATE("Dimension Set ID", PurchHeader."Dimension Set ID");

                PurchLine.INSERT(false);
            End;
            until VatPostingSetupBuffer.Next() = 0;
    end;



    procedure CreateItemChargeAssgnt(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
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

        //if IsCreditDocType then
        //    AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch, "Return Shipment No.")
        //else
        AssignItemChargePurch.CreateDocChargeAssgnt(ItemChargeAssgntPurch, PurchLine."Receipt No.");

        //AssignItemChargePurch.SuggestAssgnt2(PurchLine, PurchLine.Quantity, ItemChargeAssgntPurch."Amount to Assign", 1);
        Selection := 2;
        SuggestItemChargeMenuTxt :=
              StrSubstNo(ItemChargeAssignedMenu4Lbl, AssignItemChargePurch.AssignEquallyMenuText(), AssignItemChargePurch.AssignByAmountMenuText(), AssignItemChargePurch.AssignByWeightMenuText(), AssignItemChargePurch.AssignByVolumeMenuText());
        SelectionTxt := SelectStr(Selection, SuggestItemChargeMenuTxt);
        AssignItemChargePurch.AssignItemCharges(PurchLine, PurchLine.Quantity, PurchLine."Line Amount", SelectionTxt);
    end;


    procedure CalcFodec(PurchaseHeader: Record "Purchase Header"; var VatPostingSetupBuffer: Record "VAT Posting Setup" temporary);
    var
        purchaseLine: Record "Purchase Line";
        paraAchat: Record "Purchases & Payables Setup";
        amountFodec: Decimal;
        GenLedgSetup: record "General Ledger Setup";
    begin
        amountFodec := 0;
        paraAchat.Get();
        purchaseLine.Reset();
        GenLedgSetup.get();
        if paraAchat."Activer Fodec" then Begin
            purchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            purchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            purchaseLine.SetFilter("Qty. to Invoice", '>%1', 0);
            purchaseLine.SetRange(FODEC, true);

            if purchaseLine.FindSet() then
                repeat
                    IF not VatPostingSetupBuffer.get(purchaseLine."VAT Bus. Posting Group", purchaseLine."VAT Prod. Posting Group") then begin
                        VatPostingSetupBuffer.Init();
                        VatPostingSetupBuffer."VAT Bus. Posting Group" := purchaseLine."VAT Bus. Posting Group";
                        VatPostingSetupBuffer."VAT Prod. Posting Group" := purchaseLine."VAT Prod. Posting Group";
                        VatPostingSetupBuffer.insert();
                    end;
                    amountFodec := round(paraAchat."Taux Fodec" / 100 * (purchaseLine."Direct Unit Cost" * purchaseLine."Qty. to Invoice") * (1 - purchaseLine."Line Discount %" / 100), GenLedgSetup."Amount Rounding Precision");
                    VatPostingSetupBuffer."VAT %" += amountFodec;
                    VatPostingSetupBuffer.Modify();
                until purchaseLine.Next() = 0;
        End;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnCreateDocChargeAssgntOnAfterFromPurchLineSetFilters', '', false, false)]
    local procedure OnCreateDocChargeAssgntOnAfterFromPurchLineSetFilters(var LastItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; var FromPurchLine: Record "Purchase Line")
    var
        Purchaseline: Record "Purchase Line";
    begin
        PurchaseSetup.get();
        IF Purchaseline.get(LastItemChargeAssgntPurch."Document Type", LastItemChargeAssgntPurch."Document No.", LastItemChargeAssgntPurch."Document Line No.") then
            if Purchaseline."No." = PurchaseSetup."Fodec Charge Item" then
                FromPurchLine.SetRange("VAT Prod. Posting Group", Purchaseline."VAT Prod. Posting Group");
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdateInvoicedQtyOnPurchRcptLine', '', false, false)]
    local procedure OnAfterUpdateInvQtyOnPuchReceiptLine(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseLine: Record "Purchase Line"; var TempTrackingSpecification: Record "Tracking Specification" temporary; TrackingSpecificationExists: Boolean; var QtyToBeInvoiced: Decimal; var QtyToBeInvoicedBase: Decimal; var PurchaseHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean)

    begin
        PurchRcptLine."ST Last Invoice Date" := PurchInvHeader."Posting Date";
        PurchRcptLine.Modify();
    end;

    [EventSubscriber(objecttype::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeNewPurchRcptLineInsert', '', false, false)]
    local procedure OnBeforeNewPurchRcptLineInsert(var NewPurchRcptLine: Record "Purch. Rcpt. Line"; OldPurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        NewPurchRcptLine."ST INR Amount" := 0;
        NewPurchRcptLine."ST INR Quantity" := 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean);
    var
        Vendor_L: Record Vendor;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchasesPayablesSetup_L: Record "Purchases & Payables Setup";
        BillsNotReceived_L: Report "Bills Not Received";
        ishandled: Boolean;
    begin
        ishandled := true;
        PurchasesPayablesSetup_L.Get();
        if PurchasesPayablesSetup_L."ST Auto-Run Bill Not Received" then begin
            onBeforeBillsNotReceived(PurchRcpHdrNo, ishandled);
            if ishandled then
                if Vendor_L.Get(PurchaseHeader."Buy-from Vendor No.") then
                    if Vendor_L."Execute FNP" then
                        if PurchRcpHdrNo <> '' then begin
                            BillsNotReceived_L.SetParameters(WorkDate(), '', PurchRcpHdrNo, 0);
                            BillsNotReceived_L.UseRequestPage(false);
                            BillsNotReceived_L.Run();
                        end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure OnAfterProcessPurchLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; var PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean)
    var
        Vendor_L: Record Vendor;
        PurchasesPayablesSetup_L: Record "Purchases & Payables Setup";
        PurchaseLine_L: Record "Purchase Line";
        ReceiptsLists: list of [code[20]];
        BillsNotReceived_L: Report "Bills Not Received";
        ishandled: Boolean;
    begin
        ishandled := true;
        PurchasesPayablesSetup_L.Get();
        if PurchasesPayablesSetup_L."ST Auto-Run Bill Not Received" then begin
            PurchaseLine_L.SetRange("Document No.", PurchHeader."No.");
            PurchaseLine_L.SetRange("Document Type", PurchHeader."Document Type");
            if PurchaseLine_L.FindSet() then
                repeat
                    if not ReceiptsLists.Contains(PurchaseLine_L."Receipt No.") then begin
                        ReceiptsLists.Add(PurchaseLine_L."Receipt No.");
                        onBeforeBillsNotReceived(PurchaseLine_L."Receipt No.", ishandled);
                        if ishandled then
                            if Vendor_L.Get(PurchaseLine_L."Buy-from Vendor No.") then
                                if Vendor_L."Execute FNP" then
                                    if PurchaseLine_L."Receipt No." <> '' then begin
                                        BillsNotReceived_L.SetParameters(WorkDate(), '', PurchaseLine_L."Receipt No.", 0);
                                        BillsNotReceived_L.UseRequestPage(false);
                                        BillsNotReceived_L.Run();
                                    end;
                    end;
                until PurchaseLine_L.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnAfterCode', '', false, false)]
    local procedure OnAfterCode(var PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        Vendor_L: Record Vendor;
        PurchasesPayablesSetup_L: Record "Purchases & Payables Setup";
        BillsNotReceived_L: Report "Bills Not Received";
        ishandled: Boolean;
    begin
        ishandled := true;
        PurchasesPayablesSetup_L.Get();
        if PurchasesPayablesSetup_L."ST Auto-Run Bill Not Received" then begin
            onBeforeBillsNotReceived(PurchRcptLine."Document No.", ishandled);
            if ishandled then
                if Vendor_L.Get(PurchRcptLine."Buy-from Vendor No.") then
                    if Vendor_L."Execute FNP" then
                        if PurchRcptLine."Document No." <> '' then begin
                            BillsNotReceived_L.SetParameters(WorkDate(), '', PurchRcptLine."Document No.", 0);
                            BillsNotReceived_L.UseRequestPage(false);
                            BillsNotReceived_L.Run();
                        end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Accounting Period", OnCheckOpenFiscalYearsOnBeforeError, '', false, false)]
    local procedure "Accounting Period_OnCheckOpenFiscalYearsOnBeforeError"(var AccountingPeriod: Record "Accounting Period"; var IsHandled: Boolean)
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        AccountingPeriod2: Record "Accounting Period";
        NoOfOpenFiscalYears: Integer;
        Text10801: Label 'It is not allowed to have more than %1 open fiscal years. Please fiscally close the oldest open fiscal year first.';
    begin
        if GeneralLedgerSetup.get() then
            if GeneralLedgerSetup."ST No Open Fiscal Years" <> 0 then begin
                AccountingPeriod2.Reset();
                AccountingPeriod2.SetRange("New Fiscal Year", true);
                AccountingPeriod2.SetRange("Fiscally Closed", false);
                NoOfOpenFiscalYears := AccountingPeriod2.Count();
                if AccountingPeriod2.FindFirst() then;

                // check last period of previous fiscal year
                AccountingPeriod2.SetRange("New Fiscal Year");
                AccountingPeriod2.SetRange("Fiscally Closed");
                if AccountingPeriod2.Find('<') then
                    if not AccountingPeriod2."Fiscally Closed" then
                        NoOfOpenFiscalYears := NoOfOpenFiscalYears + 1;
                if NoOfOpenFiscalYears > GeneralLedgerSetup."ST No Open Fiscal Years" then
                    Error(Text10801, GeneralLedgerSetup."ST No Open Fiscal Years");
                IsHandled := True;
            end;
    end;

    [IntegrationEvent(false, false)]
    local procedure onbeforesalesamountstamp(var stamp: decimal; SalesHeader: Record "Sales Header"; var ishandle: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure onbeforePurchamountstamp(var stamp: decimal; PurchHeader: Record "Purchase Header"; var ishandle: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeBillsNotReceived(PurchRcpHdrNo: Code[20]; var IsHandled: Boolean)
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCopyAndCheckItemChargeTempPurchLine', '', false, false)]
    local procedure OnBeforeCopyAndCheckItemChargeTempPurchLine(PurchaseHeader: Record "Purchase Header"; var TempPrepmtPurchaseLine: Record "Purchase Line" temporary; var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; var IsHandled: Boolean; var AssignError: Boolean)
    Var
        itemCharge: Record "Item Charge";
    begin
        //Gestion des frais annexes non affectables
        IF ItemCharge.GET(TempPrepmtPurchaseLine."No.") THEN
            If itemCharge."ST Not Assignable" then
                IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckNoAndQuantityForItemChargeAssgnt', '', false, false)]
    local procedure "Purchase Line_OnBeforeCheckNoAndQuantityForItemChargeAssgnt"(var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    Var
        ITemCharge: Record "Item Charge";
        Error001: Label 'Le frais annexe %1 est un frais non affectable';
    begin

        ItemCharge.GET(PurchaseLine."No.");
        IF itemcharge."ST Not Assignable" = true then
            ERROR(Error001, ITemCharge."No.");


    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnShowItemChargeAssgntOnAfterCurrencyInitialize', '', false, false)]

    local procedure OnShowItemChargeAssgntOnAfterCurrencyInitialize(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var Currency: Record Currency)
    Var
        ITemCharge: Record "Item Charge";
        Error001: Label 'Le frais annexe %1 est un frais non affectable';
    begin

        ItemCharge.GET(SalesLine."No.");
        IF itemcharge."ST Not Assignable" = true then
            ERROR(Error001, ITemCharge."No.");


    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCopyAndCheckItemCharge', '', false, false)]
    local procedure OnBeforeCopyAndCheckItemCharge(var SalesHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary; var SalesLine: Record "Sales Line"; var InvoiceEverything: Boolean; var AssignError: Boolean; var QtyNeeded: Decimal; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)"; var TempSalesLineGlobal: Record "Sales Line" temporary; var IsHandled: Boolean);
    Var
        itemCharge: Record "Item Charge";
    begin
        //Gestion des frais annexes non affectables
        IF ItemCharge.GET(TempSalesLineGlobal."No.") THEN
            If itemCharge."ST Not Assignable" then
                IsHandled := true;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeAddStampAmountInclVAT(var ishandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure onbeforeapplystampfromcust(var SalesHeader: Record "Sales Header"; var ishandled: Boolean)
    begin
    end;

    procedure UpdateCustLedgerEntry(var GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    var
        CustomerPostingGroup: Record "Customer Posting Group";
        MntTimbre: Decimal;
        IsHandle: Boolean;
    begin
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
            IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN
                GenJnlLine.Amount := GenJnlLine.Amount - MntTimbre;
                GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" - MntTimbre;
                GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - MntTimbre;
            END
            ELSE BEGIN
                GenJnlLine.Amount := GenJnlLine.Amount + MntTimbre;
                GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" + MntTimbre;
                GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" + MntTimbre;
            END;

        end;
    end;

    procedure UpdateVendorLedgerEntry(var GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header")
    var
        VendorPostingGroup: Record "Vendor Posting Group";
        MntTimbre: Decimal;
        ishandle: Boolean;
    begin

        VendorPostingGroup.GET(PurchHeader."Vendor Posting Group");
        IF PurchHeader."STApply Stamp Fiscal" THEN BEGIN
            VendorPostingGroup.TestField("STApply Stamp Fiscal"); //MMOK            
            VendorPostingGroup.TESTFIELD("STStamp Fiscal Account");
            onbeforePurchamountstamp(MntTimbre, PurchHeader, ishandle);
            if not ishandle then begin
                VendorPostingGroup.TESTFIELD("STStamp Fiscal Amount"); //MMOK
                MntTimbre := 0;
                MntTimbre := VendorPostingGroup."STStamp Fiscal Amount";
            end;

            IF GenJnlLine."Document Type" = GenJnlLine."Document Type"::"Credit Memo" THEN BEGIN

                GenJnlLine.Amount := GenJnlLine.Amount + MntTimbre;
                GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" + MntTimbre;
                GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" + MntTimbre;
            end
            else begin
                GenJnlLine.Amount := GenJnlLine.Amount - MntTimbre;
                GenJnlLine."Source Currency Amount" := GenJnlLine."Source Currency Amount" - MntTimbre;
                GenJnlLine."Amount (LCY)" := GenJnlLine."Amount (LCY)" - MntTimbre;
            end;
        end;
    end;

    var
        PurchaseSetup: Record "Purchases & Payables Setup";

}
