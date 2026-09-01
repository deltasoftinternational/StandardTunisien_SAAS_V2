tableextension 70034 "ST  PurchRcptLine EXT" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(70000; Fodec; Boolean)
        {
            Caption = 'FODEC';
            DataClassification = ToBeClassified;
        }
        field(70002; "Montant Fodec"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "STStamp Fiscal Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }
        field(70006; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;

        }
        field(70003; "ST INR Quantity"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Quantité FNP';
        }
        field(70004; "ST INR Amount"; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Montant FNP';

        }
        field(70005; "ST Last Invoice Date"; Date)
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