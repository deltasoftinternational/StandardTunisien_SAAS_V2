tableextension 70032 "ST PurchInvLine EXT" extends "Purch. Inv. Line" //123
{
    fields
    {
        field(70000; Fodec; Boolean)
        {
            Caption = 'Fodec';
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

    }
    keys
    {
        key(StKey1; Type, "No.")
        {

        }

    }

}