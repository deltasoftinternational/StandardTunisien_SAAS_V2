pageextension 71003 "Payment Step Ledger List FR" extends "Payment Step Ledger List FR" //10853
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