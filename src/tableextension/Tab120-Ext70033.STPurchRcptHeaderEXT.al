tableextension 70033 "ST PurchRcptHeader EXT" extends "Purch. Rcpt. Header" //120
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
        field(70007; FNP; Boolean)
        {
            Caption = 'FNP';
            FieldClass = FlowField;
            CalcFormula = exist("Purch. Rcpt. Line" where("Document No." = field("No."), "ST INR Quantity" = filter(<> 0)));
            Editable = false;
        }

    }

}