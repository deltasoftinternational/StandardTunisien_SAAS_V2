report 70005 "STChèque Ou Traite Impayé"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Chèque Ou Traite Impayé';
    ApplicationArea = All;

    RDLCLayout = './src/report/RDLC/ChèqueOuTraiteImpayé.rdl';
    dataset
    {
        dataitem(paymentHeader; 10865)
        {
            DataItemTableView = SORTING("No.") WHERE(STType_Reg = FILTER("Chèque" | Traite), Type_ED = const(Encaissement));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Payment Class", "Posting Date";
            column(PaymentHeaderNo; paymentHeader."No.")
            {
            }
            column(PaymentHeaderPaymentClass; paymentHeader."Payment Class")
            {
            }
            column(TitreCaption; CstG010)
            {
            }
            column(FiltreBordCaption; CstG011)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TypeReglementCaption; CstG012)
            {
            }
            column(GETFILTERS; GETFILTERS())
            {
            }
            column(NbordCaption; CstG013)
            {
            }
            column(TypeCaption; CstG014)
            {
            }
            column(CodeClientCaption; CstG015)
            {
            }
            column(NomClientCaption; CstG016)
            {
            }
            column(MontantCaption; CstG017)
            {
            }
            column(BanqueCaption; CstG018)
            {
            }
            column(AgenceCaption; CstG019)
            {
            }
            column(NDocExterneCaption; CstG020)
            {
            }
            column(EcheanceCaption; CstG021)
            {
            }
            column(TotalCaption; CstG022)
            {
            }
            column(CaissierCaption; CstG023)
            {
            }
            column(ServiceFinancierCaption; CstG024)
            {
            }
            column(PaymentHeaderAmount; paymentHeader.Amount)
            {
            }
            column(NCompteCaption; CstG025)
            {
            }
            column(DateComptaCaption; CstG026)
            {
            }
            column(GETFILTERPostingDate; GETFILTER("Posting Date"))
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

            dataitem(DataItem1000000001; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = paymentHeader;
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending)
                                        WHERE(//"Status No." = FILTER(90000 | 120000 | 130000),
                                                  "Copied To No." = CONST());
                RequestFilterFields = "Account Type", "Account No.";
                column(PaymentLineLineNo; DataItem1000000001."Line No.")
                {
                }
                column(No; "No.")
                {
                }
                column(PaymentClass; "Payment Class")
                {
                }
                column(AccountNo; "Account No.")
                {
                }
                column(NomCLT; NomCLT)
                {
                }
                column(Amount; Amount)
                {
                }
                column(PaymentLineBankAccountName; DataItem1000000001."Bank Account Name")
                {
                }
                column(PaymentLineBankCity; DataItem1000000001."Bank City")
                {
                }
                column(ExternalDocumentNo; "External Document No.")
                {
                }
                column(PaymentLineDueDate; DataItem1000000001."Due Date")
                {
                }
                column(PaymentHeaderAccountNo; paymentHeader."Account No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>MIG2013 27022013
                    TABG_CLT.SETRANGE("No.", DataItem1000000001."Account No.");
                    IF TABG_CLT.FIND('-') THEN
                        NomCLT := TABG_CLT.Name;
                    IF DataItem1000000001.Amount < 0 THEN
                        DataItem1000000001.Amount := DataItem1000000001.Amount * (-1);
                    MontToT := MontToT + DataItem1000000001.Amount;

                    //IMS
                    Facture := '';
                    IF "Applies-to ID" <> '' THEN
                        IF "Account Type" = "Account Type"::Customer THEN BEGIN

                            RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                            IF RecEcritureClient.FIND('-') THEN
                                REPEAT
                                    Facture += RecEcritureClient."Document No." + '- ';
                                //MntFactures+=RecEcritureClient."Amount to Apply";
                                UNTIL RecEcritureClient.NEXT() = 0;
                        END;
                    // MESSAGE('%1', Facture);
                    //IMS
                    ////section
                    Montant_gd += Amount;
                    //<<MIG2013 27022013
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>MIG2013 27022013
                //IF CurrReport.TOTALSCAUSEDBY = FIELDNO("Payment Class") THEN
                Montant_gd := 0;
                //<<MIG2013 27022013

            end;

            trigger OnPreDataItem()
            begin
                //>>MIG2013 27022013
                //  CurrReport.CREATETOTALS(Amount);
                //<<MIG2013 27022013
                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
                TXTADRESSE := CompanyInfo.Address + ' ' + CompanyInfo.City + ' ' + CompanyInfo."Post Code";

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Nom société';
        Text004: Label 'N° état';
        Text005: Label 'Code Utilisateur';
        Text006: Label 'Date';
        Text007: Label 'Filtre Date';
        CstG010: Label 'Liste Des Impayés';
        CstG011: Label 'Filtre Bordereau :';
        CstG012: Label 'Type de réglement';
        CstG013: Label 'N° bordereau';
        CstG014: Label 'Type';
        CstG015: Label 'Code client';
        CstG016: Label 'Nom client';
        CstG017: Label 'Montant';
        CstG018: Label 'BANQUE';
        CstG019: Label 'AGENCE';
        CstG020: Label 'N° Doc Externe';
        CstG021: Label 'Echeance';
        CstG022: Label 'Total :';
        CstG023: Label 'Service Recouvrement';
        CstG024: Label 'Service Financier';
        CstG025: Label 'N° Compte';
        CstG026: Label 'Date de comptabilisation:';
        TABG_CLT: Record Customer;
        NomCLT: Text[100];
        MontToT: Decimal;
        Facture: Text[250];
        RecEcritureClient: Record "Cust. Ledger Entry";
        Montant_gd: Decimal;
        "filter": Text[500];
        filter2: Text[500];
        ExcelBuf: Record "Excel Buffer" temporary;
        PrintToExcel: Boolean;
        TXTADRESSE: Text;
}

