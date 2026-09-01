pageextension 70034 "ST Posted Sales Invoice" extends "Posted Sales Invoice"

{
    layout
    {
        addlast("Invoice Details")
        {
            field("Stamp Amount"; Rec."STStamp Amount")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
    }

}