pageextension 70044 "Bank Account Ledger Entries" extends "Bank Account Ledger Entries" //372
{
    layout
    {
        addafter(Open)
        {
            field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
