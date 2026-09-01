pageextension 71042 "Detailed Cust. Ledg. Entries" extends "Detailed Cust. Ledg. Entries" //573
{
    layout
    {
        addafter("Document No.")
        {
            field("STCustomer Posting Group"; Rec."STCustomer Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
