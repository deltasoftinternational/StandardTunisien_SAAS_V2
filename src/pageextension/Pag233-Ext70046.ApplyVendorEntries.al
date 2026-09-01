pageextension 71046 "Apply Vendor Entries" extends "Apply Vendor Entries" //233
{
    layout
    {
        addafter(Open)
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group")
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

