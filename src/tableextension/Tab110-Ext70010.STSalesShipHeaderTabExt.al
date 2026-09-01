tableextension 71010 "ST SalesShipHeaderTabExt" extends "Sales Shipment Header" //110
{
    fields
    {
        field(71000; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;

        }
        field(71001; "STStamp Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }
    }
}