
report 71045 "STGL Trial Balancetotalisation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/GLTrialBalance1.rdl';
    Caption = 'Balance comptes généraux avec totalisation';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter";
            column(masquertotaux; masquertotaux) { }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(PreviousStartDateText; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ''))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(GLAccTableCaptionFilter; "G/L Account".TABLECAPTION)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(SimulationEntriesCaption; SimulationEntriesCaptionLbl)
            {
            }

            column(No_GLAcc; "No.")
            {
            }
            column(Name_GLAcc; Name)
            {
            }
            column(GLAcc2DebitAmtCreditAmt; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(GLAcc2CreditAmtDebitAmt; GLAccount2."Credit Amount" - GLAccount2."Debit Amount")
            {
            }
            column(DebitAmt_GLAcc; "NET Debit Amount")
            {
            }
            column(CreditAmt_GLAcc; "NET Credit Amount")
            {
            }
            column(BalAtEndingDateDebitCaption; GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount")//DELTA RF 
            {
            }
            column(BalAtEndingDateCreditCaption; GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount")//DELTA RF
            {
            }
            column(TLAccType; TLAccountType)
            {
            }
            column(GLTrialBalCaption; GLTrialBalCaptionLbl)
            {
            }
            column(TotBilanDebit; TotBilanDebit)
            {

            }
            column(TotBilanCredit; TotBilanCredit)
            {

            }
            column(TotCompteBilanDebit; TotCompteBilanDebit)
            {

            }
            column(TotCompteBilanCredit; TotCompteBilanCredit)
            {

            }
            column(TotMovBilanDebit; TotMovBilanDebit)
            {

            }
            column(TotMovBilanCredit; TotMovBilanCredit)
            {

            }
            column(TotalSoldeBilanDebit; TotalSoldeBilanDebit)
            {

            }
            column(TotalSoldeBilanCredit; TotalSoldeBilanCredit)
            {

            }
            column(TotGestionDebit; TotGestionDebit)
            {

            }
            column(TotGestionCredit; TotGestionCredit)
            {

            }
            column(TotMovGestionDebit; TotMovGestionDebit)
            {

            }
            column(TotMovGestionCredit; TotMovGestionCredit)
            {

            }
            column(TotalSoldeGestionDebit; TotalSoldeGestionDebit)
            {

            }
            column(TotalSoldeGestionCredit; TotalSoldeGestionCredit)
            {

            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(BalAtStartingDateCaption; BalAtStartingDateCaptionLbl)
            {
            }
            column(BalDateRangeCaption; BalDateRangeCaptionLbl)
            {
            }
            column(BalAtEndingdateCaption; BalAtEndingdateCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(TypeAccount; TestValAmount)
            {
            }
            column(TotalMouvDebit; TotalMouvDebit)
            {
            }
            column(TotalMouvCredit; TotalMouvCredit)
            {
            }
            column(TotalDebit; SoldeDebit)
            {
            }
            column(TotalCredit; SoldeCredit)
            {
            }
            column(TotBalanceDebit; TotBalanceDebit)
            {
            }
            column(TotBalanceCredit; TotBalanceCredit)
            {
            }
            column(CompanyAdr; CompanyInfo.Address)
            {
            }
            column(CompanyCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Fax; CompanyInfo."Fax No.")
            {
            }
            column(Phone; CompanyInfo."Phone No.")
            {
            }
            column(MatriculeFiscal; CompanyInfo."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(AfficherDate; AfficherDate)
            {

            }
            column(AfficherUtilisateur; AfficherUtilisateur)
            {

            }
            column(AfficherfiltreDate; AfficherfiltreDate)
            {

            }
            trigger OnAfterGetRecord()
            begin

                GLAccount2.COPY("G/L Account");
                IF GLAccount2."Income/Balance" = 0 THEN BEGIN
                    GLAccount2.SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate);
                    GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                END ELSE BEGIN
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                    GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                END;
                IF NOT ImprNonMvt AND (
((GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") = 0) AND ((GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") = 0)) and (GLAccount2."Debit Amount" = 0) AND ("net Debit Amount" = 0) and (GLAccount2."Credit Amount" = 0) and ("net Credit Amount" = 0)
THEN
                    CurrReport.SKIP();

                //   (GLAccount2."Debit Amount" = 0) AND
                // ("Debit Amount" = 0) AND
                //(GLAccount2."Credit Amount" = 0) AND
                //("Credit Amount" = 0)



                TLAccountType := "G/L Account"."Account Type";

                IF TLAccountType = 0 THEN BEGIN
                    IF (GLAccount2."Debit Amount" - GLAccount2."Credit Amount") > 0 THEN
                        TotalMouvDebit := (GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
                    ELSE
                        TotalMouvDebit := 0;
                    IF (GLAccount2."Credit Amount" - GLAccount2."Debit Amount") > 0 THEN
                        TotalMouvCredit := GLAccount2."Credit Amount" - GLAccount2."Debit Amount"
                    ELSE
                        TotalMouvCredit := 0;
                    IF "net Debit Amount" > 0 THEN //DELTA RF 
                        SoldeDebit := "net Debit Amount" //DELTA RF 
                    ELSE
                        SoldeDebit := 0;
                    IF "net Credit Amount" > 0 THEN //DELTA RF 
                        SoldeCredit := "net Credit Amount" // DELTA RF 
                    ELSE
                        SoldeCredit := 0;
                    IF (GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") > 0 THEN
                        TotBalanceDebit := GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount" // delta rf 
                    ELSE
                        TotBalanceDebit := 0;
                    IF (GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount") > 0 THEN
                        TotBalanceCredit := GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount" // delta rf 
                    ELSE
                        TotBalanceCredit := 0;
                END ELSE BEGIN
                    TotalMouvDebit := 0;
                    TotalMouvCredit := 0;
                    SoldeDebit := 0;
                    SoldeCredit := 0;
                    TotBalanceDebit := 0;
                    TotBalanceCredit := 0;
                END;
                //>>Calcul Compte Bilan + Compte Gestion

                // Calcul Compte Bilan
                IF (GLAccount2."Account Type" = 0) AND (GLAccount2."Income/Balance" = 1)
                THEN BEGIN
                    IF (GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") > 0 THEN
                        TotBilanDebit := GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount"
                    ELSE
                        TotBilanDebit := 0;
                    IF (GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount") > 0 THEN
                        TotBilanCredit := GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount"
                    ELSE
                        TotBilanCredit := 0;
                    IF "net Debit Amount" <> 0 THEN
                        TotMovBilanDebit := "net Debit Amount"
                    ELSE
                        TotMovBilanDebit := 0;
                    IF "net Credit Amount" <> 0 THEN
                        TotMovBilanCredit := "net Credit Amount"
                    ELSE
                        TotMovBilanCredit := 0;
                    IF (GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") > 0 THEN
                        TotalSoldeBilanDebit := (GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
                    ELSE
                        TotalSoldeBilanDebit := 0;
                    IF (GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount") > 0 THEN
                        TotalSoldeBilanCredit := GLAccount2."Credit Amount" - GLAccount2."Debit Amount"
                    ELSE
                        TotalSoldeBilanCredit := 0;
                END ELSE BEGIN
                    TotBilanDebit := 0;
                    TotBilanCredit := 0;
                    TotMovBilanDebit := 0;
                    TotMovBilanCredit := 0;
                    TotalSoldeBilanDebit := 0;
                    TotalSoldeBilanCredit := 0;
                END;

                //Calcul Compte Gestion

                IF ("GLAccount2"."Account Type" = 0) AND ("GLAccount2"."Income/Balance" = 0)
                THEN BEGIN
                    IF (GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") > 0 THEN
                        TotGestionDebit := GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount"
                    ELSE
                        TotGestionDebit := 0;
                    IF (GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount") > 0 THEN
                        TotGestionCredit := GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount"
                    ELSE
                        TotGestionCredit := 0;
                    IF "net Debit Amount" <> 0 THEN
                        TotMovGestionDebit := "net Debit Amount"
                    ELSE
                        TotMovGestionDebit := 0;
                    IF "net Credit Amount" > 0 THEN
                        TotMovGestionCredit := "net Credit Amount"
                    ELSE
                        TotMovGestionCredit := 0;
                    IF (GLAccount2."Debit Amount" + "net Debit Amount" - GLAccount2."Credit Amount" - "net Credit Amount") > 0 THEN
                        TotalSoldeGestionDebit := (GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
                    ELSE
                        TotalSoldeGestionDebit := 0;
                    IF (GLAccount2."Credit Amount" + "net Credit Amount" - GLAccount2."Debit Amount" - "net Debit Amount") > 0 THEN
                        TotalSoldeGestionCredit := GLAccount2."Credit Amount" - GLAccount2."Debit Amount"
                    ELSE
                        totalSoldeGestionCredit := 0;
                END ELSE BEGIN
                    TotGestionDebit := 0;
                    TotGestionCredit := 0;
                    TotMovGestionDebit := 0;
                    TotMovGestionCredit := 0;
                    TotalSoldeGestionDebit := 0;
                    TotalSoldeGestionCredit := 0;
                END;


            end;

            trigger OnPreDataItem()
            begin
                OnbeforePreGLaccount("G/L Account");
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
                //    FiscalYearStatusText := STRSUBSTNO(Text007, FYFiscalClose.CheckFiscalYearStatus(GETFILTER("Date Filter")));

                //TotalMouvDebit := 0;
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
                    field(PrintGLAccsWithoutBalance; ImprNonMvt)
                    {
                        Caption = 'Print G/L Accs. without balance';
                        ApplicationArea = basic;
                    }
                    field(masquertotaux; masquertotaux)
                    {
                        ApplicationArea = all;
                        Caption = 'Masquer totaux';
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
        label(TBalacnceSheet; ENU = 'Total Balance Sheet',
                             FRA = 'Total Compte de Bilan')
        label(TIncomeState; ENU = 'Total Income Statement',
                           FRA = 'Total Compte de Gestion')
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := CompanyInfo.Address + ' ' + CompanyInfo.City + ' ' + CompanyInfo."Post Code";
    end;

    trigger OnPreReport()
    begin
        Filter := "G/L Account".GETFILTERS;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnbeforePreGLaccount(var "G/L Account": record "G/L Account")
    begin
    end;

    var
        masquertotaux: Boolean;
        Text001: Label 'You must fill in the %1 field.';
        Text002: Label 'You must specify a Starting Date.';
        Text003: Label 'Printed by %1';
        Text004: Label 'Fiscal Year Start Date : %1';
        Text005: Label 'Page %1';
        GLAccount2: Record "G/L Account";
        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        ImprNonMvt: Boolean;
        "Filter": Text[250];
        FiscalYearStatusText: Text[80];
        FYFiscalClose: Codeunit "Fiscal Year-Close";
        Text007: Label 'Fiscal-Year Status: %1';
        TLAccountType: Integer;
        SimulationEntriesCaptionLbl: Label 'This report includes simulation entries.';
        GLTrialBalCaptionLbl: Label 'G/L Trial Balance';
        NoCaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        BalAtStartingDateCaptionLbl: Label 'Balance at Starting Date';
        BalDateRangeCaptionLbl: Label 'Balance Date Range';
        BalAtEndingdateCaptionLbl: Label 'Balance at Ending date';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        TotalMouvDebit: Decimal;
        TotalMouvCredit: Decimal;
        TotCompteBilanDebit: Decimal;
        TotCompteBilanCredit: Decimal;
        TotBilanDebit: Decimal;
        TotBilanCredit: Decimal;
        GLAccount4: Record "G/L Account";
        TotMovBilanDebit: Decimal;
        TotMovBilanCredit: Decimal;
        GLAccount5: Record "G/L Account";
        TotalSoldeBilanDebit: Decimal;
        TotalSoldeBilanCredit: Decimal;
        TotGestionDebit: Decimal;
        TotGestionCredit: Decimal;
        TotMovGestionDebit: Decimal;
        TotMovGestionCredit: Decimal;
        TotalSoldeGestionDebit: Decimal;
        TotalSoldeGestionCredit: Decimal;
        TOTAL: Decimal;
        SoldeDebit: Decimal;
        SoldeCredit: Decimal;
        TestValAmount: Boolean;
        GLAccount3: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        TotBalanceDebit: Decimal;
        TotBalanceCredit: Decimal;
        TXTADRESSE: Text;
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;
}

