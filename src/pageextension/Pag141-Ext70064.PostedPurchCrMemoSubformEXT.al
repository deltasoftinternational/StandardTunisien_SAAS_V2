pageextension 70064 "PostedPurchCrMemoSubform EXT" extends "Posted Purch. Cr. Memo Subform"//141
{
    layout
    {
        addafter("Line Amount")
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