report 71071 "STCustomer Trial Balance/PG"
{
    //OLD STCustomer Trial Balance/PG
    DefaultLayout = RDLC;
    Permissions = TableData "Detailed Vendor Ledg. Entry" = rm;
    RDLCLayout = './src/report/rdlc/CustomerTrialBalancePG.rdl';
    CaptionML = ENU = 'Customer/Posting Group Trial Balance PG',
                FRA = 'Balance Clients par Groupe de Comptabilisation';
    //Not Used UsageCategory = ReportsAndAnalysis;
    //Not Used ApplicationArea = All;
    dataset
    {

        dataitem(DetailedCustledgEntry; Integer)
        {
            DataItemTableView = SORTING(Number);



            column(GroupCompta;
            tempoDetailed_CustLedgEntry."STCustomer Posting Group")
            {
            }
            column(CustomerPostingGroup_DetailedCustLedgEntry; tempoDetailed_CustLedgEntry."STCustomer Posting Group")
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyInformation.Name)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO()))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(Customer_TABLECAPTION__________Filter; DetailedCustLedEntry.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; TempoDetailed_CustLedgEntry."Customer No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; (tempoDetailed_CustLedgEntry."Debit Amount (LCY)") - (tempoDetailed_CustLedgEntry."Credit Amount (LCY)"))
            {
            }

            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY; (tempoDetailed_CustLedgEntry."Credit Amount (LCY)") - (tempoDetailed_CustLedgEntry."Debit Amount (LCY)"))
            {
            }
            column(PeriodDebitAmountLCY; tempoDetailed_CustLedgEntry."Debit Amount")
            {
            }
            column(PeriodCreditAmountLCY; tempoDetailed_CustLedgEntry."Credit Amount")
            {
            }
            column(PreviousDebitAmountLCY_PeriodDebitAmountLCY___PreviousCreditAmountLCY_PeriodCreditAmountLCY_; (tempoDetailed_CustLedgEntry."Debit Amount (LCY)" + tempoDetailed_CustLedgEntry."Debit Amount") - (tempoDetailed_CustLedgEntry."Credit Amount (LCY)" + tempoDetailed_CustLedgEntry."Credit Amount"))
            {
            }
            column(PreviousCreditAmountLCY_PeriodCreditAmountLCY___PreviousDebitAmountLCY_PeriodDebitAmountLCY_; (tempoDetailed_CustLedgEntry."Credit Amount (LCY)" + tempoDetailed_CustLedgEntry."Credit Amount") - (tempoDetailed_CustLedgEntry."Debit Amount (LCY)" + tempoDetailed_CustLedgEntry."Debit Amount"))
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY_Control1120069; tempoDetailed_CustLedgEntry."Debit Amount (LCY)" - tempoDetailed_CustLedgEntry."Credit Amount (LCY)")
            {
            }
            column(PreviousCreditAmountLCY_PreviousDebitAmountLCY_Control1120072; tempoDetailed_CustLedgEntry."Credit Amount (LCY)" - tempoDetailed_CustLedgEntry."Debit Amount (LCY)")
            {
            }
            column(PeriodDebitAmountLCY_Control1120075; tempoDetailed_CustLedgEntry."Debit Amount")
            {
            }
            column(PeriodCreditAmountLCY_Control1120078; tempoDetailed_CustLedgEntry."Credit Amount")
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
            column(GroupComptaCaptionLbl; GroupComptaCaptionLbl)
            {
            }
            column(PrintWithoutTotal; PrintWithoutTotal)
            {
            }
            column(Account; Account)
            {
            }
            column(Datefilter; Datefilter)
            { }
            column(EndDate; EndDate)
            { }
            column(StartDate; StartDate)
            { }
            column(CustomerPostingGroup1; CustomerPostingGroup1) { }
            column(customer1; customer1) { }
            trigger OnAfterGetRecord()
            begin

                OnLineNumber := OnLineNumber + 1;

                IF OnLineNumber = 1 THEN
                    TempoDetailed_CustLedgEntry.FIND('-')
                ELSE
                    TempoDetailed_CustLedgEntry.NEXT();
                IF NOT Customer.GET(TempoDetailed_CustLedgEntry."Customer No.") THEN
                    CurrReport.SKIP();
                //  IF ("Posting Date" > 0D) AND ("Posting Date" <= PreviousEndDate) THEN BEGIN

                //  PreviousDebitAmountLCY := abs("Debit Amount (LCY)");
                //PreviousCreditAmountLCY := abs("Credit Amount (LCY)");
                // PreviousDebitAmountLCY := 0;
                //PreviousCreditAmountLCY := 0;


                // CustomerPostingGroup_DetailedCustLedgEntry := DETAILEDcustomerLEDGERENTRY.STCuster_Posting_Group;
                //  SetRange(Number,
                //DETAILEDcustomerLEDGERENTRY.counter);
                // until (counter1 = DETAILEDcustomerLEDGERENTRY.counter)
                // end else
                //   CurrReport.Skip();


                // end;



                //end;
                //     IF ("Posting Date" >= StartDate) AND ("Posting Date" <= EndDate) THEN BEGIN
                //         PeriodDebitAmountLCY := abs("Debit Amount (LCY)");
                //         PeriodCreditAmountLCY := abs("Credit Amount (LCY)");
                //     END;


            end;

            trigger OnPostDataItem()
            begin

            end;

            trigger OnPreDataItem()
            var
                int: Integer;
            begin

                tempoDetailed_CustLedgEntry.DeleteAll();
                IF (StartDate = 0D) and (EndDate = 0D) THEN
                    ERROR(Text001, (Datefilter));
                IF StartDate = 0D THEN
                    ERROR(Text002);

                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if CustomerPostingGroup1 <> '' then
                    DETAILEDcustomerLEDGERENTRY.SetFilter(STCuster_Posting_Group, CustomerPostingGroup1);
                if customer1 <> '' then
                    DETAILEDcustomerLEDGERENTRY.SetFilter(CustomerNo, customer1);
                // DETAILEDCUSTOMERLEDGERENTRY.SETFILTER(EntryType, '<>%1', DETAILEDCUSTOMERLEDGERENTRY.EntryType::Application);
                //yb  DETAILEDcustomerLEDGERENTRY.SetRange(Posting_Date, 0D, EndDate);
                DETAILEDcustomerLEDGERENTRY.SetRange(STDate_Filter, 0D, EndDate);
                DETAILEDcustomerLEDGERENTRY.Open();
                while DETAILEDcustomerLEDGERENTRY.Read() do begin
                    Counter1 += 1;

                    TempoDetailed_CustLedgEntry.Init();
                    tempoDetailed_CustLedgEntry."Entry No." := Counter1;
                    tempoDetailed_CustLedgEntry."Customer No." := DETAILEDCUSTOMERLEDGERENTRY.CustomerNo;
                    tempoDetailed_CustLedgEntry."Debit Amount (LCY)" := 0;
                    tempoDetailed_CustLedgEntry."Credit Amount (LCY)" := 0;
                    tempoDetailed_CustLedgEntry."Credit Amount" := 0;
                    tempoDetailed_CustLedgEntry."Debit Amount" := 0;
                    tempoDetailed_CustLedgEntry."STCustomer Posting Group" := DETAILEDCUSTOMERLEDGERENTRY.STCuster_Posting_Group;
                    if (DETAILEDcustomerLEDGERENTRY.Posting_Date > 0D) AND (DETAILEDcustomerLEDGERENTRY.Posting_Date <= PreviousEndDate)
                    then begin
                        tempoDetailed_CustLedgEntry."Debit Amount (LCY)" := DETAILEDcustomerLEDGERENTRY.Debit_Amount__LCY_;
                        tempoDetailed_CustLedgEntry."Credit Amount (LCY)" := DETAILEDcustomerLEDGERENTRY.Credit_Amount__LCY_;
                    end else begin
                        tempoDetailed_CustLedgEntry."Debit Amount" := DETAILEDcustomerLEDGERENTRY.Debit_Amount__LCY_;
                        tempoDetailed_CustLedgEntry."Credit Amount" := DETAILEDcustomerLEDGERENTRY.Credit_Amount__LCY_;
                    end;

                    tempoDetailed_CustLedgEntry.Insert();
                    Commit();
                end;
                DETAILEDCUSTOMERLEDGERENTRY.close();



                int := tempoDetailed_CustLedgEntry.Count;
                SetRange(Number, 1, Counter1);
                OnLineNumber := 0;

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

                    field(PrintCustomersWithoutBalance; PrintCustWithoutBalance)
                    {

                        ApplicationArea = All;
                        Caption = 'Imprimer tout';
                        MultiLine = true;
                    }

                    field(CustomerPostingGroup1; CustomerPostingGroup1)
                    {
                        ApplicationArea = All;
                        TableRelation = "Customer Posting Group".Code;
                        Caption = 'Groupe de comptabilisation';
                    }
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        caption = 'Date début';

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Date fin';
                    }
                    field(customer1; customer1)
                    {
                        ApplicationArea = all;
                        TableRelation = Customer;
                        Caption = 'Client';
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
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin

    end;

    var
        Text001: Label 'Vous devez remplir le champ.';
        Text002: Label 'Vous devez spécifier une date de début.';
        Text003: Label 'Imprimé par %1';
        Text004: Label 'Date de début de l''exercice financier : %1';
        Text005: Label 'Page %1';
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
        customer1: code[20];
        CustomerNo: code[20];
        CustomerPostingGroup_DetailedCustLedgEntry: code[20];

        Counter1: Integer;
        TempoDetailed_CustLedgEntry: Record "Detailed Cust. Ledg. Entry" temporary;

        OnLineNumber: Integer;

}

