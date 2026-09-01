tableextension 71008 "ST SalesInvHeaderTabExt" extends "Sales Invoice Header" //112
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