pageextension 70081 "Item Charges" extends "Item Charges" //5800
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("ST Not Assignable"; Rec."ST Not Assignable")
            {
                ApplicationArea = all;
            }
        }
    }
}


