report 71033 "STInternational Transfer Order"
{
    // version Chayma DELTASOFT


    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/International Transfer Order.rdl';
    CaptionML = ENU = 'International Transfer Order',
                FRA = 'Ordre Virement International';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Header"; 10865)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            column(Picture; Rec_Company.Picture)
            {
            }
            column(CompanyName; Rec_Company.Name)
            {
            }
            column(CompanyAddress; Rec_Company.Address)
            {
            }
            column(CompanyVille; Rec_Company.City)
            {
            }
            column(CompanyCodePostale; Rec_Company."Post Code")
            {
            }
            column(No_PaymentHeader; "Payment Header"."No.")
            {
            }
            column(BankAccountNo_PaymentHeader; "Payment Header"."Bank Account No.")
            {
            }
            column(CurrencyCode_PaymentHeader; "Payment Header"."Currency Code")
            {
            }
            column(AmountLCY_PaymentHeader; "Payment Header"."Amount (LCY)")
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(Amount_PaymentHeader; "Payment Header".Amount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(MontantLettre; MontantLettre)
            {
            }
            column(AccountNo_PaymentHeader; "Payment Header"."Account No.")
            {
            }
            column(IBAN_PaymentHeader; "Payment Header".IBAN)
            {
            }
            column(BankName_PaymentHeader; "Payment Header"."Bank Name")
            {
            }
            column(DateRefDossier; DateRefDossier)
            {
            }
            column(DateInfoTCE; DateInfoTCE)
            {
            }
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                column(Commentaires_PaymentLine; "Payment Line".STCommentaires)
                {
                }
                column("Libellé_PaymentLine"; "Payment Line"."STLibellé")
                {
                }
                column(IBAN_PaymentLine; "Payment Line".IBAN)
                {
                }
                column(AdresseFournisseur; RecVendor.Address)
                {
                }
                column(VilleFournisseur; RecVendor.City)
                {
                }
                column(CodePostaleFournisseur; RecVendor."Post Code")
                {
                }
                column(BankAccountName_PaymentLine; "Payment Line"."Bank Account Name")
                {
                }
                column(SWIFTCode_PaymentLine; "Payment Line"."SWIFT Code")
                {
                }
                column(ExternalDocumentNo_PaymentLine; "Payment Line"."External Document No.")
                {
                }
                column(Observations_PaymentLine; "Payment Line".STObservations)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    RecVendor.RESET();
                    RecVendor.GET("Payment Line"."Account No.");
                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then
                        devise := currency."ISO Code";
                    MontantTouteLettre."Montant en texteDevise"(MontantLettre, "Payment Header".Amount, devise);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date Référence Dossier"; DateRefDossier)
                {
                    ApplicationArea = All;
                }
                field("Date Information TCE"; DateInfoTCE)
                {
                    ApplicationArea = All;
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

    trigger OnPreReport();
    begin
        Increment := 1;
        IF Rec_Company.GET() THEN;
        Rec_Company.CALCFIELDS(Picture);
        TxtCompanyname := Rec_Company.Name;
        TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
        CumulMntLCY := 0;
    end;

    var
        TxtCompanyname: Code[50];
        Increment: Integer;
        Rec_Company: Record "Company Information";
        TXTADRESSE: Text;
        CumulMntLCY: Decimal;
        MontantTouteLettre: Codeunit "ST MontantTouteLettre";
        MontantLettre: Text[250];
        RecVendor: Record Vendor;
        DateRefDossier: Date;
        DateInfoTCE: Date;
        currency: Record Currency;
        devise: Text[10];
}

