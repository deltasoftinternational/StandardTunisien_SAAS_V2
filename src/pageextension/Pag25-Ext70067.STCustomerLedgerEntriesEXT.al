pageextension 70067 "ST Customer Ledger Entries EXT" extends "Customer Ledger Entries"//25
{
    layout
    {
        modify("Customer Posting Group") { Visible = true; }
        addafter("Due Date")
        {

            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Due Date")
        {
            field("STPayment terms Code"; rec."STPayment terms Code")
            {
                ApplicationArea = all;
            }
        }
    }

}