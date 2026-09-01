report 70067 EffetEscToPaye
{
    ApplicationArea = All;
    Caption = 'EffetEscToPaye';
    ProcessingOnly = true;

    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PaymentLine; "Payment Line")
        {
            DataItemTableView = where("Copied To No." = const(''), STCodeSituationPaiement = filter(<> ''));
            trigger OnPreDataItem()
            begin
                GrisqueSetup.Get();
                if GrisqueSetup.CltTraiteEncoursEsc = '' then
                    Error('');

                PaymentLine.SetFilter(STCodeSituationPaiement, GrisqueSetup.CltTraiteEncoursEsc);
                if format(GrisqueSetup.PeriodPayEffetEsc) <> '' then
                    DateReferenceEscEch := CalcDate(GrisqueSetup.PeriodPayEffetEsc, Today())
                else
                    DateReferenceEscEch := Today();

                PaymentLine.SetFilter("Due Date", '<=%1', DateReferenceEscEch);
            end;



            trigger OnPostDataItem()
            begin
                ModifyAll(STCodeSituationPaiement, GrisqueSetup.CltTraiteEscPaye);
            end;
        }
    }
    var
        GrisqueSetup: Record STSetupRisqueClientFrs;
        DateReferenceEscEch: Date;
}
