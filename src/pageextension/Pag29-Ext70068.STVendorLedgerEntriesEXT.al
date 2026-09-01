pageextension 70068 "ST Vendor Ledger Entries EXT" extends "Vendor Ledger Entries"//29
{
    layout
    {
        modify("Vendor Posting Group") { Visible = true; }
        addbefore("Due Date")
        {
            field("STPayment terms Code"; rec."STPayment terms Code")
            {
                ApplicationArea = all;
            }
        }

    }



}