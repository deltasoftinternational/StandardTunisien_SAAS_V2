pageextension 71052 "STVendor Bank Account Card" extends "Vendor Bank Account Card" //425
{

    layout
    {
        addafter(Contact)
        {
            field("STNote"; Rec.STNote)
            {
                ApplicationArea = all;
            }
        }
    }

}