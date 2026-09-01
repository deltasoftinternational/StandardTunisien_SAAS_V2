pageextension 70020 "ST AccountantRoleCenterPagExt" extends "Accountant Role Center" //9027
{
    layout
    {
        modify(Control1902304208)
        {
            Visible = false;
        }
        modify(Control123)
        {
            Visible = false;
        }
        addafter(Control99)
        {
            part("Activities comptable"; "Activities comptable")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addbefore("General Journals")
        {
            action("Bordoreaux Paiement")
            {
                Caption = 'Bordereaux Paiement';
                ApplicationArea = All;

                RunObject = page "Payment Slip List";
            }
            action("Liste Lignes Règlement")
            {
                Caption = 'Liste Lignes Règlement';
                ApplicationArea = All;

                RunObject = page "Liste lignes reglements";
            }

        }
        addafter(Journals)
        {
            group("Accounting Report")
            {
                Caption = 'Etats Comptabilité';




                action("General Journal")
                {
                    Caption = 'Journal Géneral';
                    ApplicationArea = All;

                    RunObject = report "STJournal general"; //10800;
                }
                action(Feuille)
                {
                    Caption = 'Feuille';
                    ApplicationArea = All;

                    RunObject = report STJournals;//10801;
                }
                action("G/L Trial Balance ")
                {
                    Caption = 'Balance Comptes Généreaux avec totalisation';
                    ApplicationArea = All;

                    RunObject = report "STGL Trial Balancetotalisation";
                }
                action("General Ledger Accounts")
                {
                    Caption = 'Grand Livre Comptes Généreaux';
                    ApplicationArea = All;

                    RunObject = report "STGrand livre comptes generaux";
                }
                action("Customer Ledger")
                {
                    Caption = 'Grand Livre Client';
                    ApplicationArea = All;

                    RunObject = Report "STGrand livre clients";
                }

                action("vendor Ledger")
                {
                    Caption = 'Grand Livre fournisseur';
                    ApplicationArea = All;

                    RunObject = Report "STGrand livre fournisseurs";
                }

                action("Bank Account Trial Balance")
                {
                    Caption = 'Balance Compte bancaire';
                    ApplicationArea = All;

                    RunObject = Report "STBalance comptes bancaires";//10809;
                }

                action("General Ledger Bank Account")
                {
                    Caption = 'Grand Livre Compte bancaire';
                    ApplicationArea = All;

                    RunObject = Report "STGrandlivre comptes bancaires";//10810   ;
                }

                /*   action("Customer Journal")
                   {
                       Caption = 'Journal Compte Client';
                       ApplicationArea = All;

                       RunObject = Report 70021;//10813;
                   }

                   action("Vendor Journal")
                   {
                       Caption = 'Journal Compte Fournisseur';
                       ApplicationArea = All;

                       RunObject = Report 70022;//10814;
                   }*/

                action("Balance clients")
                {
                    Caption = 'Balance clients';
                    ApplicationArea = All;

                    RunObject = Report "Balance des clients";//10805;
                }

                action("Balance fournisseurs")
                {
                    Caption = 'Balance fournisseurs';
                    ApplicationArea = All;

                    RunObject = Report "Balance fournisseurs";//10807;
                }
                action("General Account Statement")
                {
                    Caption = 'Relevé Compte Général';
                    ApplicationArea = All;

                    RunObject = Report "Relevé de compte général";// 10842;
                }

                action("Releve de compte")
                {
                    Caption = 'Relevé de compte client';
                    ApplicationArea = All;

                    RunObject = Report "STRelevee de compte";
                }

                action("Balance Client par Groupe compta.")
                {
                    Caption = 'Balance Client par Groupe de comptabilisation';
                    ApplicationArea = All;

                    RunObject = Report "Customer Trial Balance";
                }
                action("Balance fourn par Groupe compta.")
                {
                    Caption = 'Balance Fournisseur par Groupe de Comptabilisation';
                    ApplicationArea = All;

                    RunObject = Report "Vendor Trial Balance PG";
                }


                action("Evaluation stock")
                {
                    Caption = 'Evaluation stock';
                    ApplicationArea = All;

                    RunObject = Report "Inventory Valuation Exp Cost";
                }


                action("Tableau amm")
                {
                    Caption = 'Tableau d''amortissement';
                    ApplicationArea = All;

                    RunObject = Report "STFixed Asset - Book Value 01";
                }



            }
        }

    }

    var
        myInt: Integer;
}


