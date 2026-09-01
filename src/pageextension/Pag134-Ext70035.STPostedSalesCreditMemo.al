pageextension 71035 "ST Posted Sales Credit Memo" extends "Posted Sales Credit Memo"//134
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