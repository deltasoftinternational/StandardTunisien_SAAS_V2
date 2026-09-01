pageextension 70040 "STPostedPurchInvoiceSubformEXT" extends "Posted Purch. Invoice Subform" //139
{
    layout
    {
        addafter("Line Amount")
        {
            field(Fodec; Rec.Fodec)
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