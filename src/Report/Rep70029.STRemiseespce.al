report 70029 "STRemise espèce"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Remiseespèce.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    caption = 'Remise espèce';


    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PaymentHeaderNo; "Payment Header"."No.")
            {
            }
            column(TitreCaption; CstG010)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(RSCaption; CstG011)
            {
            }
            column(NCompteCaption; CstG012)
            {
            }
            column(BanqueBankBranchNo; Banque."Bank Branch No.")
            {
            }
            column(BanqueAgencyCode; Banque."Agency Code")
            {
            }
            column(BanqueBankAccountNo; Banque."Bank Account No.")
            {
            }
            column(BanqueRIBKey; RIBKEY)
            {
            }
            column(NomBanqueCaption; CstG013)
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(DateVersementCaption; CstG014)
            {
            }
            column(PaymentHeaderPostingDate; "Payment Header"."Posting Date")
            {
            }
            column(DateGWorkDate; DateGWorkDate)
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
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");
                column(IntGCounter; IntGCounter)
                {
                }
                column(PaymentLineLineNo; "Payment Line"."Line No.")
                {
                }
                column(SommeEnLetterCaption; CstG015)
                {
                }
                column(TotalEnChiffreCaption; CstG016)
                {
                }
                column(TxtGMontantTTLettre; TxtGMontantTTLettre)
                {
                }
                column(Amount__LCY_; "Amount (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(ABSDecGTotMontant; (ABS(DecGTotMontant)))
                {
                }
                column(SignatureAgence; CstG017)
                {
                }
                column(SignatureRemettant; CstG019)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>MIG2013 18022013
                    IF Compteur = 36 THEN BEGIN
                        IntGCounter += 1;
                        Compteur := 1;
                        //CurrReport.NEWPAGE;
                    END;
                    Compteur := Compteur + 1;
                    i := i + 1;

                    DecGTotMontant := DecGTotMontant + "Payment Line"."Amount (LCY)";

                    TxtGMontantTTLettre := '';
                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then
                        dev := currency."ISO Code";
                    //     DecGTotMontant := DecGTotMontant + ABS("Amount (LCY)");

                    if (dev = '') or (dev = 'TND') then
                        CduGMontantTTlettre."Montant en texte"(TxtGMontantTTLettre, ROUND(ABS(DecGTotMontant), 0.001, '='))
                    else
                        CduGMontantTTlettre."Montant en texteDevise"(TxtGMontantTTLettre, ROUND(ABS(DecGTotMontant), 0.001, '='), dev);
                    //<<MIG2013 18022013
                end;

                trigger OnPostDataItem()
                begin
                    //>>MIG2013 18022013
                    k := i - 1;
                    //<<MIG2013 18022013
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>MIG2013 18022013
                Clear(RIBKEY);
                IF "Payment Header"."Account Type" = "Payment Header"."Account Type"::"Bank Account" THEN
                    Banque.SetRange("No.", "Payment Header"."Account No.");
                if Banque.FindFirst() then
                    IF Banque."RIB Key" < 10 then
                        RIBKEY := '0' + format(Banque."RIB Key")
                    else
                        RIBKEY := format(Banque."RIB Key");

                //<<MIG2013 18022013
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

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        DateGWorkDate := WORKDATE();
        CompanyInfo.CalcFields(Picture);
        TXTADRESSE := CompanyInfo.Address + ' ' + CompanyInfo.City + ' ' + CompanyInfo."Post Code";

    end;

    var
        Banque: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        i: Integer;
        Compteur: Integer;
        DecGTotMontant: Decimal;
        CduGMontantTTlettre: Codeunit "ST MontantTouteLettre";
        TxtGMontantTTLettre: Text;
        k: Integer;
        CstG010: Label 'Bordereau de versement espèce';
        CstG011: Label 'Nom ou R.S';
        CstG012: Label 'N° de compte';
        CstG013: Label 'Nom de la banque';
        CstG014: Label 'Date Versement';
        DateGWorkDate: Date;
        IntGCounter: Integer;
        CstG015: Label 'Somme en Lettres';
        CstG016: Label 'Total en chiffres';
        CstG017: Label 'Signature De l''Agence';
        CstG018: Label 'Signature Responsable';
        CstG019: Label 'Signature Responsable';
        RIBKEY: Text[5];
        currency: Record Currency;
        dev: Text[10];
        TXTADRESSE: Text;
}

