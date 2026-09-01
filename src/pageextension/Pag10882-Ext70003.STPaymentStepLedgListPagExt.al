pageextension 71003 "ST PaymentStepLedgListPagExt" extends "Payment Step Ledger List" //10882
{
    layout
    {
        addlast(Control1120000)
        {
            field("Compta. Retenue à la source"; Rec."STCompta. Retenue à la source")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
    }
}