tableextension 71022 "ST UserSetupTabExt" extends "User Setup" //91
{

    fields
    {


        field(71000; STCoffre; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ST Coffre".STCode;
            Caption = 'Coffre';
        }
        field(71001; "STcaisse-Depense-par defaut"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            Caption = 'caisse-Depense-par defaut';
        }
        field(71002; "STcaisse-Recette-par defaut"; Code[20])
        {
            Caption = 'caisse-Recette-par defaut';
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
        }
        field(71003; "ST modify caisse depense"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Modifier la caisse de dépense';

        }

        field(71004; "ST modify commission"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Modifier la commission';

        }
        field(71005; "ST Modif Post. grp. on Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mofier groupe compta Commande & Expédition';
        }
        field(71006; "ST Show All Unpaid Traite"; boolean)
        {
            Caption = 'Afficher les traites impayées de tous les coffres';
            DataClassification = ToBeClassified;

        }

        field(71007; "ST Admin Payment Slip"; boolean)
        {
            Caption = 'Administrateur Bordereau de paiement';
        }
        field(71008; "ST View All Bank Account"; boolean)
        {
            Caption = 'Afficher tous les comptes bancaires';
        }

    }




}

