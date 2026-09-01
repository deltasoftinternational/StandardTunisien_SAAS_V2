tableextension 71044 SalesHeaderArchive extends "Sales Header Archive"
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
        field(71005; "STFacture Proforma"; Boolean)
        {
            Caption = 'Facture proforma';
            DataClassification = ToBeClassified;
        }
        field(71006; STImpayeMnt; Decimal)
        {
            Caption = 'Solde Impayé (DS)';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(STImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field("Bill-to Customer No."),
                                                                  "Copied To No." = const('')));
        }
        field(71007; STImpayeFilter; Text[50])
        {
            Caption = 'FiltreImpaye';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(71008; STAvoirCorrectif; Boolean)
        {
            Caption = 'Avoir Correctif';
            Editable = false;

        }
    }
}
