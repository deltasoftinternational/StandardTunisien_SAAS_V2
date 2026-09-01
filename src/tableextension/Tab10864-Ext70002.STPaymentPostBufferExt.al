tableextension 71002 "Payment Post. Buffer FR" extends "Payment Post. Buffer FR" //10838
{
    fields
    {
        field(70000; "STCode Retenue à la Source"; Code[10])
        {
            CaptionML = FRA = 'Code Retenue à la Source', ENU = 'Code Retenue à la Source';
        }
        field(70001; "STCompte Retenue"; Code[20])
        {
            CaptionML = FRA = 'Compte Retenue', ENU = 'Compte Retenue';
        }
        field(70002; "STAmount Retenue"; Decimal)
        {
            CaptionML = FRA = 'Amount Retenue', ENU = 'Amount Retenue';
        }
        field(70003; "STAmount Retenue (LCY)"; Decimal)
        {
            CaptionML = FRA = 'Amount Retenue (LCY)', ENU = 'Amount Retenue (LCY)';
        }

        field(70004; STCommentaires; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commentaire';
        }
        field(70005; "STOrder No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° commande';
        }
        field(70006; STCoffre; Code[20])
        {
            Caption = 'Coffre';
            DataClassification = ToBeClassified;
        }
        field(70008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }

        field(70042; "STSlip Origin No."; Code[20])
        {
            Caption = 'Bordereau origine';
            Editable = false;
        }

        field(70043; "STSlip Origin line No."; Integer)
        {
            Caption = 'N° ligne bordereau origine';
            Editable = false;
        }
        field(70044; "STPayment Method Code"; Code[10])
        {
            Caption = 'Mode de règlement';
            TableRelation = "Payment Method".Code;
        }

        field(70051; "StCompte Commission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Commission';
            TableRelation = "G/L Account";
        }
        field(70052; "StAmount Comission"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Commission';
        }
        field(70053; "StAmount Comission (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Comission (LCY)';
        }
        field(70054; "StCompte TVA/Comission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte TVA/Comission';
        }
        field(70055; "StAmount TVA/Comission"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte TVA/Comission';
        }

        field(70056; "STAmount TVA/Comission (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount TVA/Comission (LCY)';
        }



    }

}