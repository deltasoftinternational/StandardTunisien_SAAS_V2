pageextension 71030 "STCustomerCard" extends "Customer Card" //21
{
    layout
    {

        addafter(Invoicing)
        {


            group("Risque client")
            {
                ShowCaption = true;
                part(STRisqueClient; STRisqueClient)
                {
                    Caption = 'Risque Client';
                    ApplicationArea = all;
                    Editable = false;
                    SubPageLink = type = const(Customer), code = field("No.");
                }
            }
        }
    }
}
