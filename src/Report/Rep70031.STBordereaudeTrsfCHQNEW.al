report 70031 "STBordereau de Trsf CHQ - NEW"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Bordereau de Trsf CHQ ';
    RDLCLayout = './src/report/RDLC/Bordereau de Trsf CHQ - NEW.rdl';

    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(ExternalDocumentNo_PaymentLine; "Payment Line"."External Document No.")
                {
                }
                column(DueDate_PaymentLine; "Payment Line"."Due Date")
                {
                }
                column(Amount_PaymentLine; "Payment Line".Amount)
                {
                }
                column(BankAccountCode_PaymentLine; "Payment Line"."Bank Account Code")
                {
                }
                column(PostingDate_PaymentLine; "Payment Line"."Posting Date")
                {
                }
                column(No_PaymentLine; "Payment Line"."No.")
                {
                }
                column(NomClient; RecLcustomer.Name)
                {
                }
                column(Nom; Nom)
                {

                }
                column(RIB; RIB)
                {
                }
                column(CoffreOrigine_PaymentLine; "Payment Line"."STCoffre Origine")
                {
                }

                column(TypeReglement; Rec_PaiementHeader."STType Règlement")
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
                trigger OnAfterGetRecord();
                begin
                    IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::Customer THEN BEGIN
                        CLEAR(RecLcustomer);
                        IF RecLcustomer.GET("Payment Line"."Account No.") THEN
                            Nom := RecLcustomer.Name;
                    END
                    else
                        IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::Vendor THEN BEGIN
                            CLEAR(RecLVendor);
                            IF RecLVendor.GET("Payment Line"."Account No.") THEN
                                Nom := RecLVendor.Name;
                        end;
                    CLEAR(RecBankAccount);
                    RecBankAccount.SETFILTER(RecBankAccount.Code, '%1', "Bank Account Code");
                    RecBankAccount.SETRANGE("Customer No.", "Payment Line"."Account No.");
                    IF RecBankAccount.FINDFIRST() THEN;
                    BEGIN
                        EVALUATE(Rkey, FORMAT(RecBankAccount."RIB Key"));
                        RIB := RecBankAccount."Bank Branch No." + RecBankAccount."Agency Code" +
                        RecBankAccount."Bank Account No." + Rkey;
                    END;
                    Rec_PaiementHeader.GET("No.");
                end;

                trigger OnPreDataItem();
                begin
                    IF Rec_Company.GET() THEN;
                    Rec_Company.CALCFIELDS(Picture);
                    TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
                end;
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
        label(TitleCaption; DAN = 'Kundeliste',
                           ENU = 'Customer List')
        label(PageCaption; DAN = 'Side',
                          ENU = 'Page')
    }

    var
        RecLcustomer: Record Customer;
        RecBankAccount: Record "Customer Bank Account";
        Rkey: Code[20];
        RIB: Code[50];
        RecUserSetup: Record "User Setup";
        Rec_Company: Record "Company Information";
        TXTADRESSE: Text[1024];
        Rec_PaiementHeader: Record "Payment Header";
        Nom: Text[100];
        RecLVendor: Record Vendor;
}

