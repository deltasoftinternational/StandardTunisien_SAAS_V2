pageextension 71002 "ST PaymentStepLedgPagExt" extends "Payment Step Ledger" //10874
{
    layout
    {
        addlast(Control1)
        {
            field("Compta. Retenue à la source"; Rec."STCompta. Retenue à la source")
            {
                ApplicationArea = All;
            }
            field("Annuler Compta Retn. à la Sour"; Rec."STAnnuler Compta Retn. à la Sour")
            {
                ApplicationArea = All;
            }
            field("ST Account vendor LC"; rec."ST Account vendor LC")
            {
                ApplicationArea = All;

            }

        }
        addafter(Control1)
        {
            group("st Comm")
            {
                Caption = 'Commission';

                field("STInclure Commission"; Rec."STInclure Commission")
                {
                    ApplicationArea = All;
                }

                field("StCompte Commission"; Rec."StCompte Commission")
                {
                    ApplicationArea = All;
                }
                field("StCompte TVA/Commission"; Rec."StCompte TVA/Commission")
                {
                    ApplicationArea = All;
                }

                field(StPerTVA; Rec.StPerTVA)
                {
                    ApplicationArea = All;
                }

                field("StCompte Int"; Rec."StCompte Int")
                {
                    ApplicationArea = All;
                }


            }

        }

    }

    actions
    {
    }
}