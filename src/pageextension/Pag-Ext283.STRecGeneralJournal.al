pageextension 70051 "Recurring General Journal" extends "Recurring General Journal" //283
{
    layout
    {
        addafter("Account No.")
        {
            field("Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
