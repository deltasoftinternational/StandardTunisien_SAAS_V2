tableextension 70036 "ST PurchCrMemoHdrEXT" extends "Purch. Cr. Memo Hdr." //124
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