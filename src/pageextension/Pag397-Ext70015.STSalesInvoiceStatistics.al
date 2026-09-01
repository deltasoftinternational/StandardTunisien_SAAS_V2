pageextension 71015 "ST SalesInvoiceStatistics" extends "Sales Invoice Statistics" //397
{
    layout
    {
        addlast(General)
        {

            field("Stamp Amount"; Rec."STStamp Amount")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
    }
}