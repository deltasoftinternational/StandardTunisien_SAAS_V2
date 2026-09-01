pageextension 70006 "ST PurchaseQuotePagExt" extends "Purchase Quote" //49
{
    layout
    {
        addlast("Invoice Details")
        {

            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("Stamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = All;
                Editable = false;

            }

        }

    }

}