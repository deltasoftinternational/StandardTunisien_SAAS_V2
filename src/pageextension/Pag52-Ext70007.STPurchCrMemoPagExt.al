pageextension 70007 "ST PurchCrMemoPagExt" extends "Purchase Credit Memo" //52
{
    layout
    {
        addlast("Invoice Details")
        {


            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("Stamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
    }
}