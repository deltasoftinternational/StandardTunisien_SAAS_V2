tableextension 71016 "ST Payment StepTabExt" extends "Payment Step" //10862
{

    fields
    {

        field(71000; "STBanque Entête Obligatoire"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Banque entête obligatoire';
        }
        field(71001; STAgent_Remis_Obligatoire; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Agent remis obligatoire';
        }
        field(71002; STCode_Motif_Obligatoir; Boolean) //OK
        {
            DataClassification = ToBeClassified;
            Caption = 'Code motif obligatoire';
        }



        field(71005; "STTiré Oblig."; Boolean)//OK
        {
            DataClassification = ToBeClassified;
            Caption = 'Tiré obligatoire';
        }
        field(71006; "STCode Journal Ligne"; Boolean) //ok
        {
            DataClassification = ToBeClassified;
            Caption = 'Code journal ligne';
        }
        field(71007; "STCode Coffre"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code coffre';
            TableRelation = "ST Coffre".STCode;
        }
        field(71008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }
        field(71009; "STControle Solde Caisse"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contrôle Solde Caisse';
        }

    }






    var
        Text000: Label 'Deleting the default report is not allowed.';
        Text001: Label 'You cannot assign a number series with numbers longer than 10 characters.';
}

