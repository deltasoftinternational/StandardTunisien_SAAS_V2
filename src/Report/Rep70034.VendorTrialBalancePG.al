report 71034 "Vendor Trial Balance PG"
{
    // Meg01.00 RZ (30-07-18): Numbers Format modification.(ALPTY-000022)
    //YB 300424
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/VendorTrialBalancePG.rdl';
    UsageCategory = ReportsAndAnalysis;

    Caption = 'Vendor Trial Balance PG V2';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    Permissions = TableData "Detailed Vendor Ledg. Entry" = rm;

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            RequestFilterFields = "STDate Filter";
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
            column(STRSUBSTNO_Text005_CurrReport_PAGENO_; STRSUBSTNO(Text005, CurrReport.PAGENO))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(PrintedByCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(Vendor_TABLECAPTION__________Filter; vendor.TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Vendor__No__; "Detailed Vendor Ledg. Entry"."Vendor No.")
            {
            }
            column(Vendor_Name; vendor.Name)
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
            column(Vendor_Trial_BalanceCaption; Vendor_Trial_BalanceCaptionLbl)
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
            column(groupComta; "Detailed Vendor Ledg. Entry"."STVendor Posting Group")
            {
            }
            column(Picture; Rec_Company.Picture)
            {
            }
            column(Logo; Rec_Company.Picture)
            {
            }
            column(CompanyAddress; Rec_Company.Address)
            {
            }
            column(MatriculeFiscal; Rec_Company."VAT Registration No.")
            {
            }
            column(Fax; Rec_Company."Fax No.")
            {
            }
            column(Phone; Rec_Company."Phone No.")
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
                IF vendor.GET("Detailed Vendor Ledg. Entry"."Vendor No.") THEN;


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
            begin
                IF NOT PrintVendWithoutBalance AND (PeriodDebitAmountLCY = 0) AND (PeriodCreditAmountLCY = 0) THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
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

                IF VendorPostingGroup1 <> '' THEN
                    SETFILTER("STVendor Posting Group", '%1', VendorPostingGroup1);
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
                    /*YB field(PrintVendorsWithoutBalance; PrintVendWithoutBalance)
                     {
                         Caption = 'Print Vendors without Balance';
                         MultiLine = true;
                     }*/
                    field(CustomerPostingGroup1; VendorPostingGroup1)
                    {
                        ApplicationArea = All;
                        TableRelation = "Vendor Posting Group".Code;
                        Caption = 'Groupe de comptabilisation';
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
        Rec_Company.GET;
        Rec_Company.CALCFIELDS(Picture);
        TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
    end;

    trigger OnPreReport()
    begin
        Filter := "Detailed Vendor Ledg. Entry".GETFILTERS;
    end;

    var

    var
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        FiltreDateCalc: Codeunit "ST DateFilter-Calc Delta";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        PrintVendWithoutBalance: Boolean;
        "Filter": Text[250];
        VendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        PreviousDebitAmountLCY: Decimal;
        PreviousCreditAmountLCY: Decimal;
        PeriodDebitAmountLCY: Decimal;
        PeriodCreditAmountLCY: Decimal;
        Vendor_Trial_BalanceCaptionLbl: TextConst ENU = 'Vendor Trial Balance', FRA = 'Balance Fournisseurs/ Groupe de Comptabilisation';
        No_CaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        NameCaptionLbl: TextConst ENU = 'Name', FRA = 'Nom';
        Balance_at_Starting_DateCaptionLbl: TextConst ENU = 'Balance at Starting Date', FRA = 'Solde la date de début';
        Balance_Date_RangeCaptionLbl: TextConst ENU = 'Balance Date Range', FRA = 'Solde plage de dates';
        Balance_at_Ending_dateCaptionLbl: TextConst ENU = 'Balance at Ending Date', FRA = 'Solde la date de fin';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaption_Control1120030Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaption_Control1120032Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        DebitCaption_Control1120034Lbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaption_Control1120036Lbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total général';
        vendorpostinggroupe: Code[20];
        vendor: Record Vendor;
        Rec_Company: Record "Company Information";
        groupComta_CaptionLbl: TextConst ENU = 'Vendor Posting Group', FRA = 'Group Compta.Fournisseur';
        GeneralLedgerSetup: Record "General Ledger Setup";
        TXTADRESSE: Text;
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;
        VendorPostingGroup: Record "Vendor Posting Group";
        Account: Code[20];
        PreviousAmountLCY: Decimal;
        Counter1: Integer;
        PreviousDebitCreditLCY: Decimal;
        PreviousCreditDebitLCY: Decimal;
        DETAILEDVENDORLEDGERENTRY: Query DETAILEDVENDORLEDGERENTRY;
        OnLineNumber: Integer;
        vendor1: code[20];
        VendorPostingGroup1: code[20];
        TempoDetailed_VendorLedgEntry: Record "Detailed Vendor Ledg. Entry" temporary;
        Grand_totalCaptionLbl: Label 'Grand total';

}

