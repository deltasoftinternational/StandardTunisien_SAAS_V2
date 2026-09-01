page 70020 "ST Modify Payment Line"
{
    Caption = 'Modification de la date d''échéance';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Payment Line";
    Permissions = tabledata "Cust. Ledger Entry" = rm,
        tabledata "Detailed Cust. Ledg. Entry" = rm,
        tabledata "Vendor Ledger Entry" = rm,
        tabledata "Detailed Vendor Ledg. Entry" = rm,
        tabledata "Bank account Ledger Entry" = rm;
    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field(ExternalDocumentNo; rec."External Document No.")
                {
                    Caption = 'N° Document Externe';
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field(DocNo; rec."Document No.")
                {
                    Caption = 'N° Document';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(NewDueDate; NewDueDate)
                {
                    Caption = 'Date D''échéance';
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the due date on the entry.';
                    Editable = true;
                    trigger OnValidate()
                    var

                        Text001Txt: label 'La nouvelle date ne peut pas être vide ou null';
                    begin
                        if NewDueDate = 0D
                        then
                            Error(Text001Txt);
                    end;
                }
                field(NewReference; NewReference)
                {
                    Caption = 'Référence';
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
            }
        }
    }
    var
        NewDueDate: Date;
        NewReference: Code[35];

    trigger OnOpenPage()
    begin
        NewDueDate := rec."Due Date";
        NewReference := rec."External Document No.";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = CloseAction::LookupOK then begin
            if (NewDueDate <> rec."Due Date") or (rec."External Document No." <> NewReference) then
                ModifyDueDate();
        end;
    end;


    local procedure ModifyDueDate()

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        BankAccountLedger: record "Bank Account Ledger Entry";
    begin




        if rec."Account Type" = rec."Account Type"::Customer then begin
            CustLedgerEntry.SetRange("Document No.", rec."No.");
            CustLedgerEntry.setfilter("Customer No.", '%1', rec."Account No.");
            CustLedgerEntry.setrange("Posting Date", rec."Posting Date");
            CustLedgerEntry.SetRange("External Document No.", rec."External Document No.");
            if CustLedgerEntry.FindFirst() then
                repeat
                    CustLedgerEntry."Due Date" := NewDueDate;
                    CustLedgerEntry."External Document No." := NewReference;
                    CustLedgerEntry.Modify();
                    DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                    DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                    if DetailedCustLedgEntry.FindSet() then
                        DetailedCustLedgEntry.ModifyAll("Initial Entry Due Date", NewDueDate);
                until CustLedgerEntry.next() = 0;
        end;

        if rec."Account Type" = rec."Account Type"::vendor then begin
            VendorLedgerEntry.SetRange("Document No.", rec."No.");
            VendorLedgerEntry.setfilter("vendor No.", '%1', rec."Account No.");
            VendorLedgerEntry.setrange("Posting Date", rec."Posting Date");
            VendorLedgerEntry.SetRange("External Document No.", rec."External Document No.");
            if VendorLedgerEntry.FindFirst() then
                repeat
                    VendorLedgerEntry."Due Date" := NewDueDate;
                    VendorLedgerEntry."External Document No." := NewReference;
                    VendorLedgerEntry.Modify();
                    DetailedVendLedgEntry.SetRange("vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
                    DetailedVendLedgEntry.SetRange("Entry Type", DetailedVendLedgEntry."Entry Type"::"Initial Entry");
                    if DetailedVendLedgEntry.FindSet() then
                        DetailedVendLedgEntry.ModifyAll("Initial Entry Due Date", NewDueDate);
                until VendorLedgerEntry.next = 0;

        end;
        BankAccountLedger.SetRange("Document No.", rec."No.");
        BankAccountLedger.SetRange("Posting Date", rec."Posting Date");
        BankAccountLedger.SetRange("External Document No.", rec."External Document No.");
        if BankAccountLedger.FindSet() then begin
            BankAccountLedger.ModifyAll("External Document No.", NewReference);
        end;

        rec."Due Date" := NewDueDate;
        rec.Validate("External Document No.", NewReference);
        rec.Modify();
    end;
}
