tableextension 71032 "ST PurchInvLine EXT" extends "Purch. Inv. Line" //123
{
    fields
    {
        field(71000; Fodec; Boolean)
        {
            Caption = 'Fodec';
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

    }
    keys
    {
        key(StKey1; Type, "No.")
        {

        }

    }

}