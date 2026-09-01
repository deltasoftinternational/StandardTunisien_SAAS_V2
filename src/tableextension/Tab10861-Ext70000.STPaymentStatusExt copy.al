tableextension 71000 "ST PaymentStatusExt" extends "Payment Status" //10861
{
    fields
    {
        field(71000; "STCalculer retenue a la source"; Boolean)
        {
            CaptionML = FRA = 'Calculer retenue a la source', ENU = 'Calculer retenue a la source';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CLEAR(PaymentStatus);
                PaymentStatus.RESET();
                PaymentStatus.SETCURRENTKEY("Payment Class", "STCalculer retenue a la source");
                PaymentStatus.SETFILTER("Payment Class", "Payment Class");
                PaymentStatus.SETFILTER("STCalculer retenue a la source", '%1', TRUE);
                IF PaymentStatus.FIND('-') AND ("STCalculer retenue a la source" = TRUE) THEN
                    ERROR(Error001);
            end;
        }

        field(71001; "STObligatoire Cheque/Traite"; Boolean) //OK
        {
            DataClassification = ToBeClassified;
            Caption = 'Obligatoire chéque/traite';
        }
        field(71002; "STObligatoire Code Banque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Obligatoire code banque';
        }
        field(71003; "STObligatoire Commentaire"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Obligatoire commentaire';
        }
        field(71004; "STAutoriser Modifcation Entête"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Autoriser modification entête';
        }
        field(71005; "STCompte en-tête"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte entête';
        }
        field(71006; "STMofi automatique BQ Entê"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Modif automatique banque entête';
        }
        field(71007; "STModifiable"; Boolean)
        {
            Caption = 'Ligne Modifiable';
            DataClassification = ToBeClassified;

        }

        field(71008; "STLibelle modifiable"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Libellé modifiable';
        }
        field(71009; "STDue Date Obligatoire"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Echéanche Obligatoire';
        }
        field(71010; "ST Référence chèque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Référence chèque';
            Description = 'DELTA MD 05-02-2020';
        }
        field(71011; STCodeSituationPaiement; Code[20])
        {
            Caption = 'Code situation paiement';
            TableRelation = STSituationPaiement.Code;
        }
        field(75011; "ST Status"; Option)
        {
            Caption = 'Status';
            Description = 'DELTA AK 12-03-18';
            OptionCaption = ',Blocked,In Progress ,Confirmed,Printed,Ledger,Canceled';
            OptionMembers = " ",Blocked,"In Progress ",Confirmed,Printed,Ledger,Canceled;
        }
        field(71012; "ST LC Ship. date mandatory"; Boolean)
        {
            CaptionML = ENU = 'Latest ship. date mandatory', FRA = 'Date ultime d''exp. LC oblig.';
            DataClassification = ToBeClassified;
        }
        field(71013; "ST LC valid. date mandatory"; Boolean)
        {
            CaptionML = ENU = 'LC valid. date mandatory', FRA = 'Date validité LC oblig.';
            DataClassification = ToBeClassified;
        }
        field(71014; "ST Autorise Modify Due Date"; Boolean)
        {
            Caption = 'Autoriser Modifier Date Echéance & Référence';
            DataClassification = ToBeClassified;
        }




    }
    var
        Text000: Label 'Deleting the first report is not allowed.';
        Text001: Label 'Deleting is not allowed because this Payment Status is already used.';
        PaymentStatus: Record "Payment Status";
        PaymentLine: Record "Payment Line";
        Error001: Label 'Le calcul de Retenu à la Source ce fait une seule fois !';
        Error002: Label 'Le calcul de Retenu sur T.V.A fait une seule fois !';

}