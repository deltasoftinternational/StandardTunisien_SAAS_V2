pageextension 71047 "Purchase Statistics" extends "Purchase Statistics" //161
{
    layout
    {
        addafter(VATAmount)
        {
            field("STStamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
