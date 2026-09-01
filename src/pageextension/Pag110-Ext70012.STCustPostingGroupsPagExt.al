pageextension 70012 "ST CustPostingGroupsPagExt" extends "Customer Posting Groups" //110
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
            field("STSG/L Account Filter"; Rec."STSG/L Account Filter")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
    }
}