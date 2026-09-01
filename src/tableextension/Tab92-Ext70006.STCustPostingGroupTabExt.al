tableextension 70006 "ST CustPostingGroupTabExt" extends "Customer Posting Group" //92
{
    fields
    {
        field(70000; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;

        }
        field(70001; "STStamp Fiscal Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }
        field(70002; "STStamp Fiscal Account"; Code[20])
        {
            CaptionML = FRA = 'Timbre Fiscal';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(70003; "STSG/L Account Filter"; text[500])
        {
            Caption = 'Filtre comptes généraux associés';

            TableRelation = "G/L Account";
            TestTableRelation = false;
            ValidateTableRelation = false;
        }

    }

}