report 71036 "STRelevee de compte"
{


    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Customer - Balance to Date.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Relevé de compte';


    dataset
    {
        dataitem(Customer_; 18)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Search Name", Blocked;
            column(TextVisibility; TextVisibility)
            {
            }
            column(Compny_Info_Name; CompanyInfo.Name)
            {
            }
            column(Compny_Info_NameCaption; CompanyInfo.FIELDCAPTION(Name))
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(RecGCompanyInfoCity; CompanyInfo.City)
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
            column(AfficherfiltreDate; AfficherfiltreDate)
            {

            }
            column(AfficherDate; AfficherDate)
            {

            }
            column(AfficherUtilisateur; AfficherUtilisateur)
            {

            }
            column(filtre; Customer_.TableCaption + ': ' + filtre)
            {

            }
            column(MaxDate; MaxDate)
            {

            }
            column(Compny_Info_LegalForm; CompanyInfo."Legal Form")
            {
            }
            column(Compny_Info_LegalFormCaption; CompanyInfo.FIELDCAPTION("Legal Form"))
            {
            }
            column(Compny_Info_StockCapital; CompanyInfo."Stock Capital")
            {
            }
            column(Compny_Info_StockCapitalCaption; CompanyInfo.FIELDCAPTION("Stock Capital"))
            {
            }
            column(Compny_Info_Address; CompanyInfo.Address)
            {
            }
            column(Compny_Info_AddressCaption; CompanyInfo.FIELDCAPTION(Address))
            {
            }
            column(Compny_Info_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(Compny_Info_PhoneNoCaption; CompanyInfo.FIELDCAPTION("Phone No."))
            {
            }
            column(Compny_Info_FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(Compny_Info_FaxNoCaption; CompanyInfo.FIELDCAPTION("Fax No."))
            {
            }
            column(Compny_Info_Email; CompanyInfo."E-Mail")
            {
            }
            column(Compny_Info_EmailCaption; CompanyInfo.FIELDCAPTION("E-Mail"))
            {
            }
            column(Compny_Info_VATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(Compny_Info_VATRegNoCaption; CompanyInfo.FIELDCAPTION("VAT Registration No."))
            {
            }
            column(Compny_Info_HomePage; CompanyInfo."Home Page")
            {
            }
            column(Compny_Info_PostCode; CompanyInfo."Post Code")
            {
            }
            column(Compny_Info_City; CompanyInfo.City)
            {
            }
            column(Compny_Info_CountryRegionCode; CompanyInfo."Country/Region Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Picture1; CompanyInfo."STInvoice Header Picture")
            {
            }
            column(Picture2; CompanyInfo."STInvoice Footer Picture")
            {
            }
            column(FormJuridique; CompanyInfo."Legal Form")
            {
            }
            column(CapitalSocial; CompanyInfo."Stock Capital")
            {
            }
            column("AdrSociété"; CompanyInfo.Address)
            {
            }
            column("TelSociété"; CompanyInfo."Phone No.")
            {
            }
            column("FaxSociété"; CompanyInfo."Fax No.")
            {
            }
            column("EmailSociété"; CompanyInfo."E-Mail")
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(TxtCustGeTranmaxDtFilter; STRSUBSTNO(Text000, FORMAT(GETRANGEMAX("Date Filter"))))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(CustTableCaptCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(PhoneNo_Customer; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(Cust_MF; "VAT Registration No.")
            {
            }
            column(Cust_Adress; Address)
            {
            }
            column(Cust_Adress2; "Address 2")
            {
            }
            column(Cust_County; County)
            {
            }
            column(CustBalancetoDateCaption; CustBalancetoDateCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllamtsareinLCYCaption; AllamtsareinLCYCaptionLbl)
            {
            }
            column(CustLedgEntryPostingDtCaption; CustLedgEntryPostingDtCaptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLinkReference = Customer_;
                DataItemLink = "Customer No." = field("No.");
                DataItemTableView = SORTING("Entry No.")
                                        WHERE(Open = const(true));
                column(Entry_No_; "Entry No.")
                {

                }
                column(Document_No_; "Document No.")
                {

                }

                column(Document_Type; "Document Type")
                {

                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(Description; Description)
                {

                }
                column(Due_Date; "Due Date")
                {

                }
                column(Remaining_Amt___LCY_; "Remaining Amt. (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Debit_Amount__LCY_; "Debit Amount (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Credit_Amount__LCY_; "Credit Amount (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
            }

            trigger OnAfterGetRecord();
            begin
                IF MaxDate = 0D THEN
                    ERROR(BlankMaxDateErr);

                SETRANGE("Date Filter", 0D, MaxDate);
                CALCFIELDS("Net Change (LCY)", "Net Change");

                IF ((PrintAmountInLCY AND ("Net Change (LCY)" = 0)) OR
                    ((NOT PrintAmountInLCY) AND ("Net Change" = 0)))
                THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnePrPage;
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
                    field("Ending Date"; MaxDate)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Ending Date',
                                    FRA = 'Date fin';
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        CaptionML = ENU = 'Show Amounts in LCY',
                                    FRA = 'Afficher montants DS';
                        ApplicationArea = All;
                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        CaptionML = ENU = 'New Page per Customer',
                                    FRA = 'Nouvelle page par client';
                        ApplicationArea = All;
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        CaptionML = ENU = 'Include Unapplied Entries',
                                    FRA = 'Inclure écritures non lettrées';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field(TextVisibility; TextVisibility)
                    {
                        Caption = 'Afficher lettre de relance';
                        ApplicationArea = All;

                    }
                    field("Afficher fitres"; AfficherfiltreDate)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show date filter',
                                    FRA = 'Afficher les fitres';
                    }
                    field("Afficher date"; AfficherDate)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show date',
                                    FRA = 'Afficher date';
                    }
                    field("Afficher fitre date"; AfficherUtilisateur)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Show User',
                                    FRA = 'Afficher utilisateur';
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
        //<<Delta.CBOL 040220
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture, CompanyInfo."STInvoice Footer Picture");
        TXTADRESSE := CompanyInfo.Address + ' ' + CompanyInfo.City + ' ' + CompanyInfo."Post Code";

        //>>Delta.CBOL 040220
    end;

    trigger OnPreReport();
    var
        CaptionManagement: Codeunit "Caption Class";
    begin
        filtre := Customer_.GetFilters();
    end;

    var
        Text000: TextConst ENU = 'Balance on %1', FRA = 'Solde au %1';
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        PrintAmountInLCY: Boolean;
        PrintOnePrPage: Boolean;
        CustFilter: Text;
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldCustLedgEntryNum: Integer;
        OK: Boolean;
        CurrencyCode: Code[10];
        PrintUnappliedEntries: Boolean;
        CustBalancetoDateCaptionLbl: TextConst ENU = 'Account statement', FRA = 'Relevé de compte';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        AllamtsareinLCYCaptionLbl: TextConst ENU = 'All amounts are in LCY.', FRA = 'Tous les montants sont en DS.';
        CustLedgEntryPostingDtCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        OriginalAmtCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total';
        BlankMaxDateErr: TextConst ENU = 'Ending Date must have a value.', FRA = 'Date fin doit avoir une valeur.';
        CompanyInfo: Record "Company Information";
        CountryRegion: Record "Country/Region";
        TextVisibility: Boolean;
        txtDescription: Text[500];
        Customer: Record Customer;
        "Detailed Cust. Ledg. Entry": Record "Detailed Cust. Ledg. Entry";
        filtre: Text;
        TXTADRESSE: Text;
        AfficherfiltreDate: Boolean;
        AfficherDate: Boolean;
        AfficherUtilisateur: Boolean;

    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean; NewEndingDate: Date);
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        MaxDate := NewEndingDate;

        PrintUnappliedEntries := TRUE;
    end;

    local procedure FilterCustLedgerEntry(var CustLedgerEntry: Record "Cust. Ledger Entry");
    begin
        CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
        CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
        CustLedgerEntry.SETRANGE("Posting Date", 0D, MaxDate);
    end;

    local procedure AddCustomerDimensionFilter(var CustLedgerEntry: Record "Cust. Ledger Entry");
    begin
        IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 1 Code", Customer.GETFILTER("Global Dimension 1 Filter"));
        IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Global Dimension 2 Code", Customer.GETFILTER("Global Dimension 2 Filter"));
        IF Customer.GETFILTER("Currency Filter") <> '' THEN
            CustLedgerEntry.SETFILTER("Currency Code", Customer.GETFILTER("Currency Filter"));
    end;

    local procedure CalcCustomerTotalAmount(var TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary);
    begin
        TempCustLedgerEntry.SETCURRENTKEY("Entry No.");
        TempCustLedgerEntry.SETRANGE("Date Filter", 0D, MaxDate);
        AddCustomerDimensionFilter(TempCustLedgerEntry);
        IF TempCustLedgerEntry.FINDSET() THEN
            REPEAT
                IF PrintAmountInLCY THEN BEGIN
                    TempCustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                    RemainingAmt := TempCustLedgerEntry."Remaining Amt. (LCY)";
                    CurrencyCode := '';
                END ELSE BEGIN
                    TempCustLedgerEntry.CALCFIELDS("Remaining Amount");
                    RemainingAmt := TempCustLedgerEntry."Remaining Amount";
                    CurrencyCode := TempCustLedgerEntry."Currency Code";
                END;
                IF RemainingAmt <> 0 THEN
                    CurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode,
                      RemainingAmt,
                      0,
                      Counter1);
            UNTIL TempCustLedgerEntry.NEXT() = 0;
    end;

    local procedure CheckCustEntryIncluded(EntryNo: Integer): Boolean;
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        IF CustLedgerEntry.GET(EntryNo) AND (CustLedgerEntry."Posting Date" <= MaxDate) THEN BEGIN
            CustLedgerEntry.SETRANGE("Date Filter", 0D, MaxDate);
            CustLedgerEntry.CALCFIELDS("Remaining Amount");
            IF CustLedgerEntry."Remaining Amount" <> 0 THEN
                EXIT(TRUE);
            IF PrintUnappliedEntries THEN
                EXIT(CheckUnappliedEntryExists(EntryNo));
        END;
        EXIT(FALSE);
    end;

    local procedure CheckUnappliedEntryExists(EntryNo: Integer): Boolean;
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", EntryNo);
        DetailedCustLedgEntry.SETRANGE("Entry Type", DetailedCustLedgEntry."Entry Type"::Application);
        DetailedCustLedgEntry.SETFILTER("Posting Date", '>%1', MaxDate);
        DetailedCustLedgEntry.SETRANGE(Unapplied, TRUE);
        EXIT(NOT DetailedCustLedgEntry.ISEMPTY);
    end;

}

