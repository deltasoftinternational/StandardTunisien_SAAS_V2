pageextension 70053 "STReason Codes" extends "Reason Codes"
{
    layout
    {
        addafter(Description)
        {
            field("ST payment slip"; Rec."ST payment slip")
            {
                ApplicationArea = all;
            }
        }
    }

}