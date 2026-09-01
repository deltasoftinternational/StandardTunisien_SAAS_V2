pageextension 71016 "ST UserSetupPagExt" extends "User Setup" //119
{

    layout
    {

        addafter(Email)
        {

            field(Coffre; Rec.STCoffre)
            {
                ApplicationArea = All;
            }

            field("caisse-Depense-par defaut"; Rec."STcaisse-Depense-par defaut")
            {
                ApplicationArea = All;
            }
            field("caisse-Recette-par defaut"; Rec."STcaisse-Recette-par defaut")
            {
                ApplicationArea = All;

            }



        }

    }
    actions
    {
        addlast(Processing)
        {
            action(GeneralLedgerSetup)
            {
                CaptionML = ENU = 'General Ledger Setup', FRA = 'Paramètres comptabilité';
                Image = Card;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "STFiche param utilisateur";
                RunPageLink = "User ID" = field("User ID");

            }
        }
    }
}





