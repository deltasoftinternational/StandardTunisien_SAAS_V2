pageextension 71060 "PurchaseOrderSubformEXT" extends "Purchase Order Subform"//54
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