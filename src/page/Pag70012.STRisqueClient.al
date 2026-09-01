page 70012 "STRisqueClient"
{

    Caption = 'Risque client';
    PageType = CardPart;
    SourceTable = STRisqueClientFRs;
    Editable = false;
    InsertAllowed = False;
    DeleteAllowed = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {

            field("DLT Customer G/L Amount"; Rec."DLT Customer G/L Amount")
            {
                ApplicationArea = all;
            }
            group(Cheque)
            {
                ShowCaption = true;
                field(ChequeEnCoffreMnt; Rec.CltChequeEnCoffreMnt)
                {
                    Visible = ChequeEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(CltChequeCertifEnCoffreMnt; Rec.CltChequeCertifEnCoffreMnt)
                {
                    Visible = ChequeEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(ChequeEncVersMnt; Rec.CltChequeEncVersMnt)
                {
                    Visible = ChequeEncVersVisible;
                    ApplicationArea = All;
                }
                field(CltChequeCertifEncVersMnt; Rec.CltChequeCertifEncVersMnt)
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
            }
            group(Traite)
            {
                ShowCaption = true;
                field(TraiteEnCoffreMnt; Rec.CltTraiteEnCoffreMnt)
                {
                    Visible = TraiteEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteAvalEnCoffreMnt; Rec.CltTraiteAvalEnCoffreMnt)
                {
                    Visible = TraiteEnCoffreVisible;
                    ApplicationArea = All;
                }
                field(TraiteRemisEncMnt; Rec.CltTraiteRemisEncMnt)
                {
                    Visible = TraiteRemisEncVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteAvalRemisEncMnt; Rec.CltTraiteAvalRemisEncMnt)
                {
                    Visible = TraiteRemisEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteEncoursEncMnt; Rec.CltTraiteEncoursEncMnt)
                {
                    Visible = TraiteEncoursEncVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteAvalEncoursEncMnt; Rec.CltTraiteAvalEncoursEncMnt)
                {
                    Visible = TraiteEncoursEncVisible;
                    ApplicationArea = All;
                }
                field(TraiteRemisEscMnt; Rec.CltTraiteRemisEscMnt)
                {
                    Visible = TraiteRemisEscVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteAvalRemisEscMnt; Rec.CltTraiteAvalRemisEscMnt)
                {
                    Visible = TraiteRemisEscVisible;
                    ApplicationArea = All;
                }
                field(TraiteEncoursEscMnt; Rec.CltTraiteEncoursEscMnt)
                {
                    Visible = TraiteEncoursEscVisible;
                    ApplicationArea = All;
                }
                field(CltTraiteAvalEncoursEscMnt; Rec.CltTraiteAvalEncoursEscMnt)
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
            }

        }
    }
    var
        ChequeEnCoffreVisible: Boolean;
        ChequeEncVersVisible: Boolean;
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
        CustomerPostingGroup: Record "Customer Posting Group";
        Cust: Record Customer;
        ChequeRemisEscVisible, ChequeEncourEscVisible : Boolean;

    trigger OnOpenPage()
    begin
        RecRisqueClientSetup.Get();
        If RecRisqueClientSetup.CltChequeEnCoffre <> '' then ChequeEnCoffreVisible := True;
        If RecRisqueClientSetup.CltChequeEncVers <> '' then ChequeEncVersVisible := True;
        If RecRisqueClientSetup.CltChequeImpaye <> '' then ChequeImpayeVisible := True;
        If RecRisqueClientSetup.CltChequeContentieux <> '' then ChequeContentieuxVisible := True;
        If RecRisqueClientSetup.CltTraiteEnCoffre <> '' then TraiteEnCoffreVisible := True;
        If RecRisqueClientSetup.CltTraiteRemisEnc <> '' then TraiteRemisEncVisible := True;
        If RecRisqueClientSetup.CltTraiteEncoursEnc <> '' then TraiteEncoursEncVisible := True;
        If RecRisqueClientSetup.CltTraiteRemisEsc <> '' then TraiteRemisEscVisible := True;
        If RecRisqueClientSetup.CltTraiteEncoursEsc <> '' then TraiteEncoursEscVisible := True;
        If RecRisqueClientSetup.CltTraiteImpaye <> '' then TraiteImpayeVisible := True;
        If RecRisqueClientSetup.CltTraiteContentieux <> '' then TraiteContentieuxVisible := True;
        if RecRisqueClientSetup.CltChequeRemisEsc <> '' then ChequeRemisEscVisible := true;
        if RecRisqueClientSetup.CltChequeEncoursEsc <> '' then ChequeEncourEscVisible := true;
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
        Rec.SetFilter(CltChequeRemisEscFilter, RecRisqueClientSetup.CltChequeRemisEsc);
        rec.SetFilter(CltChequeEncoursEscFilter, RecRisqueClientSetup.CltChequeEncoursEsc);


    end;

    trigger OnAfterGetRecord()
    begin

        If Cust.get(Rec.Code) then
            if CustomerPostingGroup.get(Cust."Customer Posting Group") then
                if CustomerPostingGroup."STSG/L Account Filter" <> '' then
                    Rec.SetFilter("DLT G/L Account Filter", CustomerPostingGroup."STSG/L Account Filter");

    end;

    trigger OnAfterGetCurrRecord()
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
        Rec.SetFilter(CltChequeRemisEscFilter, RecRisqueClientSetup.CltChequeRemisEsc);
        rec.SetFilter(CltChequeEncoursEscFilter, RecRisqueClientSetup.CltChequeEncoursEsc);
    end;

}
