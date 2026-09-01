tableextension 71002 "ST PaymentPostBufferExt" extends "Payment Post. Buffer" //10864
{
    fields
    {
        field(71000; "STCode Retenue à la Source"; Code[10])
        {
            CaptionML = FRA = 'Code Retenue à la Source', ENU = 'Code Retenue à la Source';
        }
        field(71001; "STCompte Retenue"; Code[20])
        {
            CaptionML = FRA = 'Compte Retenue', ENU = 'Compte Retenue';
        }
        field(71002; "STAmount Retenue"; Decimal)
        {
            CaptionML = FRA = 'Amount Retenue', ENU = 'Amount Retenue';
        }
        field(71003; "STAmount Retenue (LCY)"; Decimal)
        {
            CaptionML = FRA = 'Amount Retenue (LCY)', ENU = 'Amount Retenue (LCY)';
        }

        field(71004; STCommentaires; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commentaire';
        }
        field(71005; "STOrder No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° commande';
        }
        field(71006; STCoffre; Code[20])
        {
            Caption = 'Coffre';
            DataClassification = ToBeClassified;
        }
        field(71008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }

        field(71042; "STSlip Origin No."; Code[20])
        {
            Caption = 'Bordereau origine';
            Editable = false;
        }

        field(71043; "STSlip Origin line No."; Integer)
        {
            Caption = 'N° ligne bordereau origine';
            Editable = false;
        }
        field(71044; "STPayment Method Code"; Code[10])
        {
            Caption = 'Mode de règlement';
            TableRelation = "Payment Method".Code;
        }

        field(71051; "StCompte Commission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Commission';
            TableRelation = "G/L Account";
        }
        field(71052; "StAmount Comission"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Commission';
        }
        field(71053; "StAmount Comission (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount Comission (LCY)';
        }
        field(71054; "StCompte TVA/Comission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte TVA/Comission';
        }
        field(71055; "StAmount TVA/Comission"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte TVA/Comission';
        }

        field(71056; "STAmount TVA/Comission (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount TVA/Comission (LCY)';
        }



    }

}