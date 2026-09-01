report 71001 "STChèques"
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/report/RDLC/Chèques.rdl';
    ApplicationArea = All;
    dataset
    {
        dataitem(DataItem1000000009; 10865)
        {
            RequestFilterFields = "No.";
            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");
                RequestFilterFields = "No.";
                column(PaymentLineMontantinitial; "Payment Line"."STMontant Initial")
                {
                }
                column(Line_No_; "Line No.")
                {

                }
                column(PaymentLineNcommande; "Payment Line"."Posting Group")
                {
                }
                column(dateEcheance; "Payment Line"."Due Date")
                {
                }
                column(libelle; "Payment Line"."STLibellé")
                {
                }
                column(No_document; "Payment Line"."Document No.")
                {
                }
                column(dateDoc; dateDoc)
                {
                }
                column(amount; "Payment Line".Amount)
                {
                }
                column(CodeBeneficaire; RecGPaymentHeader."Account No.")
                {
                }
                // column(NomBeneficaire; RecGPaymentHeader."Type Règlement")
                // {
                // }
                column(date_comtabilisation; RecGPaymentHeader."Posting Date")
                {
                }
                column(MntTTLettre; montant_en_lettre)
                {
                }
                column(nom_banque; RecGPaymentHeader."Bank Name")
                {
                }
                column(N_borderau; RecGPaymentHeader."No.")
                {
                }
                column(N_bord; RecGPaymentHeader."No.")
                {
                }
                column(Adressefou; Adressefou)
                {
                }
                column(InfSoc_city; RecCompany.City)
                {
                }
                column(RIB; RIB)
                {
                }
                column(TypeBank; RecBankAccount."STModèle chèques")
                {
                }
                column(MontantD; MontantD)
                {
                }
                column(Nom_Fournisseur; Rec_fournisseur.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    RecGPaymentHeader.GET("Payment Line"."No.");
                    montant_en_lettre := '';
                    RecGPaymentHeader.CALCFIELDS("Amount (LCY)");
                    TotalMontant := ABS((RecGPaymentHeader."Amount (LCY)"));
                    if not millimesEnChiffre then
                        Convert_cdu."Montant en texte"(montant_en_lettre, amount)
                    else
                        Convert_cdu."Montant en texte sans millimes"(montant_en_lettre, amount);

                    CLEAR(RecBankAccount);
                    IF RecBankAccount.GET(RecGPaymentHeader."Account No.") THEN;


                    MntTTlettre := '';
                    if not millimesEnChiffre then
                        Convert_cdu."Montant en texte"(MntTTlettre, ABS(Amount))
                    else
                        Convert_cdu."Montant en texte sans millimes"(MntTTlettre, ABS(Amount));
                end;

                trigger OnPreDataItem()
                begin
                    TotalMontant := 0;

                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(option)
                {
                    field(millimesEnChiffre; millimesEnChiffre)
                    {
                        Caption = 'Millimes en Chiffres';
                        ApplicationArea = all;
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

    var
        millimesEnChiffre: Boolean;
        montant_en_lettre: Text;
        Rec_salesInvoices: Record "Sales Invoice Header";
        TotalMontant: Decimal;
        RecPaymentLine: Record "Payment Line";
        RecCompany: Record "Company Information";
        Adresse: Text[100];
        Siege: Text[100];
        CP: Text[50];
        Rec_fournisseur: Record Vendor;
        Convert_cdu: Codeunit "ST MontantTouteLettre";
        Adressefou: Text;
        Rec_salesinvoice: Record "Sales Invoice Header";
        dateDoc: Date;
        RIB: Code[30];
        RecBankAccount: Record "Bank Account";
        Rkey: Text[2];
        TotalMontantIN: Decimal;
        TotalRetenue: Decimal;
        RecGPaymentHeader: Record "Payment Header";
        MntTTlettre: Text;
        MontantD: Text;
}

