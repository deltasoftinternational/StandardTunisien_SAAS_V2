pageextension 71049 "STVendor Bank Account List" extends "Vendor Bank Account List" //426
{
    layout
    {
        addafter(Contact)
        {
            field(STNote; Rec.STNote)
            {
                ApplicationArea = all;
            }
        }
    }
}
