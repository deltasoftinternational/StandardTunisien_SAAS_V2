pageextension 70013 "ST VendorPostingGroupsPagExt" extends "Vendor Posting Groups" //111
{
    layout
    {
        addlast(Control1)
        {

            field("Stamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = All;
            }
            field("Stamp Fiscal Account"; Rec."STStamp Fiscal Account")
            {
                ApplicationArea = All;
            }
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("STApply FODEC"; Rec."STApply FODEC")
            {
                ApplicationArea = All;
                Visible = IsVisible;
            }
            field("STSG/L Account Filter"; Rec."STSG/L Account Filter")
            {
                ApplicationArea = all;
            }
            field("ST Accrual Account"; Rec."ST Accrual Account")
            {
                ApplicationArea = all;
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