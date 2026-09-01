pageextension 71004 "ST PurchOrderPagExt" extends "Purchase Order" //50
{
    layout
    {

        addlast(General)
        {
            field("Stamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
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