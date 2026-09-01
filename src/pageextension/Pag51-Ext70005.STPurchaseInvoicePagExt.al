pageextension 71005 "ST PurchaseInvoicePagExt" extends "Purchase Invoice" //51
{
    layout
    {
        addlast(General)
        {
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