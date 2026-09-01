tableextension 71035 "ST PurchInvHeaderEXT" extends "Purch. Inv. Header" //122
{
    fields
    {

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

}