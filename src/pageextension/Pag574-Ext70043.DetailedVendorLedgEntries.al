pageextension 71043 "Detailed Vendor Ledg. Entries" extends "Detailed Vendor Ledg. Entries" //574
{
    layout
    {
        addafter("Document No.")
        {
            field("STVendor Posting Group"; Rec."STVendor Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
