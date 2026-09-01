pageextension 71045 "Apply Customer Entries" extends "Apply Customer Entries" //232
{
    layout
    {
        addafter(Open)
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addafter("Remaining Amount")
        {
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = all;
            }
            field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
            {
                ApplicationArea = all;
            }
            field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
            {
                ApplicationArea = all;
            }

        }
    }
}
