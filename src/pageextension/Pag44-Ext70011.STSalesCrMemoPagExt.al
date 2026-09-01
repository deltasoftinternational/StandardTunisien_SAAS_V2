pageextension 70011 "ST SalesCrMemoPagExt" extends "Sales Credit Memo" //44
{
    layout
    {
        addlast("Credit Memo Details")
        {
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("Stamp Amount"; Rec."STStamp Amount")
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