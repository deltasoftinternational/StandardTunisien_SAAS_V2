report 70013 "STJournals"
{


    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Journals.rdl';
    CaptionML = ENU = 'Journals',
                FRA = 'Journal__';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Date; 2000000007)
        {
            DataItemTableView = SORTING("Period Type", "Period Start");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Period Type", "Period Start";
            column(Title; Title)
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
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text006____; STRSUBSTNO(Text006, ''))
            {
            }
            column(STRSUBSTNO_Text007____; STRSUBSTNO(Text007, ''))
            {
            }
            column(GLEntry2_TABLECAPTION__________Filter; GLEntry2.TABLECAPTION + ': ' + Filter)
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
            column(Text012; Text012Lbl)
            {
            }
            column(Hidden; Hidden)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(SourceCode_TABLECAPTION__________Filter2; SourceCode.TABLECAPTION + ': ' + Filter2)
            {
            }
            column(Filter2; Filter2)
            {
            }
            column(DisplayEntries; DisplayEntries)
            {
            }
            column(SortingByNo; SortingByNo)
            {
            }
            column(DateRecNo; DateRecNo)
            {
            }
            column(DisplayCentral; DisplayCentral)
            {
            }
            column(DebitTotal; DebitTotal)
            {

            }
            column(CreditTotal; CreditTotal)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(G_L_Account_No_Caption; G_L_Account_No_CaptionLbl)
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
            column(typePeriode; typePeriode)
            {

            }

            dataitem(SourceCode; 230)
            {
                DataItemTableView = SORTING(Code);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Code";
                column(Date__Period_Type_; Date."Period Type")
                {
                }
                column(Date__Period_Name____YearString; Date."Period Name" + YearString)
                {
                }
                column(PeriodTypeNo; PeriodTypeNo)
                {
                }
                column(SourceCode_Code; Code)
                {
                }
                column(SourceCode_Description; Description)
                {
                }
                dataitem(DataItem7069; 17)
                {
                    DataItemLink = "Source Code" = FIELD(Code);
                    DataItemTableView = SORTING("Source Code", "Posting Date");
                    column(SourceCode2_Code; SourceCode2.Code)
                    {
                    }
                    column(SourceCode2_Description; SourceCode2.Description)
                    {
                    }
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                        AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                        AutoFormatType = 1;
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                        AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                        AutoFormatType = 1;
                    }
                    column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry__External_Document_No__; "External Document No.")
                    {
                    }
                    column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry_Description; Description)
                    {
                    }
                    column(STRSUBSTNO_Text008_FIELDCAPTION__Document_No_____Document_No___; STRSUBSTNO(Text008, FIELDCAPTION("Document No."), "Document No."))
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF DisplayEntries THEN BEGIN
                            DebitTotal := DebitTotal + "Debit Amount";
                            CreditTotal := CreditTotal + "Credit Amount";
                        END;
                    end;

                    trigger OnPostDataItem();
                    begin
                        IF Date."Period Type" = Date."Period Type"::Date THEN
                            Finished := TRUE;
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF NOT DisplayEntries THEN
                            CurrReport.BREAK();

                        IF DisplayEntries THEN
                            CASE SortingBy OF
                                SortingBy::"Posting Date":
                                    SETCURRENTKEY("Source Code", "Posting Date", "Document No.");
                                SortingBy::"Document No.":
                                    SETCURRENTKEY("Source Code", "Document No.", "Posting Date");
                            END;

                        IF StartDate > Date."Period Start" THEN
                            Date."Period Start" := StartDate;
                        IF EndDate < Date."Period End" THEN
                            Date."Period End" := EndDate;
                        IF Date."Period Type" <> Date."Period Type"::Date THEN
                            SETRANGE("Posting Date", Date."Period Start", Date."Period End")
                        ELSE
                            SETRANGE("Posting Date", StartDate, EndDate);
                        /*   CASE IncludeEntries OF
                             IncludeEntries::Definitive:
                               SETRANGE("Entry Type","Entry Type"::Definitive);
                             IncludeEntries::Simulation:
                               SETRANGE("Entry Type","Entry Type"::Simulation);
                           END*/
                    end;
                }
                dataitem("G/L Account"; 15)
                {
                    DataItemTableView = SORTING("No.");
                    PrintOnlyIfDetail = true;
                    column(SourceCode2_Code_Control1120096; SourceCode2.Code)
                    {
                    }
                    column(SourceCode2_Description_Control1120098; SourceCode2.Description)
                    {
                    }
                    column(GLEntry2__Debit_Amount_; GLEntry2."Debit Amount")
                    {
                        AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                        AutoFormatType = 1;
                    }
                    column(GLEntry2__Credit_Amount_; GLEntry2."Credit Amount")
                    {
                        AutoFormatExpression = GeneralLedgerSetup."LCY Code";
                        AutoFormatType = 1;
                    }
                    column(G_L_Account___No__; "No.")
                    {
                    }
                    dataitem(GLEntry2; 17)
                    {
                        DataItemTableView = SORTING("G/L Account No.", "Posting Date", "Source Code");
                        column(G_L_Account__Name; "G/L Account".Name)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            IF NOT DisplayEntries THEN BEGIN
                                DebitTotal := DebitTotal + "Debit Amount";
                                CreditTotal := CreditTotal + "Credit Amount";
                            END;
                        end;

                        trigger OnPostDataItem();
                        begin
                            IF Date."Period Type" = Date."Period Type"::Date THEN
                                Finished := TRUE;
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETCURRENTKEY("G/L Account No.", "Posting Date", "Source Code");
                            SETRANGE("G/L Account No.", "G/L Account"."No.");
                            IF Date."Period Type" <> Date."Period Type"::Date THEN
                                SETRANGE("Posting Date", Date."Period Start", Date."Period End")
                            ELSE
                                SETRANGE("Posting Date", StartDate, EndDate);
                            SETRANGE("Source Code", SourceCode.Code);
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        IF NOT DisplayCentral THEN
                            CurrReport.BREAK();

                        CurrReport.CREATETOTALS(GLEntry2."Debit Amount", GLEntry2."Credit Amount");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    SourceCode2 := SourceCode;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                YearString := '';
                IF Date."Period Type" <> Date."Period Type"::Year THEN BEGIN
                    Year := DATE2DMY("Period End", 3);
                    YearString := ' ' + FORMAT(Year);
                END;
                IF Finished THEN
                    CurrReport.BREAK();
                PeriodTypeNo := "Period Type";
                DateRecNo += 1;
                if Date."Period Type" = Date."Period Type"::Month then
                    typePeriode := 'Mois'
                else
                    if Date."Period Type" = Date."Period Type"::Week then
                        typePeriode := 'Semaine'
                    else
                        if Date."Period Type" = Date."Period Type"::Year then
                            typePeriode := 'Année'
                        else
                            if Date."Period Type" = Date."Period Type"::Quarter then
                                typePeriode := 'Trimestre';
            end;

            trigger OnPreDataItem();
            var
                Period: Record Date;
            begin
                Hidden := (IncludeEntries IN [IncludeEntries::All, IncludeEntries::Simulation]);

                IF GETFILTER("Period Type") = '' THEN
                    ERROR(Text004, FIELDCAPTION("Period Type"));
                IF GETFILTER("Period Start") = '' THEN
                    ERROR(Text004, FIELDCAPTION("Period Start"));
                IF COPYSTR(GETFILTER("Period Start"), 1, 1) = '.' THEN
                    ERROR(Text005);
                StartDate := GETRANGEMIN("Period Start");
                COPYFILTER("Period Type", Period."Period Type");
                Period.SETRANGE("Period Start", StartDate);
                IF NOT Period.FINDFIRST() THEN
                    ERROR(Text009, StartDate, GETFILTER("Period Type"));
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
                    EndDate := FiltreDateCalc.ReturnEndingPeriod(StartDate, Date.GETRANGEMIN("Period Type"));
                CLEAR(Period);
                COPYFILTER("Period Type", Period."Period Type");
                Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
                IF NOT Period.FINDFIRST() THEN
                    ERROR(Text010, EndDate, GETFILTER("Period Type"));
                CurrReport.NEWPAGEPERRECORD := Period."Period Type" <> Period."Period Type"::Date;
                FiscalYearStatusText := STRSUBSTNO(Text011, FYFiscalClose.CheckFiscalYearStatus(GETFILTER("Period Start")));

                DateRecNo := 0;
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
                    field(Journals; Display)
                    {
                        CaptionML = ENU = 'Display',
                                    FRA = 'Afficher';
                        OptionCaptionML = ENU = 'Journals,Centralized Journals,Journals and Centralization',
                                          FRA = 'Feuilles,Centralisation des feuilles,Feuilles et centralisation';
                        ApplicationArea = All;
                        trigger OnValidate();
                        begin
                            PageRefresh();
                        end;
                    }
                    field("Posting Date"; SortingBy)
                    {
                        CaptionML = ENU = 'Sorted by',
                                    FRA = 'Trié par';
                        OptionCaptionML = ENU = 'Posting Date,Document No.',
                                          FRA = 'Date comptabilisation,N° document';
                        ApplicationArea = All;
                        trigger OnValidate();
                        begin
                            IF SortingBy = SortingBy::"Document No." THEN
                                IF NOT DocumentNoVisible THEN
                                    ERROR(Text666, SortingBy);
                            IF SortingBy = SortingBy::"Posting Date" THEN
                                IF NOT PostingDateVisible THEN
                                    ERROR(Text666, SortingBy);
                        end;
                    }
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

        trigger OnInit();
        begin
            DocumentNoVisible := TRUE;
            PostingDateVisible := TRUE;
        end;

        trigger OnOpenPage();
        begin
            PageRefresh();
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        RecGCompanyInfo.GET();
        RecGCompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";
        GeneralLedgerSetup.Get();

    end;

    trigger OnPreReport();
    begin
        Filter := Date.GETFILTERS;
        Filter2 := SourceCode.GETFILTERS;

        CASE Display OF
            Display::Journals:
                BEGIN
                    DisplayEntries := TRUE;
                    Title := Text001
                END;
            Display::"Centralized Journals":
                BEGIN
                    DisplayCentral := TRUE;
                    Title := Text002
                END;
            Display::"Journals and Centralization":
                BEGIN
                    DisplayEntries := TRUE;
                    DisplayCentral := TRUE;
                    Title := Text003
                END;
        END;
        SortingByNo := SortingBy;
    end;

    var
        Text001: TextConst ENU = 'Journals', FRA = 'Feuilles';
        Text002: TextConst ENU = 'Centralized journals', FRA = 'Centralisation des feuilles';
        Text003: TextConst ENU = 'Journals and Centralization', FRA = 'Feuilles avec centralisation';
        Text004: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text005: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text006: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text007: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text008: TextConst ENU = 'Total %1 %2', FRA = 'Total %1 %2';
        SourceCode2: Record "Source Code";
        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        FYFiscalClose: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        TextDate: Text;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        Filter2: Text;
        Title: Text;
        SortingBy: Option "Posting Date","Document No.";
        Display: Option Journals,"Centralized Journals","Journals and Centralization";
        DisplayEntries: Boolean;
        DisplayCentral: Boolean;
        "Filter": Text;
        Text009: TextConst ENU = 'The selected starting date %1 is not the start of a %2.', FRA = 'La date de début choisie (%1) ne correspond pas au début de %2.';
        Text010: TextConst ENU = 'The selected ending date %1 is not the end of a %2.', FRA = 'La date de fin choisie (%1) ne correspond pas ¨ la fin de %2.';
        Year: Integer;
        YearString: Text;
        Finished: Boolean;
        FiscalYearStatusText: Text;
        Text011: TextConst ENU = 'Fiscal-Year Status: %1', FRA = 'Statut de l''exercice comptable : %1';
        PeriodTypeNo: Integer;
        SortingByNo: Integer;
        DateRecNo: Integer;
        IncludeEntries: Option All,Definitive,Simulation;
        Hidden: Boolean;
        [InDataSet]
        PostingDateVisible: Boolean;
        [InDataSet]
        DocumentNoVisible: Boolean;
        Text666: TextConst ENU = '%1 is not a valid selection.', FRA = '%1 n''est pas une sélection valide.';
        Text012Lbl: TextConst ENU = 'This report includes simulation entries.', FRA = 'Cet état inclut des écritures de simulation.';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° doc. externe';
        G_L_Account_No_CaptionLbl: TextConst ENU = 'G/L Account No.', FRA = 'N° compte général';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        Grand_Total__CaptionLbl: TextConst ENU = 'Grand Total :', FRA = 'Total général :';
        RecGCompanyInfo: Record "Company Information";
        GeneralLedgerSetup: Record "General Ledger Setup";
        TXTADRESSE: Text;
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;
        typePeriode: Text;

    local procedure PageRefresh();
    begin
        PostingDateVisible := (Display = Display::Journals) OR (Display = Display::"Journals and Centralization");
        DocumentNoVisible := (Display = Display::Journals) OR (Display = Display::"Journals and Centralization");
    end;
}

