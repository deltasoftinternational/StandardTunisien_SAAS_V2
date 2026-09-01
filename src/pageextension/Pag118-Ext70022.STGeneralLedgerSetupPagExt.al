pageextension 71022 "ST GeneralLedgerSetupPagExt" extends "General Ledger Setup" //118
{

    layout
    {
        addafter("Bank Account Nos.")
        {
            // YB
            field("STEnableseriesNoCoffre"; Rec."ST Enable seriesNo Coffre")
            {
                ApplicationArea = all;
            }
            //
            field("Retenu par def."; Rec."STRetenu par def.")
            {
                ApplicationArea = all;
            }
            field("Nombre caractères CIN"; Rec."Nombre caractères CIN")
            {
                ApplicationArea = all;
            }
            field("STView Sum GLEntries"; Rec."STView Sum GLEntries")
            {
                ApplicationArea = all;
            }

        }
        addafter(Reporting)
        {
            group(paiement)
            {
                field("STmodele cheque"; Rec."STmodele cheque")
                {
                    ApplicationArea = all;
                }
                field("ST Enable Bank Slip"; Rec."ST Enable Bank Slip")
                {
                    ApplicationArea = all;
                }
                field("ST Enable reasoncode slip pay."; Rec."ST Enable reasoncode slip pay.")
                {
                    ApplicationArea = all;
                }
            }
            group("Journal caisse")
            {
                field("ST Caisse recette"; Rec."ST Caisse recette")
                {
                    ApplicationArea = All;
                }
                field("ST Caisse depense"; Rec."ST Caisse depense")
                {
                    ApplicationArea = All;
                }


            }
            group("Tresorerie")
            {
                field("ST tresorerie recette"; Rec."ST tresorerie recette")
                {
                    ApplicationArea = All;
                }
                field("ST tresorerie depense"; Rec."ST tresorerie depense")
                {
                    ApplicationArea = All;
                }
                field("ST tresorerie engagement"; Rec."ST tresorerie engagement")
                {
                    ApplicationArea = All;
                }


            }
            group(ST_LC)
            {
                Caption = 'Lettre de Crédit';

                field("ST LC"; Rec."ST LC")
                { ApplicationArea = All; }
                field("ST REG Debit"; Rec."ST REG Debit")
                { ApplicationArea = All; }
                field("ST FED progress"; Rec."ST FED progress")
                { ApplicationArea = All; }
                field("ST FED Accepted"; Rec."ST FED Accepted")
                { ApplicationArea = All; }

                field("ST FED settled"; Rec."ST FED settled")
                { ApplicationArea = All; }

                field("ST Prorogation 1"; Rec."ST Prorogation 1")
                { ApplicationArea = All; }
                field("ST Prorogation 2"; Rec."ST Prorogation 2")
                { ApplicationArea = All; }
                field("ST Prorogation 3"; Rec."ST Prorogation 3")
                { ApplicationArea = All; }
            }
        }
        addafter("Shortcut Dimension 8 Code")
        {
            field("STActivate Mandatory Dimension"; Rec."STActivate Mandatory Dimension")
            {
                ApplicationArea = all;
            }
        }
        addafter("Inv. Rounding Type (LCY)")
        {
            field("ST INR Source Code"; Rec."ST INR Source Code")
            {
                Caption = 'Code Journal FNP';
                ApplicationArea = All;

            }
            field("ST INR Series"; Rec."ST INR Series")
            {
                Caption = 'N° FNP';
                ApplicationArea = All;

            }
        }
        addlast(Reporting)
        {
            field("ST No showing due date"; Rec."ST No showing due date")
            {
                ApplicationArea = all;
            }

        }
        addafter(EnableDataCheck)
        {
            field("ST No Open Fiscal Years"; Rec."ST No Open Fiscal Years")
            {
                ApplicationArea = all;
            }
        }
        addafter("STmodele cheque")
        {
            field("ST Manual Check Selection"; Rec."ST Manual Check Selection")
            {
                ApplicationArea = all;
            }
        }
    }
}





