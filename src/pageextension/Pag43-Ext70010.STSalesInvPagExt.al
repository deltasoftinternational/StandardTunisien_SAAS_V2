pageextension 70010 "ST SalesInvPagExt" extends "Sales Invoice" //43
{
    layout
    {
        addlast(Control200)
        {
            field("Stamp Amount"; Rec."STStamp Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
    }
}