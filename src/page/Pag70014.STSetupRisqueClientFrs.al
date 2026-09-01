page 70014 "STSetupRisqueClientFrs"
{

    Caption = 'Paramètre Risque Client/Fournisseur';
    PageType = Card;
    SourceTable = STSetupRisqueClientFrs;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(Customer)
            {
                field(CltChequeEnCoffre; Rec.CltChequeEnCoffre)
                {
                    ApplicationArea = All;
                }
                field(CltChequeEnCoffreUsage; Rec.CltChequeEnCoffreUsage)
                {
                    ApplicationArea = All;
                }
                field(CltChequeImpaye; Rec.CltChequeImpaye)
                {
                    ApplicationArea = All;
                }
                field(CltChequeImpayeUsage; rec.CltChequeImpayeUsage)
                {
                    ApplicationArea = all;
                }
                field(CltChequeContentieux; Rec.CltChequeContentieux)
                {
                    ApplicationArea = All;
                }
                field(CltChequeContentieuxUsage; Rec.CltChequeContentieuxUsage)
                {
                    ApplicationArea = all;
                }
                field(CltChequeEncVers; Rec.CltChequeEncVers)
                {
                    ApplicationArea = All;
                }
                field(CltChequeEncVersUsage; Rec.CltChequeEncVersUsage)
                {
                    ApplicationArea = All;
                }
                field(CltChequeRemisEsc; Rec.CltChequeRemisEsc)
                {
                    ApplicationArea = all;
                }
                field(CltChequeRemisEscUsage; Rec.CltChequeRemisEscUsage)
                {
                    ApplicationArea = all;
                }
                field(CltChequeEncoursEsc; Rec.CltChequeEncoursEsc)
                {
                    ApplicationArea = all;
                }
                field(CltChequeEncoursEscUsage; Rec.CltChequeEncoursEscUsage)
                {
                    ApplicationArea = all;
                }
                field(CltTraiteEnCoffre; Rec.CltTraiteEnCoffre)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteEnCoffreUsage; Rec.CltTraiteEnCoffreUsage)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteRemisEnc; Rec.CltTraiteRemisEnc)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteRemisEncUsage; Rec.CltTraiteRemisEncUsage)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteEncoursEnc; Rec.CltTraiteEncoursEnc)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteEncoursEncUsage; Rec.CltTraiteEncoursEncUsage)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteRemisEsc; Rec.CltTraiteRemisEsc)
                {
                    ApplicationArea = All;
                }
                field(PeriodRefEscopmte; rec.PeriodRefEscopmte)
                {
                    ApplicationArea = all;
                }
                field(CltTraiteRemisEscUsage; Rec.CltTraiteRemisEscUsage)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteEncoursEsc; Rec.CltTraiteEncoursEsc)
                {
                    ApplicationArea = All;
                }

                field(CltTraiteEncoursEscUsage; Rec.CltTraiteEncoursEscUsage)
                {
                    ApplicationArea = All;
                }

                field(CltTraiteImpaye; Rec.CltTraiteImpaye)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteImpayeUsage; Rec.CltTraiteImpayeUsage)
                {
                    ApplicationArea = all;
                }
                field(CltTraiteContentieux; Rec.CltTraiteContentieux)
                {
                    ApplicationArea = All;
                }
                field(CltTraiteContentieuxUsage; Rec.CltTraiteContentieuxUsage)
                {
                    ApplicationArea = all;
                }
                field(CltTraiteEscPaye; rec.CltTraiteEscPaye)
                {
                    ApplicationArea = all;
                }
                field(PeriodPayEffetEsc; rec.PeriodPayEffetEsc)
                {
                    ApplicationArea = all;
                }

            }
            group(Vendor)
            {
                field(FrsTraiteRemise; Rec.FrsTraiteRemise)
                {
                    ApplicationArea = All;
                }
                field(FrsChequeEncours; Rec.FrsChequeEncours)
                {
                    ApplicationArea = All;
                }
                field(FrsTraiteEncours; Rec.FrsTraiteEncours)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(StituationPaiement)
            {
                ApplicationArea = All;
                Image = Setup;
                Caption = 'Situation Paiement';
                Promoted = true;
                PromotedIsBig = True;
                RunObject = Page STSituationPayment;
            }
            action(Synchronise)
            {
                ApplicationArea = All;
                Image = Setup;
                Caption = 'Synchroniser Client/Fournisseur';
                Promoted = true;
                PromotedIsBig = True;
                trigger OnAction()
                begin
                    Rec.SynchroniseClientFrs();
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        rec.Reset();
        if not Rec.Get() then
            Rec.InitSetup();
    end;
}
