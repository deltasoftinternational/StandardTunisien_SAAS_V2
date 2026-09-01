report 71044 "Customer Trial Balance"
{
    // Meg01.00 RZ (30-07-18): Numbers Format modification.(ALPTY-000022)
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/70044-CustomerTrialBalancePG.rdl';

    Caption = 'Balance client par groupe de comptabilisation V2';
    UsageCategory = ReportsAndAnalysis;


    PreviewMode = PrintLayout;
    ApplicationArea = All;
    Permissions = TableData "Detailed Cust. Ledg. Entry" = rm;
    dataset
    {
        dataitem(DataItem6836; "Detailed Cust. Ledg. Entry")
        {
            RequestFilterFields = "Customer No.", "STDate Filter";
            column(GroupCompta; DataItem6836."STCustomer Posting Group")
            {
            }
            column(CustomerPostingGroup_DetailedCustLedgEntry; DataItem6836."STCustomer Posting Group")
            {
            }
            column(Filterdate; STRSUBSTNO(Text006, PreviousStartDate, PreviousEndDate))
            {
            }
            column(FilterGroupeCompta; DataItem6836.GetFilter("STCustomer Posting Group"))
            {
            }
            column(customer1; DataItem6836.GetFilter("Customer No."))
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(PreviousFiterDate; STRSUBSTNO(Text006, PreviousStartDate, PreviousEndDate))
            {
            }
            column(PreviousEndDate_; Format(PreviousEndDate))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text004_PreviousEndDate_; STRSUBSTNO(Text004, PreviousEndDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(Customer_TABLECAPTION__________Filter; DataItem6836.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; DataItem6836."Customer No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY; PreviousCreditAmountLCY - PreviousDebitAmountLCY)
            {
            }
            column(PeriodDebitAmountLCY; PeriodDebitAmountLCY)
            {
            }
            column(PeriodCreditAmountLCY; PeriodCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PeriodDebitAmountLCY___PreviousCreditAmountLCY_PeriodCreditAmountLCY_; (PreviousDebitAmountLCY + PeriodDebitAmountLCY) - (PreviousCreditAmountLCY + PeriodCreditAmountLCY))
            {
            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY_; (PreviousCreditAmountLCY + PeriodCreditAmountLCY) - (PreviousDebitAmountLCY + PeriodDebitAmountLCY))
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY_Control1120069; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY_Control1120072; PreviousCreditAmountLCY - PreviousDebitAmountLCY)
            {
            }
            column(PeriodDebitAmountLCY_Control1120075; PeriodDebitAmountLCY)
            {
            }
            column(PeriodCreditAmountLCY_Control1120078; PeriodCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PeriodDebitAmountLCY___PreviousCreditAmountLCY_PeriodCreditAmountLCY__Control1120081; (PreviousDebitAmountLCY + PeriodDebitAmountLCY) - (PreviousCreditAmountLCY + PeriodCreditAmountLCY))
            {
            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY__Control1120084; (PreviousCreditAmountLCY + PeriodCreditAmountLCY) - (PreviousDebitAmountLCY + PeriodDebitAmountLCY))
            {
            }
            column(Customer_Trial_BalanceCaption; Customer_Trial_BalanceCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Balance_at_Starting_DateCaption; Balance_at_Starting_DateCaptionLbl)
            {
            }
            column(Balance_Date_RangeCaption; Balance_Date_RangeCaptionLbl)
            {
            }
            column(Balance_at_Ending_dateCaption; Balance_at_Ending_dateCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(DebitCaption_Control1120030; DebitCaption_Control1120030Lbl)
            {
            }
            column(CreditCaption_Control1120032; CreditCaption_Control1120032Lbl)
            {
            }
            column(DebitCaption_Control1120034; DebitCaption_Control1120034Lbl)
            {
            }
            column(CreditCaption_Control1120036; CreditCaption_Control1120036Lbl)
            {
            }
            column(Grand_totalCaption; Grand_totalCaptionLbl)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(PrintCustWithoutBalance; PrintCustWithoutBalance)
            {

            }

            column(GroupComptaCaptionLbl; GroupComptaCaptionLbl)
            {
            }
            column(Fax; CompanyInformation."Fax No.")
            {
            }
            column(Phone; CompanyInformation."Phone No.")
            {
            }
            column(MatriculeFiscal; CompanyInformation."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            trigger OnAfterGetRecord()
            begin

                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                PeriodDebitAmountLCY := 0;
                PeriodCreditAmountLCY := 0;
                IF not Customer.GET(DataItem6836."Customer No.") THEN
                    CurrReport.skip;

                IF ("Posting Date" > 0D) AND ("Posting Date" <= PreviousEndDate) THEN BEGIN
                    PreviousDebitAmountLCY += "Debit Amount (LCY)";
                    PreviousCreditAmountLCY += "Credit Amount (LCY)";
                END;
                IF ("Posting Date" >= StartDate) AND ("Posting Date" <= EndDate) THEN BEGIN
                    PeriodDebitAmountLCY += "Debit Amount (LCY)";
                    PeriodCreditAmountLCY += "Credit Amount (LCY)";
                END;
            end;

            trigger OnPostDataItem()
            var
                codeClient: code[50];
            begin
                codeClient := DataItem6836."Customer No.";
                //IF NOT PrintCustWithoutBalance AND (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) THEN
                //  CurrReport.SKIP;
                //
                //   Message('%1 %2 %3', PeriodDebitAmountLCY, PeriodCreditAmountLCY, PrintCustWithoutBalance);
                //IF NOT PrintCustWithoutBalance AND (PeriodDebitAmountLCY = 0.000) AND (PeriodCreditAmountLCY = 0.000) THEN
                //    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                //////
                //>>DELTA SN
                //IF GroupeCompta = '' THEN
                //ERROR(ERR001);
                //<<DELTA SN
                /* YB020524 commenté et remplacé
                  IF GETFILTER("STDate Filter") = '' THEN
                       ERROR(Text001, FIELDCAPTION("STDate Filter"));
                   IF COPYSTR(GETFILTER("STDate Filter"), 1, 1) = '.' THEN
                       ERROR(Text002);
                   StartDate := GETRANGEMIN("STDate Filter");
                   PreviousEndDate := CLOSINGDATE(StartDate - 1);
                   FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                   TextDate := CONVERTSTR(TextDate, '.', ',');
                   FiltreDateCalc.VerifiyDateFilter(TextDate);
                   TextDate := COPYSTR(TextDate, 1, 8);
                   EVALUATE(PreviousStartDate, TextDate);
                   IF COPYSTR(GETFILTER("STDate Filter"), STRLEN(GETFILTER("STDate Filter")), 1) = '.' THEN
                       EndDate := 0D
                   ELSE
                       EndDate := GETRANGEMAX("STDate Filter");
                   CurrReport.CREATETOTALS(PreviousDebitAmountLCY, PreviousCreditAmountLCY, PeriodDebitAmountLCY, PeriodCreditAmountLCY);


                     PreviousDebitAmountLCY := 0;
                     PreviousCreditAmountLCY := 0;
                     PeriodDebitAmountLCY := 0;
                     PeriodCreditAmountLCY := 0;

                   SETFILTER("Entry Type", '<>%1', "Entry Type"::Application);

                   IF GroupeCompta <> '' THEN
                       SETFILTER("STCustomer Posting Group", '%1', GroupeCompta);
               */
                IF GETFILTER("STDate Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("STDate Filter"));
                IF COPYSTR(GETFILTER("STDate Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("STDate Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("STDate Filter"), STRLEN(GETFILTER("STDate Filter")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("STDate Filter");
                CurrReport.CREATETOTALS(PreviousDebitAmountLCY, PreviousCreditAmountLCY, PeriodDebitAmountLCY, PeriodCreditAmountLCY);

                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;
                PeriodDebitAmountLCY := 0;
                PeriodCreditAmountLCY := 0;

                SETFILTER("Entry Type", '<>%1', "Entry Type"::Application);
                CustomerPostingGroup1 := GroupeCompta;
                IF GroupeCompta <> '' THEN
                    SETFILTER("STCustomer Posting Group", '%1', GroupeCompta);

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    // field(PrintCustomersWithoutBalance; PrintCustWithoutBalance)
                    // {
                    //     Caption = 'Print Customers without Balance';
                    //     MultiLine = true;
                    //     ApplicationArea = all;
                    // }
                    field("Groupe Compta Client"; GroupeCompta)
                    {
                        ApplicationArea = all;
                        TableRelation = "Customer Posting Group";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        TXTADRESSE := CompanyInformation.Address + ' ' + CompanyInformation.City + ' ' + CompanyInformation."Post Code";
    end;

    trigger OnPreReport()
    begin
        Filter := DataItem6836.GETFILTERS;
    end;

    var
        Text001: Label 'Vous devez remplir le champ.';
        Text002: Label 'Vous devez spécifier une date de début.';
        Text003: Label 'Imprimé par %1';
        Text004: Label 'Date de début de l''exercice financier : %1';
        Text005: Label 'Page %1';
        Text006: Label 'Filtre date : %1  .. %2';

        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        PrintCustWithoutBalance: Boolean;
        "Filter": Text[250];
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PeriodDebitAmountLCY: Decimal;
        PeriodCreditAmountLCY: Decimal;
        Customer_Trial_BalanceCaptionLbl: Label 'Balance client par groupe de comptabilisation';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Nom';
        Balance_at_Starting_DateCaptionLbl: Label 'Solde à la date de début';
        Balance_Date_RangeCaptionLbl: Label 'Mouvements de la période';
        Balance_at_Ending_dateCaptionLbl: Label 'Solde à la date de fin';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        DebitCaption_Control1120030Lbl: Label 'Debit';
        CreditCaption_Control1120032Lbl: Label 'Credit';
        DebitCaption_Control1120034Lbl: Label 'Debit';
        CreditCaption_Control1120036Lbl: Label 'Credit';
        Grand_totalCaptionLbl: Label ' Total';
        Customer: Record Customer;
        GroupeCompta: Code[20];
        ERR001: Label 'Vous devez remplir le champ groupe de comptabilisation client.';
        CompanyInformation: Record "Company Information";
        GroupComptaCaptionLbl: Label 'Groupe compta. client';
        PrintWithoutTotal: Boolean;
        CustomerPostingGroup: Record "Customer Posting Group";
        Account: Code[20];
        TempCustomerPostingGroup: code[20];
        DetailedCustLedEntry: Record "Detailed Cust. Ledg. Entry";
        DETAILEDCUSTOMERLEDGERENTRY: Query DETAILEDCUSTOMERLEDGERENTRY;

        CustomerPostingGroup1: code[50];
        TotalPreviousDebitAmountLCY: Decimal;
        TotalPreviousCreditAmountLCY: Decimal;
        Datefilter: date;
        //customer1: code[20];
        CustomerNo: code[20];
        CustomerPostingGroup_DetailedCustLedgEntry: code[20];

        Counter1: Integer;
        TempoDetailed_CustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;
        TXTADRESSE: Text;
        OnLineNumber: Integer;
}
