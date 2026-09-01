tableextension 71022 "ST UserSetupTabExt" extends "User Setup" //91
{

    fields
    {


        field(70000; STCoffre; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ST Coffre".STCode;
            Caption = 'Coffre';
        }
        field(70001; "STcaisse-Depense-par defaut"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            Caption = 'caisse-Depense-par defaut';
        }
        field(70002; "STcaisse-Recette-par defaut"; Code[20])
        {
            Caption = 'caisse-Recette-par defaut';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(70003; "ST modify caisse depense"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Modifier la caisse de dépense';

        }

        field(70004; "ST modify commission"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Modifier la commission';

        }
        field(70005; "ST Modif Post. grp. on Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mofier groupe compta Commande & Expédition';
        }
        field(70006; "ST Show All Unpaid Traite"; boolean)
        {
            Caption = 'Afficher les traites impayées de tous les coffres';
            DataClassification = ToBeClassified;

        }

        field(70007; "ST Admin Payment Slip"; boolean)
        {
            Caption = 'Administrateur Bordereau de paiement';
        }
        field(70008; "ST View All Bank Account"; boolean)
        {
            Caption = 'Afficher tous les comptes bancaires';
        }

    }




}

