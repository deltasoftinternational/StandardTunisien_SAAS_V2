tableextension 71034 "ST  PurchRcptLine EXT" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(71000; Fodec; Boolean)
        {
            Caption = 'FODEC';
            DataClassification = ToBeClassified;
        }
        field(71002; "Montant Fodec"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71001; "STStamp Fiscal Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }
        field(71006; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;

        }
        field(71003; "ST INR Quantity"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Quantité FNP';
        }
        field(71004; "ST INR Amount"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Montant FNP';

        }
        field(71005; "ST Last Invoice Date"; Date)
        {

            DataClassification = ToBeClassified;
            Caption = 'Dernière date de facturation';

        }

    }
    keys
    {
        key(StKey1; Type, "No.")
        {

        }

    }

}