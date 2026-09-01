pageextension 70048 "STChart of Accounts" extends "Chart of Accounts" //16
{
    layout
    {
        addafter("Credit Amount")
        {
            field("Net Balance (LCY)"; Rec."Net Balance (LCY)")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        //HH FIXME:
        // modify("Apply Entries")
        // {
        //     Promoted = true;
        //     PromotedCategory = Process;
        //     PromotedIsBig = true;

        // }
    }

    var
        myInt: Integer;
}