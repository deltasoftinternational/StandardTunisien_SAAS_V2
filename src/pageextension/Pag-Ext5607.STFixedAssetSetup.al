pageextension 70058 "ST Fixed Asset Setup" extends "Fixed Asset Setup"
{

    layout
    {
        addafter("Insurance Depr. Book")
        {
            field("ST depreciation rate"; Rec."ST depreciation rate")
            {
                ApplicationArea = FixedAssets;
                ToolTip = 'Specifies the depreciation rate';
            }
        }
    }
}
