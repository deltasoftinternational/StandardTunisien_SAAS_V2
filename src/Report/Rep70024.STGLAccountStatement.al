report 71024 "Relevé de compte général"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/GL Account Statement.rdl';
    CaptionML = ENU = 'G/L Account Statement',
                FRA = 'Relevé de compte général';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; 15)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(CurrReportPageNo; STRSUBSTNO(Text002, CurrReport.PAGENO()))
            {
            }
            column(PrintedByText; STRSUBSTNO(Text001, ''))
            {
            }
            column(GLAccTableCaptionFilter; "G/L Account".TABLECAPTION + ' : ' + Filter)
            {
            }
            column(ApplicationStatus; STRSUBSTNO(Text005, SELECTSTR(ApplicationStatus + 1, Text006)))
            {
            }
            column(EvaluationDateStr; STRSUBSTNO(Text004, EvaluationDateStr))
            {
            }
            column(Name_GLAcc; "G/L Account".Name)
            {
            }
            column(No_GLAcc; "G/L Account"."No.")
            {
            }
            column(DebitAmount_GLAcc; "G/L Entry"."Debit Amount")
            {
            }
            column(CreditAmount_GLAcc; "G/L Entry"."Credit Amount")
            {
            }
            column(GLEntryDebitAmtCreditAmt; "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount")
            {
            }
            column(TotalDebit; TotalDebit)
            {
            }
            column(TotalCredit; TotalCredit)
            {
            }
            column(TotalBalance; TotalBalance)
            {
            }
            // column(GLEntryTypeFilter_GLAcc;"G/L Entry Type Filter")
            // {
            // }
            column(GLBaljustificationCaption; GLBaljustificationCaptionLbl)
            {
            }
            column(LetterCaption; LetterCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(DueDateCaptionLbl; DueDateCaptionLbl)
            {

            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(ExtDocNoCaption; ExtDocNoCaptionLbl)
            {
            }
            column(DocumentNoCaption; DocumentNoCaptionLbl)
            {
            }
            column(SourceCodeCaption; SourceCodeCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(GrandTotalCaption; GrandTotalCaptionLbl)
            {
            }
            column(Picture; companyInfo.Picture)
            {

            }
            column(name; companyInfo.Name)
            {

            }
            column(Phone; CompanyInfo."Phone No.")
            {

            }
            column(Fax; CompanyInfo."Fax No.")
            {

            }
            column(MatriculeFiscal; CompanyInfo."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            dataitem("G/L Entry"; 17)
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                column(DebitAmount_GLEntry; "Debit Amount")
                {
                }
                column(Letter_GLEntry; Letter)
                {
                }
                column(CreditAmount_GLEntry; "Credit Amount")
                {
                }
                column(PostingDate_Formatted; FORMAT("Posting Date"))
                {
                }
                column(Description_GLEntry; Description)
                {
                }
                column(SourceCode_GLEntry; "Source Code")
                {
                }
                column(DocumentNo_GLEntry; "Document No.")
                {
                }
                column(ExtDocNo_GLEntry; "External Document No.")
                {
                }
                column(Balance_GLEntry; Balance)
                {
                    AutoCalcField = false;
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(DebitAmtCreditAmt; "Debit Amount" - "Credit Amount")
                {
                }
                column(TotalOfAccGLAccNo; STRSUBSTNO(Text003, "G/L Account"."No."))
                {
                }
                column(EntryNo_GLEntry; "Entry No.")
                {
                }
                column(GLAccountNo_GLEntry; "G/L Account No.")
                {
                }
                // column(EntryType_GLEntry;"Entry Type")
                // {
                // }
                column(Due_Date; "Due Date")
                { }

                trigger OnAfterGetRecord();
                begin
                    TotalDebit := TotalDebit + "Debit Amount";
                    TotalCredit := TotalCredit + "Credit Amount";
                    TotalBalance := TotalBalance + "Debit Amount" - "Credit Amount";

                    IF EvaluationDate <> 0D THEN
                        CASE ApplicationStatus OF
                            ApplicationStatus::Applied:
                                IF ((Letter <> UPPERCASE(Letter)) OR (Letter = '')) OR
                                   ("Letter Date" > EvaluationDate)
                                THEN
                                    CurrReport.SKIP();
                            ApplicationStatus::"Not Applied":
                                IF ((Letter = UPPERCASE(Letter)) AND (Letter <> '')) AND
                                   ("Letter Date" < EvaluationDate)
                                THEN
                                    CurrReport.SKIP();
                        END
                    ELSE
                        CASE ApplicationStatus OF
                            ApplicationStatus::Applied:
                                IF (Letter <> UPPERCASE(Letter)) OR (Letter = '') THEN
                                    CurrReport.SKIP();
                            ApplicationStatus::"Not Applied":
                                IF (Letter = UPPERCASE(Letter)) AND (Letter <> '') THEN
                                    CurrReport.SKIP();
                        END;

                    Balance := Balance + "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount";
                end;

                trigger OnPreDataItem();
                begin
                    IF EvaluationDate <> 0D THEN
                        SETFILTER("Posting Date", '<=%1', EvaluationDate);
                    companyInfo.Get();
                    companyInfo.CalcFields(Picture);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Balance := 0;
            end;

            trigger OnPreDataItem();
            begin
                EvaluationDateStr := FORMAT(EvaluationDate);
                IF EvaluationDate = 0D THEN
                    EvaluationDateStr := '';
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
                    field(EvaluationDate; EvaluationDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Evaluation Date',
                                    FRA = 'Date d''évaluation';
                    }
                    field(GLEntries; ApplicationStatus)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'G/L Entries',
                                    FRA = 'Écritures comptables';
                        OptionCaptionML = ENU = 'All,Applied,Not Applied',
                                          FRA = 'Tous,Lettrés,Non lettrés';
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
        companyInfo.Get();
        TXTADRESSE := CompanyInfo.Address + ' ' + CompanyInfo.City + ' ' + CompanyInfo."Post Code";
    end;

    trigger OnPreReport();
    begin
        Filter := "G/L Account".GETFILTERS;
        EvaluationDateStr := '';
    end;

    var
        Text001: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text002: TextConst ENU = 'Page %1', FRA = 'Page %1';
        "Filter": Text;
        EvaluationDateStr: Text;
        companyInfo: Record "Company Information";
        ApplicationStatus: Option All,Applied,"Not Applied";
        EvaluationDate: Date;
        Balance: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        TotalBalance: Decimal;
        Text003: TextConst ENU = 'Total of account %1', FRA = 'Total du compte %1';
        Text004: TextConst ENU = 'Evaluation date : %1', FRA = 'Date d''évaluation : %1';
        Text005: TextConst ENU = 'G/L entries : %1', FRA = 'Écritures comptables : %1';
        Text006: TextConst ENU = 'All,Applied,Not Applied', FRA = 'Tous,Lettrés,Non lettrés';
        GLBaljustificationCaptionLbl: TextConst ENU = 'G/L balance justification', FRA = 'Relevé de solde par compte';
        LetterCaptionLbl: TextConst ENU = 'Letter', FRA = 'Lettre';
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        ExtDocNoCaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° doc. externe';
        DocumentNoCaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        SourceCodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code journal';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        GrandTotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        TXTADRESSE: Text;
}

