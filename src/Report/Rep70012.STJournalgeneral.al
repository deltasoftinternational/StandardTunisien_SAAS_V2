report 70012 "STJournal general"
{


    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/GL Journal.rdl';
    CaptionML = ENU = 'G/L Journal',
                FRA = 'Journal_Général';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Date; Date)
        {
            DataItemTableView = SORTING("Period Type", "Period Start")
                                WHERE("Period Type" = CONST(Month));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Period Start";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
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
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_CurrReport_PAGENO_; STRSUBSTNO(Text004, CurrReport.PAGENO()))
            {
            }
            column(PageCaption; STRSUBSTNO(Text004, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(G_L_Entry__TABLECAPTION__________Filter; "G/L Entry".TABLECAPTION + ': ')
            {
            }
            column(Filter; Filter)
            {
            }
            column(Filter2; Filter2)
            {
            }
            column(Filter3; Filter3)
            {
            }
            column(Text006; Text006Lbl)
            {
            }
            column(IncludeSimulation; IncludeEntries)
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
            column(Hidden; Hidden)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(DebitTotal; DebitTotal)
            {
            }
            column(CreditTotal; CreditTotal)
            {
            }
            column(Date_Period_Type; "Period Type")
            {
            }
            column(Date_Period_Start; "Period Start")
            {
            }
            column(G_L_JournalCaption; G_L_JournalCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
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
            column(Grand_Total__Caption; Grand_Total__CaptionLbl)
            {
            }
            dataitem(SourceCode; "Source Code")
            {
                DataItemTableView = SORTING(Code);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Code";
                column(Date__Period_Type_; Date."Period Type")
                {
                }
                column(Date__Period_Name__________FORMAT_Year_; Date."Period Name" + ' ' + FORMAT(Year))
                {
                }
                column(SourceCode_Code; Code)
                {
                }
                dataitem("G/L Entry"; 17)
                {
                    DataItemLink = "Source Code" = FIELD(Code);
                    DataItemTableView = SORTING("Source Code", "Posting Date");
                    column(SourceCode_Code_Control1120032; SourceCode.Code)
                    {
                    }
                    column(SourceCode_Description; SourceCode.Description)
                    {
                    }
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(G_L_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(G_L_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(G_L_Entry_Source_Code; "Source Code")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        DebitTotal := DebitTotal + "Debit Amount";
                        CreditTotal := CreditTotal + "Credit Amount";
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                        /*   CASE IncludeEntries OF
                             IncludeEntries::Definitive:
                             SETRANGE("Entry Type","Entry Type"::Definitive);
                             IncludeEntries::Simulation:
                           SETRANGE("Entry Type","Entry Type"::Simulation);
                           END*/
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                Year := DATE2DMY("Period End", 3);
            end;

            trigger OnPreDataItem();
            begin
                Hidden := (IncludeEntries IN [IncludeEntries::All, IncludeEntries::Simulation]);
                IF GETFILTER("Period Start") = '' THEN
                    ERROR(Text001, FIELDCAPTION("Period Start"));
                IF COPYSTR(GETFILTER("Period Start"), 1, 1) = '.' THEN
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Period Start");
                FiltreDateCalc.VerifMonthPeriod(GETFILTER("Period Start"));
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                IF COPYSTR(GETFILTER("Period Start"), STRLEN(GETFILTER("Period Start")), 1) = '.' THEN
                    EndDate := 0D
                ELSE
                    EndDate := GETRANGEMAX("Period Start");
                IF EndDate = StartDate THEN
                    EndDate := FiltreDateCalc.ReturnEndingPeriod(StartDate, Date."Period Type"::Month);
                FiscalYearStatusText := STRSUBSTNO(Text005, FYFiscalClose.CheckFiscalYearStatus(GETFILTER("Period Start")));
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
                    field(GLEntry; IncludeEntries)
                    {
                        CaptionML = ENU = 'G/L Entry',
                                    FRA = 'Ecriture comptable';
                        ApplicationArea = All;
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



    trigger OnPreReport();
    begin
        Filter := Date.GETFILTERS;
        Filter2 := SourceCode.GETFILTERS;
        Filter3 := "G/L Entry".GETFILTERS;
        RecGCompanyInfo.GET();
        RecGCompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";
    end;

    var
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Page %1', FRA = 'Page %1';
        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        FYFiscalClose: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        TextDate: Text;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        Year: Integer;
        Text005: TextConst ENU = 'Fiscal-Year Status: %1', FRA = 'Statut de l''exercice comptable : %1';
        IncludeEntries: Option All,Definitive,Simulation;
        Hidden: Boolean;
        Text006Lbl: TextConst ENU = 'This report includes simulation entries.', FRA = 'Cet état inclut des écritures de simulation.';
        G_L_JournalCaptionLbl: TextConst ENU = 'G/L Journal', FRA = 'Journal général';
        CodeCaptionLbl: TextConst ENU = 'Code', FRA = 'Code';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Grand_Total__CaptionLbl: TextConst ENU = 'Grand Total :', FRA = 'Total général :';
        FiscalYearStatusText: Text;
        RecGCompanyInfo: Record "Company Information";
        TXTADRESSE: Text;
        Filter: Text;
        Filter2: Text;
        Filter3: Text;
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;
}

