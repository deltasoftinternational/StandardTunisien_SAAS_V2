pageextension 71055 "ST G/L Account Card" extends "G/L Account Card" //17
{
    layout
    {
        addafter(Blocked)
        {
            field("Due Date Mandatory Gen Journal"; Rec."Due Date Mandatory Gen Journal")
            {
                ApplicationArea = all;
            }
        }

    }
}