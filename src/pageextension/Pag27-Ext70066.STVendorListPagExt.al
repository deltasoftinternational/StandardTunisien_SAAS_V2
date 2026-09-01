pageextension 71066 "STVendor List PagExt" extends "Vendor List" //27
{
    layout
    {
        modify("Vendor Posting Group")
        {
            Visible = true;
        }
        addafter("Balance (LCY)")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
        }

    }
}