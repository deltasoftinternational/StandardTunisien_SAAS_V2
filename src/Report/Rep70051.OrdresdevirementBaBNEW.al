report 70051 "Ordres de virement BaB - NEW"
{
    DefaultLayout = RDLC;
    Caption = 'Ordres de virement Banque à Banque';
    RDLCLayout = './src/report/RDLC/Ordres de virement BaB - NEW.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            RequestFilterFields = "No.";

            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");

                column("Numéro"; "Payment Line"."No.")
                {
                }
                column(Increment; Increment)
                {
                }
                column(ExternelDoc; "Payment Line"."External Document No.")
                {
                }
                column(DraweeRef; "Payment Line"."Drawee Reference")
                {
                }
                column(BankAccountName; "Payment Line"."Bank Account Name")
                {
                }
                column(BankCity; "Payment Line"."Bank City")
                {
                }
                column(AmountLCY; ABS("Payment Line"."Amount (LCY)"))
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(P2; Partition2)
                {
                }
                column(DueDate_PaymentLine; "Payment Line"."Due Date")
                {
                }
                column(TxtAdresse; TXTADRESSE)
                {
                }
                column(MatriculeFiscal; Rec_Company."VAT Registration No.")
                {
                }
                column(NameBanque; FORMAT("Payment Line"."Account No.") + ' : ' + FORMAT("Payment Line".STLibellé))
                {
                }
                column(NomUtilisateur; RecUser."Full Name")
                {
                }
                column(CityBanque; RecGBanque.City)
                {
                }
                column(NomDeLaBanque; RecBankAccount.Name)
                {
                }
                column(TxtReportTitle; TxtReportTitle)
                {
                }
                column(TxtCompanyName; TxtCompanyname)
                {
                }
                column(Picture; Rec_Company.Picture)
                {
                }
                column(Montant; "Payment Line".Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(BankAccountNo_PaymentLine; "Payment Line"."Bank Account No.")
                {
                }
                column(BankBranchNo; RecGPaymentHeader."Bank Branch No.")
                {
                }
                column(AgencyCode; RecGPaymentHeader."Agency Code")
                {
                }
                column(BankAccountNo; RecGPaymentHeader."Bank Account No.")
                {
                }
                column(BankAccountCode_PaymentLine; "Payment Line"."Bank Account Code")
                {
                }
                column(RibKey; RecGPaymentHeader."Bank Branch No." + RecGPaymentHeader."Agency Code" + RecGPaymentHeader."Bank Account No." + FORMAT(RecGPaymentHeader."RIB Key"))
                {
                }
                column(BankName; RecGPaymentHeader."Bank Name")
                {
                }
                column(PostingDate; RecGPaymentHeader."Posting Date")
                {
                }
                column("TypeRèglement_PaymentHeader"; RecGPaymentHeader."STType Règlement")
                {
                }
                column(Logo; Rec_Company.Picture)
                {
                }
                column(CompanyName; Rec_Company.Name)
                {
                }
                column(CompanyAddress; Rec_Company.Address)
                {
                }
                column(Typepaiement_PaymentHeader; RecGPaymentHeader."STType paiement")
                {
                }
                column(NomeBank; RecBankAccount.Name)
                {
                }
                column(MntLettre; TexteLettre)
                {
                }
                column(Type_Reglement; RecGPaymentHeader."STType Règlement")
                {
                }
                column(Coffre_PaymentLine; "Payment Line".STCoffre)
                {
                }
                column(DesignationCoffre; RecCoffre.STDésignation)
                {
                }
                column(Commentaires_PaymentLine; "Payment Line".STCommentaires)
                {
                }
                column(AccountNo_PaymentLine; "Payment Line"."Account No.")
                {
                }
                column("Libellé_PaymentLine"; "Payment Line".STLibellé)
                {
                }
                column(DocLettrer; DocLettrer)
                {
                }
                column(CompteBK; CompteBK)
                {
                }
                column(Bank; Bank)
                {
                }
                column("RibEntête_PaymentLine"; "Payment Line".STRib_Entête)
                {
                }
                column(RIBBK; RIBBK)
                {
                }
                column(NomBk; NomBk)
                {
                }
                column(AddressBk; AddressBk)
                {
                }
                column(CumulMntLCY; CumulMntLCY)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;

                }
                column(dev; dev)
                {

                }
                trigger OnAfterGetRecord();
                begin
                    CumulMntLCY += ABS("Amount (LCY)");
                    Increment += 1;
                    RIBBK := '';
                    IF RecGBanque.GET("Account No.") THEN;
                    IF RecGPaymentHeader.GET("No.") THEN;

                    IF RecGPaymentHeader."Account Type" = RecGPaymentHeader."Account Type"::"Bank Account" THEN BEGIN
                        RecBankAccountEntete.SETFILTER(RecBankAccountEntete."No.", '%1', RecGPaymentHeader."Account No.");
                        IF RecBankAccountEntete.FINDFIRST() THEN;
                        BEGIN
                            RIBBK := RecBankAccountEntete."Bank Account No.";
                            NomBk := RecBankAccountEntete.Name;
                            AddressBk := RecBankAccountEntete.Address;

                        END;
                    END;
                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then
                        dev := currency."ISO Code";
                    TexteLettre := '';
                    if (dev = '') or (dev = 'TND') then
                        CU_MntLettre."Montant en texte"(TexteLettre, ABS(CumulMntLCY))
                    else
                        CU_MntLettre."Montant en texteDevise"(TexteLettre, ABS(CumulMntLCY), dev);



                    CLEAR(RecCoffre);
                    IF RecCoffre.GET(RecGPaymentHeader.STCoffre) THEN;

                    /// Get User Id
                    CLEAR(RecUser);
                    RecUser.SETRANGE(RecUser."User Name", USERID);
                    IF RecUser.FINDFIRST() THEN;

                    // Get Bank
                    CompteBK := '';
                    Bank := '';
                    CLEAR(RecBankAccount);
                    RecBankAccount.SETFILTER(RecBankAccount.Code, '%1', "Bank Account Code");
                    RecBankAccount.SETRANGE("Customer No.", "Payment Line"."Account No.");
                    IF RecBankAccount.FINDFIRST() THEN;
                    ;
                    IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::"Bank Account" THEN BEGIN
                        CLEAR(RecBankAccount1);
                        RecBankAccount1.SETRANGE(RecBankAccount1."No.", "Account No.");
                        IF RecBankAccount1.FINDFIRST() THEN
                            CompteBK := RecBankAccount1."Bank Account No.";
                        Bank := RecBankAccount1.Name;

                    END;

                    IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::Vendor THEN BEGIN
                        CLEAR(VendorBankAccount);
                        VendorBankAccount.SETRANGE(VendorBankAccount."Vendor No.", "Account No.");
                        VendorBankAccount.SETRANGE(Code, "Payment Line"."Bank Account Code");
                        IF VendorBankAccount.FINDFIRST() THEN
                            CompteBK := VendorBankAccount."Agency Code" + VendorBankAccount."Bank Account No." + FORMAT(VendorBankAccount."RIB Key");
                        Bank := VendorBankAccount.Name;


                    END;
                end;

                trigger OnPreDataItem();
                begin
                    Increment := 1;
                    IF Rec_Company.GET() THEN;
                    Rec_Company.CALCFIELDS(Picture);
                    TxtCompanyname := Rec_Company.Name;
                    TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
                    CumulMntLCY := 0;
                end;
            }
            dataitem(DataItem1000000037; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = CONST(1));

                column(MontantLettrer; MontantLettrer)
                {
                }
            }
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
        TxtCompanyname: Code[50];
        Increment: Integer;
        Rec_Company: Record "Company Information";
        CU_MntLettre: Codeunit "ST MontantTouteLettre";
        TexteLettre: Text[1024];
        CumulMntLCY: Decimal;
        test: Decimal;
        Partition: array[20] of Decimal;
        Partition2: Decimal;
        NombreLigne: Decimal;
        Pagination: array[100] of Decimal;
        TxtTitre: Label 'BORDEREAU DE REMISE  %1  A L''ENCAISSEMENT';
        TxtReportTitle: Text[250];
        RecGBanque: Record Vendor;
        RecGPaymentHeader: Record "Payment Header";
        MontantLettrer: Decimal;
        RecCoffre: Record "ST Coffre";
        TXTADRESSE: Text;
        RecUser: Record User;
        RecBankAccount: Record "Customer Bank Account";
        IdLettrage: Text[50];
        SlachPos: Integer;
        DocLettrer: Text;
        "Cust. Ledger Entry": Record "Cust. Ledger Entry";
        RecBankAccount1: Record "Bank Account";
        CompteBK: Text[30];
        VendorBankAccount: Record "Vendor Bank Account";
        Bank: Text;
        RecBankAccountEntete: Record "Bank Account";
        RIBBK: Text;
        NomBk: Text;
        AddressBk: Text;
        currency: Record Currency;
        dev: text[10];
}

