report 70041 "STGrandlivre comptes bancaires"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Bank Acc. Detail Trial Balance.rdl';
    CaptionML = ENU = 'Bank Acc. Detail Trial Balance',
                FRA = 'Grand/livre comptes bancaires';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Bank Account"; 270)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(STRSUBSTNO_Text003____; STRSUBSTNO(Text003, ''))
            {
            }
            column(STRSUBSTNO_Text005____; STRSUBSTNO(Text005, ''))
            {
            }
            column(Bank_Account__TABLECAPTION__________Filter; "Bank Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(AfficherfiltreDate; AfficherfiltreDate)
            {

            }
            column(AfficherDate; AfficherDate)
            {

            }
            column(AfficherUtilisateur; AfficherUtilisateur)
            {

            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(Debit_Amount__LCY; "Debit Amount (LCY)")
            {
                AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                AutoFormatType = 1;
            }
            column(Credit_Amount__LCY; "Credit Amount (LCY)")
            {
                AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                AutoFormatType = 1;
            }
            column(ReportDebitAmountLCY; ReportDebitAmountLCY)
            {

            }
            column(ReportCreditAmountLCY; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
            }
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            column(DebitAmountLCY; DebitAmountLCY)
            {
            }
            column(CreditAmountLCY; CreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(Bank_Account__Bank_Account___Debit_Amount__LCY__; "Bank Account"."Debit Amount (LCY)")
            {
            }
            column(Bank_Account__Bank_Account___Credit_Amount__LCY__; "Bank Account"."Credit Amount (LCY)")
            {
            }
            column(Bank_Account___Debit_Amount__LCY______Bank_Account___Credit_Amount__LCY__; "Bank Account"."Debit Amount (LCY)" - "Bank Account"."Credit Amount (LCY)")
            {
            }
            column(Bank_Account_Date_Filter; "Date Filter")
            {
            }
            column(Bank_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Bank_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Bank_Acc__Detail_Trial_BalanceCaption; Bank_Acc__Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Picture; RecGCompanyInfo.Picture)
            {
            }
            column(RecGCompanyInfoCity; RecGCompanyInfo.City)
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
            column(TxtAdresse; TXTADRESSE)
            {

            }

            dataitem(Date; 2000000007)
            {
                DataItemTableView = SORTING("Period Type");
                PrintOnlyIfDetail = true;
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY_; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(DebitPeriodAmount; DebitPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Control1120082; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(CreditPeriodAmount; CreditPeriodAmount)
                {
                }
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Control1120086; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_CreditPeriodAmount; DebitPeriodAmount - CreditPeriodAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Control1120090; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("Bank Account Ledger Entry"; 271)
                {
                    DataItemLink = "Bank Account No." = FIELD("No."),
                                   "Posting Date" = FIELD("Date Filter"),
                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                    DataItemLinkReference = "Bank Account";
                    DataItemTableView = SORTING("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                    column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(PeriodTypeNo; PeriodTypeNo)
                    {
                    }
                    column(DateRecNo; DateRecNo)
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Bank_Account_Ledger_Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(Solde_Control1120142; Solde)
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(Account; Account)
                    {

                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF ("Debit Amount (LCY)" = 0) AND
                           ("Credit Amount (LCY)" = 0)
                        THEN
                            CurrReport.SKIP();
                        Solde := Solde + "Debit Amount (LCY)" - "Credit Amount (LCY)";

                        OriginalLedgerEntry.GET("Entry No.");

                        DebitPeriodAmount += "Debit Amount (LCY)";
                        CreditPeriodAmount += "Credit Amount (LCY)";

                        BankAccountPostingGroup.RESET();
                        BankAccountPostingGroup.SetRange(Code, "Bank Account Ledger Entry"."Bank Acc. Posting Group");
                        if BankAccountPostingGroup.FindFirst() then
                            Account := BankAccountPostingGroup."G/L Account No.";
                    end;

                    trigger OnPostDataItem();
                    begin
                        ReportDebitAmountLCY += "Debit Amount (LCY)";
                        ReportCreditAmountLCY += "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF DocNumSort THEN
                            SETCURRENTKEY("Bank Account No.", "Document No.", "Posting Date");
                        IF StartDate > Date."Period Start" THEN
                            Date."Period Start" := StartDate;
                        IF EndDate < Date."Period End" THEN
                            Date."Period End" := EndDate;
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                        SETRANGE("Bank Account No.", "Bank Account"."No.");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    DateRecNo += 1;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                    DateRecNo := 0;
                    PeriodTypeNo := "Period Type";
                    CurrReport.CREATETOTALS("Bank Account Ledger Entry"."Debit Amount (LCY)", "Bank Account Ledger Entry"."Credit Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord();
            var
                BankAccountBal: Record "Bank Account";
            begin
                /* PreviousDebitAmountLCY := 0;
                 PreviousCreditAmountLCY := 0;
                 BankLedgEntry.SETCURRENTKEY("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                 BankLedgEntry.SETRANGE("Bank Account No.", "No.");
                 IF "Global Dimension 1 Filter" <> '' THEN
                     BankLedgEntry.SETRANGE("Global Dimension 1 Code", "Global Dimension 1 Filter");
                 IF "Global Dimension 2 Filter" <> '' THEN
                     BankLedgEntry.SETRANGE("Global Dimension 2 Code", "Global Dimension 2 Filter");
                 BankLedgEntry.SETRANGE("Posting Date", 0D, PreviousEndDate);
                 IF BankLedgEntry.FINDSET THEN
                     REPEAT
                         PreviousDebitAmountLCY += "Debit Amount (LCY)";
                         PreviousCreditAmountLCY += "Credit Amount (LCY)";
                     UNTIL BankLedgEntry.NEXT = 0;

                 BankLedgEntry2.COPYFILTERS(BankLedgEntry);
                 BankLedgEntry2.SETRANGE("Posting Date", StartDate, EndDate);
                 Solde := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                 DebitPeriodAmount := 0;
                 CreditPeriodAmount := 0;

                 DebitAmountLCY += "Debit Amount (LCY)";
                 CreditAmountLCY += "Credit Amount (LCY)";*/
                PreviousDebitAmountLCY := 0;
                PreviousCreditAmountLCY := 0;

                BankAccountBal.COPY("Bank Account");
                BankAccountBal.SETRANGE("Date Filter", 0D, PreviousEndDate);
                BankAccountBal.CALCFIELDS("Debit Amount (LCY)", "Credit Amount (LCY)");
                PreviousDebitAmountLCY := BankAccountBal."Debit Amount (LCY)";
                PreviousCreditAmountLCY := BankAccountBal."Credit Amount (LCY)";

                Solde := PreviousDebitAmountLCY - PreviousCreditAmountLCY;

                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;

                DebitAmountLCY += "Debit Amount (LCY)";
                CreditAmountLCY += "Credit Amount (LCY)";


            end;

            trigger OnPreDataItem();
            begin

                IF GETFILTER("Date Filter") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                IF COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("Date Filter");

                CurrReport.CREATETOTALS("Debit Amount (LCY)", "Credit Amount (LCY)");

                DebitAmountLCY := 0;
                CreditAmountLCY := 0;

                CASE TotalBy OF
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                END;



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
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(DocNumSort; DocNumSort)
                    {
                        CaptionML = ENU = 'Sorted by Document No.',
                                    FRA = 'Trié par n° document';
                        ApplicationArea = All;
                    }

                    field(TotalBy; TotalBy)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Centralized by',
                                    FRA = 'Centralisé par';
                        OptionCaptionML = ENU = ' ,Week,Month,Quarter,Year',
                                          FRA = ' ,Semaine,Mois,Trimestre,Année';
                    }


                    field("Afficher fitres"; AfficherfiltreDate)
                    {
                        CaptionML = ENU = 'Show date filter',
                                    FRA = 'Afficher les fitres';
                        ApplicationArea = All;
                    }
                    field("Afficher date"; AfficherDate)
                    {
                        CaptionML = ENU = 'Show date',
                                    FRA = 'Afficher date';
                        ApplicationArea = All;
                    }
                    field("Afficher fitre date"; AfficherUtilisateur)
                    {
                        CaptionML = ENU = 'Show User',
                                    FRA = 'Afficher utilisateur';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            AfficherDate := true;
            AfficherUtilisateur := true;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        TotalBy := TotalBy::Month;
        RecGCompanyInfo.GET();
        RecGCompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";
        GeneralLedgerSetup.Get();

    end;

    trigger OnPreReport();
    begin
        Filter := "Bank Account".GETFILTERS;
    end;

    var
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Balance at %1 ', FRA = 'Solde au %1 ';
        Text007: TextConst ENU = 'Balance at %1', FRA = 'Solde au %1';
        Text008: TextConst ENU = 'Total', FRA = 'Total';
        BankLedgEntry: Record "Bank Account Ledger Entry";
        OriginalLedgerEntry: Record "Bank Account Ledger Entry";
        BankLedgEntry2: Record "Bank Account Ledger Entry";
        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        Solde: Decimal;
        TotalBy: Option " ",Week,Month,Quarter,Year;
        DocNumSort: Boolean;
        "Filter": Text;
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;
        PeriodTypeNo: Integer;
        DateRecNo: Integer;
        DebitAmountLCY: Decimal;
        CreditAmountLCY: Decimal;
        Bank_Acc__Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'Bank Acc. Detail Trial Balance', FRA = 'Grand livre comptes bancaires';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        Source_CodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code journal';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° doc. externe';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = '• suivre';
        Grand_TotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total plage de dates';
        Previous_pageCaptionLbl: TextConst ENU = 'Previous page', FRA = 'Page précédente';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page courante';
        RecGCompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;
        TXTADRESSE: Text;
        BankAccountPostingGroup: Record "Bank Account Posting Group";
        Account: Code[20];
        Period: Record Date;
}

