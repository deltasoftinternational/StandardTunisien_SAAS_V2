tableextension 70014 "ST GeneralLedgerSetupTabEXT" extends "General Ledger Setup" //98
{
    fields
    {
        field(70000; "STRetenu par def."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "ST Groupe retenue".STCode;
            Caption = 'Retenu par défaut';
        }
        field(70001; "Nombre caractères CIN"; Integer)
        {
            DataClassification = CustomerContent;

            Caption = 'Nombre caractères CIN';
        }
        field(70002; "STmodele cheque"; Boolean)
        {
            Caption = 'Visibilité Modèle chèque';
            DataClassification = ToBeClassified;
        }
        field(70003; "STActivate Mandatory Dimension"; Boolean)
        {
            Caption = 'Activer contrôle des axes obligatoires';
            DataClassification = ToBeClassified;
        }
        field(70005; "ST Enable Bank Slip"; Boolean)
        {
            Caption = 'Activer N° Bordereau banque';
            DataClassification = ToBeClassified;
        }
        field(70006; "ST Enable reasoncode slip pay."; Boolean)
        {
            Caption = 'Activer code motif sur le bordereau de paiement';
            DataClassification = ToBeClassified;
        }
        field(70007; "ST INR Source Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Code Journal FNP';
            TableRelation = "Source Code";
        }
        field(70008; "ST INR Series"; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Souche FNP';
            TableRelation = "No. Series";
        }


        field(70009; "STView Sum GLEntries"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Afficher solde écritures comptables';

        }

        field(70010; "ST No showing due date"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Ne pas Afficher date d''échéance grand livre compte généraux';


        }

        field(70011; "ST REG Debit"; Text[50])
        {
            CaptionML = ENU = 'Debit Regulation / Account', FRA = 'REG Débit/Compte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70012; "ST FED progress"; Text[50])
        {
            CaptionML = ENU = 'FED progress', FRA = 'FED en cours';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }

        field(70013; "ST FED Accepted"; Text[50])
        {
            CaptionML = ENU = 'FED Accepted', FRA = 'FED Accepté';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(70014; "ST Prorogation 1"; Text[50])
        {
            Caption = 'Prorogation 1';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(70015; "ST Prorogation 2"; Text[50])
        {
            Caption = 'Prorogation 2';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(70016; "ST Prorogation 3"; Text[50])
        {
            Caption = 'Prorogation 3';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(70017; "ST FED settled"; Text[50])
        {
            CaptionML = ENU = 'FED settled', FRA = 'FED Reglé';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }

        field(70018; "ST LC"; Text[50])
        {
            Caption = 'LC';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }

        field(70019; "ST Enable seriesNo Coffre"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Désactiver souche par coffre';


        }
        field(70020; "Delete Autorised Payment"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Autorisé suppression Ligne Bord.';


        }
        field(70021; "ST Caisse recette"; Text[1000])
        {
            Caption = 'Caisse recette';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70022; "ST Caisse depense"; Text[1000])
        {
            Caption = 'Caisse dépense';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70023; "ST tresorerie recette"; Text[1000])
        {
            Caption = 'Tresorerie recette';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70024; "ST tresorerie depense"; Text[1000])
        {
            Caption = 'Tresorerie dépense';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70025; "ST tresorerie engagement"; Text[1000])
        {
            Caption = 'Tresorerie engagement';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(70026; "ST No Open Fiscal Years"; Integer)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'No Open Fiscal Years', FRA = 'Nb exercies comptables ouverts';
        }
        field(70027; "ST Manual Check Selection"; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Manual Check Selection', FRA = 'Sélection manuelle des chèques';
        }

    }


}