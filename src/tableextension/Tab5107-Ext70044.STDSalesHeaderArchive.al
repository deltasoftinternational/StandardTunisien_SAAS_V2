tableextension 70044 SalesHeaderArchive extends "Sales Header Archive"
{
    fields
    {
        field(70000; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;

        }
        field(70001; "STStamp Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }
        field(70005; "STFacture Proforma"; Boolean)
        {
            Caption = 'Facture proforma';
            DataClassification = ToBeClassified;
        }
        field(70006; STImpayeMnt; Decimal)
        {
            Caption = 'Solde Impayé (DS)';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(STImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field("Bill-to Customer No."),
                                                                  "Copied To No." = const('')));
        }
        field(70007; STImpayeFilter; Text[50])
        {
            Caption = 'FiltreImpaye';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70008; STAvoirCorrectif; Boolean)
        {
            Caption = 'Avoir Correctif';
            Editable = false;

        }
    }
}
