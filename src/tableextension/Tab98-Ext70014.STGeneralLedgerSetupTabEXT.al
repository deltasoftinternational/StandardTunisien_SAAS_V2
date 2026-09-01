tableextension 71014 "ST GeneralLedgerSetupTabEXT" extends "General Ledger Setup" //98
{
    fields
    {
        field(71000; "STRetenu par def."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "ST Groupe retenue".STCode;
            Caption = 'Retenu par défaut';
        }
        field(71001; "Nombre caractères CIN"; Integer)
        {
            DataClassification = CustomerContent;

            Caption = 'Nombre caractères CIN';
        }
        field(71002; "STmodele cheque"; Boolean)
        {
            Caption = 'Visibilité Modèle chèque';
            DataClassification = ToBeClassified;
        }
        field(71003; "STActivate Mandatory Dimension"; Boolean)
        {
            Caption = 'Activer contrôle des axes obligatoires';
            DataClassification = ToBeClassified;
        }
        field(71005; "ST Enable Bank Slip"; Boolean)
        {
            Caption = 'Activer N° Bordereau banque';
            DataClassification = ToBeClassified;
        }
        field(71006; "ST Enable reasoncode slip pay."; Boolean)
        {
            Caption = 'Activer code motif sur le bordereau de paiement';
            DataClassification = ToBeClassified;
        }
        field(71007; "ST INR Source Code"; Code[10])
        {

            DataClassification = ToBeClassified;
            Caption = 'Code Journal FNP';
            TableRelation = "Source Code";
        }
        field(71008; "ST INR Series"; Code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Souche FNP';
            TableRelation = "No. Series";
        }


        field(71009; "STView Sum GLEntries"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Afficher solde écritures comptables';

        }

        field(71010; "ST No showing due date"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Ne pas Afficher date d''échéance grand livre compte généraux';


        }

        field(71011; "ST REG Debit"; Text[50])
        {
            CaptionML = ENU = 'Debit Regulation / Account', FRA = 'REG Débit/Compte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71012; "ST FED progress"; Text[50])
        {
            CaptionML = ENU = 'FED progress', FRA = 'FED en cours';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }

        field(71013; "ST FED Accepted"; Text[50])
        {
            CaptionML = ENU = 'FED Accepted', FRA = 'FED Accepté';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(71014; "ST Prorogation 1"; Text[50])
        {
            Caption = 'Prorogation 1';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(71015; "ST Prorogation 2"; Text[50])
        {
            Caption = 'Prorogation 2';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(71016; "ST Prorogation 3"; Text[50])
        {
            Caption = 'Prorogation 3';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }
        field(71017; "ST FED settled"; Text[50])
        {
            CaptionML = ENU = 'FED settled', FRA = 'FED Reglé';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }

        field(71018; "ST LC"; Text[50])
        {
            Caption = 'LC';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;

        }

        field(71019; "ST Enable seriesNo Coffre"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Désactiver souche par coffre';


        }
        field(71020; "Delete Autorised Payment"; Boolean)
        {

            DataClassification = ToBeClassified;
            Caption = 'Autorisé suppression Ligne Bord.';


        }
        field(71021; "ST Caisse recette"; Text[1000])
        {
            Caption = 'Caisse recette';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71022; "ST Caisse depense"; Text[1000])
        {
            Caption = 'Caisse dépense';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71023; "ST tresorerie recette"; Text[1000])
        {
            Caption = 'Tresorerie recette';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71024; "ST tresorerie depense"; Text[1000])
        {
            Caption = 'Tresorerie dépense';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71025; "ST tresorerie engagement"; Text[1000])
        {
            Caption = 'Tresorerie engagement';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(71026; "ST No Open Fiscal Years"; Integer)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'No Open Fiscal Years', FRA = 'Nb exercies comptables ouverts';
        }
        field(71027; "ST Manual Check Selection"; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Manual Check Selection', FRA = 'Sélection manuelle des chèques';
        }

    }


}