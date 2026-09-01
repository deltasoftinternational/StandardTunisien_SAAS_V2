pageextension 71008 "ST SalesQuotePagExt" extends "Sales Quote" //41
{
    layout
    {
        addlast("Invoice Details")
        {
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("Stamp Amount"; Rec."STStamp Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }

    }

    actions
    {
    }
}