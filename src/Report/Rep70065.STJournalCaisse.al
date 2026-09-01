report 71065 "STJournalCaisse"
{
    Caption = 'Etat Journal Caisse';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/JournalCaisse.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(TypeBorderau; DataBuffer."Code Field 1")
            {

            }
            column(startdate; startdate)
            {

            }
            column(enddate; enddate)
            {

            }
            column(Picture; RecGCompanyInfo.Picture)
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            column(Phone; RecGCompanyInfo."Phone No.")
            {

            }
            column(Fax; RecGCompanyInfo."Fax No.")
            {

            }
            column(MatriculeFiscal; RecGCompanyInfo."VAT Registration No.")
            {
            }



            dataitem("ST Coffre"; "ST Coffre")
            {


                column(STCode; STCode)
                {

                }
                dataitem("Payment Line"; "Payment Line")
                {
                    DataItemLink = STcoffre = field(stcode);
                    DataItemTableView = ORDER(Ascending);

                    column(Credit_Amount; "Credit Amount")
                    {

                    }

                    column("STType_Règlement"; "STType Règlement")
                    {

                    }
                    column(STType_ED; STType_ED)
                    {
                    }
                    column(Posting_Date; "Posting Date")
                    {

                    }
                    column(STCoffre; STCoffre)
                    {

                    }


                    trigger OnPreDataItem()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        lGeneralLedgerSetup.Get();
                        "Payment Line".SetRange("Posting Date", startdate, enddate);
                        "Payment Line".SetRange(STType_ED, STType_ED::Encaissement);
                        "Payment Line".SetFilter(STCodeSituationPaiement, lGeneralLedgerSetup."ST Caisse recette");
                        "Payment Line".setrange("STType Règlement", DataBuffer."Code Field 1");
                        if UserSetup.Get(UserId) then
                            if UserSetup.STCoffre <> '' then
                                "Payment Line".setrange(STCoffre, UserSetup.STCoffre)
                            else
                                if coffre <> '' then
                                    "Payment Line".setrange(STCoffre, coffre);


                    end;
                }
            }
            trigger OnAfterGetRecord();
            var
                lPaymentLine: Record "Payment Line";
            begin
                IF Integer.Number > 1 THEN
                    DataBuffer.NEXT();

            end;

            trigger OnPreDataItem()
            var
            begin
                DataBuffer.RESET();
                Integer.SETRANGE(Number, 1, DataBuffer.COUNT);
                IF NOT DataBuffer.FINDFIRST() THEN
                    ERROR('n''existe pas de type réglement');
            end;

        }
        dataitem(IntegerD; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(TypeBorderauD; DataBuffer."Code Field 1")
            {

            }
            dataitem("Payment LineD"; "Payment Line")
            {

                DataItemTableView = ORDER(Ascending);

                column(Credit_AmountD; "Credit Amount")
                {

                }
                column("STType_RèglementD"; "STType Règlement")
                {

                }
                column(STType_EDD; STType_ED)
                {
                }
                column(Posting_DateD; "Posting Date")
                {

                }
                column(STCoffreD; STCoffre)
                {

                }
                column(startdateD; startdate)
                {

                }
                column(enddateD; enddate)
                {

                }
                column(No_; "No.")
                {

                }
                column(STSituationPaiement; STSituationPaiement)
                {

                }
                trigger OnAfterGetRecord()
                var
                    PostingDate: Date;
                begin
                    PostingDate := "Payment LineD"."Posting Date";

                end;

                trigger OnPreDataItem()
                var
                    UserSetup: Record "User Setup";
                begin
                    lGeneralLedgerSetup.Get();
                    "Payment LineD".Reset();
                    "Payment LineD".SetRange("Posting Date", startdate, enddate);
                    "Payment LineD".SetRange(STType_ED, STType_ED::Encaissement);
                    "Payment LineD".SetRange("STType Règlement", DataBuffer."Code Field 1");
                    "Payment LineD".SetFilter(STCodeSituationPaiement, lGeneralLedgerSetup."ST Caisse depense");
                    if UserSetup.Get(UserId) then
                        if UserSetup.STCoffre <> '' then
                            "Payment Line".setrange(STCoffre, UserSetup.STCoffre)
                        else
                            IF coffre <> '' then
                                "Payment Line".setrange(STCoffre, coffre);
                end;
            }
            trigger OnAfterGetRecord();
            begin
                IF IntegerD.Number > 1 THEN begin
                    DataBuffer.NEXT();
                    if DataBuffer."Code Field 1" = 'TPE' then
                        CurrReport.SKIP();
                end;

            end;

            trigger OnPreDataItem()
            var
            begin
                DataBuffer.RESET();
                IntegerD.SETRANGE(Number, 1, DataBuffer.COUNT);
                IF NOT DataBuffer.FINDFIRST() THEN
                    ERROR('n''existe pas de type réglement');
            end;

        }
        dataitem(lInteger; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(lTypeBorderau; DataBuffer."Code Field 1")
            {

            }
            dataitem("lPayment Line"; "Payment Line")
            {

                DataItemTableView = ORDER(Ascending);

                column(lCredit_Amount; "Credit Amount")
                {

                }

                trigger OnAfterGetRecord()
                var
                    PostingDate: Date;
                begin
                    PostingDate := "lPayment Line"."Posting Date";

                end;

                trigger OnPreDataItem()
                var
                    UserSetup: Record "User Setup";
                begin
                    lGeneralLedgerSetup.Get();
                    "lPayment Line".SetFilter("Posting Date", '<%1', startdate);
                    "lPayment Line".SetFilter(STCoffre, '<>%1', '');
                    "lPayment Line".SetRange(STType_ED, "lPayment Line".STType_ED::Encaissement);
                    "lPayment Line".SetRange("STType Règlement", DataBuffer."Code Field 1");
                    "lPayment Line".SetRange("Copied To No.", '');
                    "lPayment Line".SetFilter(STCodeSituationPaiement, lGeneralLedgerSetup."ST Caisse recette");
                    if UserSetup.Get(UserId) then
                        if UserSetup.STCoffre <> '' then
                            "Payment Line".setrange(STCoffre, UserSetup.STCoffre)
                        else
                            if coffre <> '' then
                                "Payment Line".setrange(STCoffre, coffre);
                end;
            }
            trigger OnAfterGetRecord();
            begin
                IF lInteger.Number > 1 THEN
                    DataBuffer.NEXT();
            end;

            trigger OnPreDataItem()
            var
            begin
                DataBuffer.RESET();
                lInteger.SETRANGE(Number, 1, DataBuffer.COUNT);
                IF NOT DataBuffer.FINDFIRST() THEN
                    ERROR('n''existe pas de type réglement');
            end;

        }


    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(startdate; startdate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Date début';
                        ToolTip = 'Specifier la date début';
                    }
                    field(enddate; enddate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Date fin';
                        ToolTip = 'Specifier la date fin';
                    }
                    field(coffre; coffre)
                    {

                        ApplicationArea = Basic, Suite;
                        Caption = 'Coffre';
                        ToolTip = 'Specifier le coffre';
                        Visible = coffreexiste;
                        TableRelation = "ST Coffre".STCode;
                    }

                }

            }
        }

    }
    trigger OnInitReport()
    var
        UserSetup: Record "User Setup";
    begin
        CLEAR(RecGCompanyInfo);
        RecGCompanyInfo.GET();
        RecGCompanyInfo.CALCFIELDS(RecGCompanyInfo.Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";
        coffreexiste := false;
        if UserSetup.Get(UserId) then
            if UserSetup.STCoffre = '' then
                coffreexiste := true;

    end;

    trigger OnPreReport();
    var

    begin
        DataBuffer.RESET();
        DataBuffer.DELETEALL();
        for i := 1 to 4 do begin
            DataBuffer.Init();
            DataBuffer.ID := i;
            case i of
                1:

                    DataBuffer."Code Field 1" := Format(STTypeBorderauENUM::"Chèque");
                2:

                    DataBuffer."Code Field 1" := Format(STTypeBorderauENUM::Traite);
                3:

                    DataBuffer."Code Field 1" := Format(STTypeBorderauENUM::"Espèce");
                4:

                    DataBuffer."Code Field 1" := Format(STTypeBorderauENUM::Tpe);
            end;
            DataBuffer.Insert();

        end;



    end;


    var
        startdate: Date;
        enddate: date;
        coffre: code[20];
        lGeneralLedgerSetup: Record "General Ledger Setup";
        RecGCompanyInfo: Record "Company Information";
        STTypeBorderauENUM: option "Chèque",Traite,"Espèce",TPE;
        DataBuffer: Record "Name/Value Buffer" temporary;
        i: Integer;
        TXTADRESSE: Text[1024];
        coffreexiste: Boolean;





}

