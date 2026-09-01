page 70015 "STRisqueClientList"
{

    Caption = 'Risques clients';
    PageType = List;
    SourceTable = STRisqueClientFRs;
    SourceTableView = Where(Type = const(Customer));
    Editable = false;
    ApplicationArea = all;
    UsageCategory = Lists;
    InsertAllowed = False;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Customer.Name)
                {
                    Caption = 'Nom';
                    ApplicationArea = All;
                }
                field(LimiteCredit; Customer."Credit Limit (LCY)")
                {
                    Caption = 'Limite de crédit';
                    ApplicationArea = All;
                }
                field(TotalCommercial; TotalCommercial)
                {
                    Caption = 'Total Commercial';
                    ApplicationArea = all;
                }
                field(SoldeDS; Customer."Balance (LCY)")
                {
                    Caption = 'Solde DS';
                    ApplicationArea = All;
                }
                field(ShippedNotInvoiced; Customer."Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Livré non facturé DS';
                    ApplicationArea = All;
                }
                field(OutstandingOrders; Customer."Outstanding Orders (LCY)")
                {
                    caption = 'Commandes lancés non livrés';
                    ApplicationArea = All;
                }
                field(TotalEncours; TotalEncours)
                {
                    Caption = 'Total Encours';
                    ApplicationArea = All;
                }
                field(ChequeEnCoffreMnt; Rec.CltChequeEnCoffreMnt)
                {
                    Visible = ChequeEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(ChequeEncVersMnt; Rec.CltChequeEncVersMnt)
                {
                    Visible = ChequeEncVersVisible;
                    ApplicationArea = All;
                }

                field(ChequeCertifEnCoffreMnt; Rec.CltChequeCertifEnCoffreMnt)
                {
                    Visible = ChequeEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(ChequeCertifEncVersMnt; Rec.CltChequeCertifEncVersMnt)
                {
                    Visible = ChequeEncVersVisible;
                    ApplicationArea = All;
                }
                field(CltChequeRemisEscMnt; Rec.CltChequeRemisEscMnt)
                {
                    Visible = ChequeRemisEscVisible;
                    ApplicationArea = All;
                }
                field(CltChequeCertifRemisEscMnt; Rec.CltChequeCertifRemisEscMnt)
                {
                    Visible = ChequeRemisEscVisible;
                    ApplicationArea = All;
                }
                field(CltChequeEncoursEscMnt; Rec.CltChequeEncoursEscMnt)
                {
                    Visible = ChequeEncourEscVisible;
                    ApplicationArea = all;

                }
                field(CltChequeCertifEncoursEscMnt; Rec.CltChequeCertifEncoursEscMnt)
                {
                    Visible = ChequeEncourEscVisible;
                    ApplicationArea = all;

                }
                field(ChequeImpayeMnt; Rec.CltChequeImpayeMnt)
                {
                    Visible = ChequeImpayeVisible;
                    ApplicationArea = All;
                }
                field(ChequeContentieuxMnt; Rec.CltChequeContentieuxMnt)
                {
                    Visible = ChequeContentieuxVisible;
                    ApplicationArea = All;
                }
                field(HistChequeImpayeMnt; Rec.CltHistChequeImpayeMnt)
                {
                    Visible = ChequeImpayeVisible;
                    ApplicationArea = All;
                }

                field(TraiteEnCoffreMnt; Rec.CltTraiteEnCoffreMnt)
                {
                    Visible = TraiteEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(TraiteRemisEncMnt; Rec.CltTraiteRemisEncMnt)
                {
                    Visible = TraiteRemisEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteEncoursEncMnt; Rec.CltTraiteEncoursEncMnt)
                {
                    Visible = TraiteEncoursEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteRemisEscMnt; Rec.CltTraiteRemisEscMnt)
                {
                    Visible = TraiteRemisEscVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteRemiseEscNonEchueMnt; rec.CltTraiteRemiseEscNonEchueMnt)
                {
                    ApplicationArea = ALL;
                }
                field(TraiteEncoursEscMnt; Rec.CltTraiteEncoursEscMnt)
                {
                    Visible = TraiteEncoursEscVisible;
                    ApplicationArea = All;
                }
                field(TraiteAvalEnCoffreMnt; Rec.CltTraiteAvalEnCoffreMnt)
                {
                    Visible = TraiteEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(TraiteAvalRemisEncMnt; Rec.CltTraiteAvalRemisEncMnt)
                {
                    Visible = TraiteRemisEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteAvalEncoursEncMnt; Rec.CltTraiteAvalEncoursEncMnt)
                {
                    Visible = TraiteEncoursEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteAvalRemisEscMnt; Rec.CltTraiteAvalRemisEscMnt)
                {
                    Visible = TraiteRemisEscVisible;
                    ApplicationArea = All;
                }
                field(TraiteAvalEncoursEscMnt; Rec.CltTraiteAvalEncoursEscMnt)
                {
                    Visible = TraiteEncoursEscVisible;
                    ApplicationArea = All;
                }
                field(TraiteImpayeMnt; Rec.CltTraiteImpayeMnt)
                {
                    Visible = TraiteImpayeVisible;
                    ApplicationArea = All;
                }
                field(TraiteContentieuxMnt; Rec.CltTraiteContentieuxMnt)
                {
                    Visible = TraiteContentieuxVisible;
                    ApplicationArea = All;
                }
                field(HistTraiteImpMnt; Rec.CltHistTraiteImpMnt)
                {
                    Visible = TraiteImpayeVisible;
                    ApplicationArea = All;
                }
                field("DLT Customer G/L Amount"; Rec."DLT Customer G/L Amount")
                {
                    ApplicationArea = all;
                }


            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("OpenCard")
            {
                Caption = 'Fiche Client';
                Image = Customer;
                ApplicationArea = all;
                RunObject = page "Customer Card";
                RunPageLink = "No." = field(Code);
            }
        }
    }
    var
        ChequeEnCoffreVisible: Boolean;
        ChequeEncVersVisible: Boolean;
        ChequeRemisEscVisible: Boolean;
        ChequeEncourEscVisible: Boolean;
        ChequeImpayeVisible: Boolean;
        ChequeContentieuxVisible: Boolean;
        TraiteEnCoffreVisible: Boolean;
        TraiteRemisEncVisible: Boolean;
        TraiteEncoursEncVisible: Boolean;
        TraiteRemisEscVisible: Boolean;
        TraiteEncoursEscVisible: Boolean;
        TraiteImpayeVisible: Boolean;
        TraiteContentieuxVisible: Boolean;
        RecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Customer: Record Customer;
        DateReferenceEscEch: Date;
        TotalCommercial, TotalEncours : Decimal;

    trigger OnOpenPage()
    begin

        RecRisqueClientSetup.Get();
        If RecRisqueClientSetup.CltChequeEnCoffre <> '' then ChequeEnCoffreVisible := True;
        If RecRisqueClientSetup.CltChequeEncVers <> '' then ChequeEncVersVisible := True;
        if RecRisqueClientSetup.CltChequeRemisEsc <> '' then ChequeRemisEscVisible := true;
        if RecRisqueClientSetup.CltChequeEncoursEsc <> '' then ChequeEncourEscVisible := true;
        If RecRisqueClientSetup.CltChequeImpaye <> '' then ChequeImpayeVisible := True;
        If RecRisqueClientSetup.CltChequeContentieux <> '' then ChequeContentieuxVisible := True;
        If RecRisqueClientSetup.CltTraiteEnCoffre <> '' then TraiteEnCoffreVisible := True;
        If RecRisqueClientSetup.CltTraiteRemisEnc <> '' then TraiteRemisEncVisible := True;
        If RecRisqueClientSetup.CltTraiteEncoursEnc <> '' then TraiteEncoursEncVisible := True;
        If RecRisqueClientSetup.CltTraiteRemisEsc <> '' then TraiteRemisEscVisible := True;
        If RecRisqueClientSetup.CltTraiteEncoursEsc <> '' then TraiteEncoursEscVisible := True;
        If RecRisqueClientSetup.CltTraiteImpaye <> '' then TraiteImpayeVisible := True;
        If RecRisqueClientSetup.CltTraiteContentieux <> '' then TraiteContentieuxVisible := True;
        Rec.SetFilter(CltChequeRemisEscFilter, RecRisqueClientSetup.CltChequeRemisEsc);
        rec.SetFilter(CltChequeEncoursEscFilter, RecRisqueClientSetup.CltChequeEncoursEsc);
        Rec.SetFilter(CltChequeEnCoffreFilter, RecRisqueClientSetup.CltChequeEnCoffre);
        Rec.SetFilter(CltChequeEncVersFilter, RecRisqueClientSetup.CltChequeEncVers);
        Rec.SetFilter(CltChequeImpayeFilter, RecRisqueClientSetup.CltChequeImpaye);
        Rec.SetFilter(CltChequeContentieuxFilter, RecRisqueClientSetup.CltChequeContentieux);
        Rec.SetFilter(CltTraiteEnCoffreFilter, RecRisqueClientSetup.CltTraiteEnCoffre);
        Rec.SetFilter(CltTraiteRemisEncFilter, RecRisqueClientSetup.CltTraiteRemisEnc);
        Rec.SetFilter(CltTraiteEncoursEncFilter, RecRisqueClientSetup.CltTraiteEncoursEnc);
        Rec.SetFilter(CltTraiteRemisEscFilter, RecRisqueClientSetup.CltTraiteRemisEsc);
        Rec.SetFilter(CltTraiteEncoursEscFilter, RecRisqueClientSetup.CltTraiteEncoursEsc);
        Rec.SetFilter(CltTraiteImpayeFilter, RecRisqueClientSetup.CltTraiteImpaye);
        Rec.SetFilter(CltTraiteContentieuxFilter, RecRisqueClientSetup.CltTraiteContentieux);
        if format(RecRisqueClientSetup.PeriodRefEscopmte) <> '' then
            DateReferenceEscEch := CalcDate(RecRisqueClientSetup.PeriodRefEscopmte, Today)
        else
            DateReferenceEscEch := Today;

        Rec.SetFilter(DateRefEscompteFilter, '>=%1', DateReferenceEscEch);
    end;

    trigger OnAfterGetRecord()
    begin

        RecRisqueClientSetup.Get();
        Rec.SetFilter(CltChequeEnCoffreFilter, RecRisqueClientSetup.CltChequeEnCoffre);
        Rec.SetFilter(CltChequeEncVersFilter, RecRisqueClientSetup.CltChequeEncVers);
        Rec.SetFilter(CltChequeImpayeFilter, RecRisqueClientSetup.CltChequeImpaye);
        Rec.SetFilter(CltChequeContentieuxFilter, RecRisqueClientSetup.CltChequeContentieux);
        Rec.SetFilter(CltTraiteEnCoffreFilter, RecRisqueClientSetup.CltTraiteEnCoffre);
        Rec.SetFilter(CltTraiteRemisEncFilter, RecRisqueClientSetup.CltTraiteRemisEnc);
        Rec.SetFilter(CltTraiteEncoursEncFilter, RecRisqueClientSetup.CltTraiteEncoursEnc);
        Rec.SetFilter(CltTraiteRemisEscFilter, RecRisqueClientSetup.CltTraiteRemisEsc);
        Rec.SetFilter(CltTraiteEncoursEscFilter, RecRisqueClientSetup.CltTraiteEncoursEsc);
        Rec.SetFilter(CltTraiteImpayeFilter, RecRisqueClientSetup.CltTraiteImpaye);
        Rec.SetFilter(CltTraiteContentieuxFilter, RecRisqueClientSetup.CltTraiteContentieux);

        if format(RecRisqueClientSetup.PeriodRefEscopmte) <> '' then
            DateReferenceEscEch := CalcDate(RecRisqueClientSetup.PeriodRefEscopmte, Today)
        else
            DateReferenceEscEch := Today;

        Rec.SetFilter(DateRefEscompteFilter, '>=%1', DateReferenceEscEch);
        Customer.get(Rec.Code);
        Customer.CalcFields("Balance (LCY)");
        Customer.CalcFields("Shipped Not Invoiced (LCY)");
        Customer.CalcFields("Outstanding Orders (LCY)");
        TotalEncours := Rec.GetMntEcours(Rec.code);
        TotalCommercial := TotalEncours + Customer."Balance (LCY)" + Customer."Shipped Not Invoiced (LCY)" + Customer."Outstanding Orders (LCY)";
        //
        if CustomerPostingGroup.get(Customer."Customer Posting Group") then
            if CustomerPostingGroup."STSG/L Account Filter" <> '' then
                Rec.SetFilter("DLT G/L Account Filter", CustomerPostingGroup."STSG/L Account Filter");

    end;

    trigger OnAfterGetCurrRecord()
    begin
    end;

    var
        CustomerPostingGroup: Record "Customer Posting Group";
}
