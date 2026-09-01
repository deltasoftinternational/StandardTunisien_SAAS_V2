pageextension 71056 STPostedPurchaseReceipLines extends "Posted Purchase Receipt Lines" //528
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("ST INR Quantity"; Rec."ST INR Quantity")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("ST INR Amount"; Rec."ST INR Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
