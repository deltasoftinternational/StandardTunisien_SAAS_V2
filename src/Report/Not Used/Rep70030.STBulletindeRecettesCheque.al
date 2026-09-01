report 70030 "STBulletin de Recettes-Cheque"
{

    DefaultLayout = RDLC;
    Caption = 'Bulletin de Recettes-Cheque';
    RDLCLayout = './src/report/RDLC/Bulletin de Recettes - Cheque.rdl';
    //Not Used UsageCategory = ReportsAndAnalysis;
    //Not Used ApplicationArea = All;


    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            RequestFilterFields = "No.";
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
            }
            column(P2; Partition2)
            {
            }
            column(DueDate_PaymentLine; "Payment Line"."Due Date")
            {
            }
            column(NameBanque; FORMAT("Payment Line"."Account No.") + ' : ' + FORMAT("Payment Line"."STLibellé"))
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
            column(TxtReportTitles; TxtReportTitle)
            {
            }
            column(TxtCompanyName; TxtCompanyname)
            {
            }

            column(Montant; "Payment Line".Amount)
            {
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
            column(AssietteRS_PaymentLine; "Payment Line"."STAssiette RS")
            {
            }
            column(CodeMotif_PaymentLine; "Payment Line".STCode_Motif)
            {
            }
            // column(CodeRetenuedeGarantie_PaymentLine; "Payment Line"."Code Retenue de Garantie") mmok
            // {
            // }
            column(CompanyName; Rec_Company.Name)
            {
            }
            column(CompanyAddress; Rec_Company.Address)
            {
            }
            column(MontantRetenue_PaymentLine; "Payment Line"."STMontant Retenue")
            {
            }
            // column(Typepaiement_PaymentHeader; RecGPaymentHeader."Type paiement") mmok
            // {
            // }
            column(NordicLogo; Rec_Company."STInvoice Header Picture")
            {
            }
            column(VolvoLogo; Rec_Company."STInvoice Footer Picture")
            {
            }
            // column(TypeRetenue_PaymentLine; "Payment Line"."Type Retenue") mmok
            // {
            // }
            column("MontantRetenueValidé_PaymentLine"; "Payment Line"."STMontant Retenue Validé")
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
            column(DesignationCoffre; RecCoffre."STDésignation")
            {
            }
            column(Commentaires_PaymentLine; "Payment Line".STCommentaires)
            {
            }
            column(AccountNo_PaymentLine; "Payment Line"."Account No.")
            {
            }
            column("Libellé_PaymentLine"; "Payment Line"."STLibellé")
            {
            }
            column(CreerPar; PaymentHeader."STCréer par")
            {
            }
            column(ListFactLettr; ListFactLettr)
            {
            }
            column(PaymentLineDocumentNo; "Payment Line"."Document No.")
            {
            }
            // column(PaymentLineTypeCommande; "Payment Line"."Type Commande") mmok
            // {
            // }
            // column(PaymentLineCommandeNo; "Payment Line"."Commande No.") mmok
            // {
            // }
            column(PaymentLineInvoiceNo; "Payment Line"."STInvoice No.")
            {
            }
            column(Applies_to_ID; "Applies-to ID")
            {

            }
            column(Picture; Rec_Company.Picture)
            {
            }
            column(RecGCompanyInfoCity; Rec_Company.City)
            {
            }
            column(Phone; Rec_Company."Phone No.")
            {

            }
            column(Fax; Rec_Company."Fax No.")
            {

            }
            column(MatriculeFiscal; Rec_Company."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {

                DataItemLink = "Applies-to ID" = FIELD("Applies-to ID"), "Vendor No." = field("Account No.");
                DataItemLinkReference = "Payment Line";

                column(Document_No_; "Document No.")
                {

                }
                column(Amount_to_Apply; "Amount to Apply")
                {

                }
                column(External_Document_No_; "External Document No.")
                {

                }

            }

            trigger OnAfterGetRecord();
            var
                i: Integer;
            begin

                CumulMntLCY += ABS("Amount (LCY)");
                Increment += 1;
                IF RecGBanque.GET("Account No.") THEN;
                IF RecGPaymentHeader.GET("Payment Line"."No.") THEN;
                TexteLettre := '';
                CU_MntLettre."Montant en texte"(TexteLettre, ABS(CumulMntLCY));
                CLEAR(RecCoffre);
                IF RecCoffre.GET(RecGPaymentHeader.STCoffre) THEN;

                /// Get User Id
                CLEAR(RecUser);
                RecUser.SETRANGE(RecUser."User Name", USERID);
                IF RecUser.FINDFIRST() THEN;

                // Get Bank
                CLEAR(RecBankAccount);
                RecBankAccount.SETFILTER(RecBankAccount.Code, '=%1', "Bank Account Code");
                RecBankAccount.SETRANGE("Customer No.", "Payment Line"."Account No.");
                IF RecBankAccount.FINDFIRST() THEN;
                ;


                // DELTA 01
                IF PaymentHeader.GET("Payment Line"."No.") THEN;
                ListFactLettr := '';
                IDLettrage := '';
                //IDLettrage := "Payment Line"."No." + '/' + FORMAT("Payment Line"."Line No.");
                IDLettrage := "Payment Line"."Document No.";
                CustLedgerEntry.SETRANGE("Applies-to ID", IDLettrage);
                IF CustLedgerEntry.FINDSET() THEN
                    REPEAT
                        ListFactLettr += CustLedgerEntry."Document No." + ' ,';
                    UNTIL CustLedgerEntry.NEXT() = 0;
                IF STRLEN(ListFactLettr) > 2 THEN
                    ListFactLettr := COPYSTR(ListFactLettr, 1, STRLEN(ListFactLettr) - 2);
            end;

            trigger OnPreDataItem();
            begin
                Increment := 1;
                CumulMntLCY := 0;
            end;
        }
        dataitem(DataItem1000000037; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = CONST(1));
            column(CumulMntLCY; CumulMntLCY)
            {
            }
            column(MontantLettrer; MontantLettrer)
            {
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

    trigger OnInitReport();
    begin
        IF Rec_Company.GET() THEN BEGIN
            Rec_Company.CALCFIELDS("STInvoice Header Picture");
            Rec_Company.CALCFIELDS("STInvoice Footer Picture");
            Rec_Company.CalcFields(Picture);
            TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
        END;
    end;

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
        TXTADRESSE: Text[1024];
        RecUser: Record User;
        RecBankAccount: Record "Customer Bank Account";
        PaymentHeader: Record "Payment Header";
        IDLettrage: Code[50];
        ListFactLettr: Text[1024];
        CustLedgerEntry: Record "Cust. Ledger Entry";
}

