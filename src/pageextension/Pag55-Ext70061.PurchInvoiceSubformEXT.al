pageextension 71061 "PurchInvoiceSubformEXT" extends "Purch. Invoice Subform"//55
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("Direct Unit Cost")
        {
            field(FODEC; Rec.FODEC)
            {
                ApplicationArea = All;
                Visible = IsVisible;
            }
            field("Montant Fodec"; Rec."Montant Fodec")
            {
                ApplicationArea = All;
                Visible = IsVisible;
            }

        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        PurchasesPayablesSetup.Get();
        if PurchasesPayablesSetup."Activer Fodec" then
            IsVisible := true;
    end;

    var
        IsVisible: Boolean;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
}