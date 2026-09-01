report 71066 "STTraite Fournisseur 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/TraiteFournisseur2.rdl';
    //Not Used UsageCategory = ReportsAndAnalysis;
    //Not Used ApplicationArea = All;
    dataset
    {
        dataitem(PaymentHeader; 10865)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PaymentHeaderNo; PaymentHeader."No.")
            {
            }
            column(name; BankAccount.Name)
            {

            }
            column(BankBranch1; Format(BankAccount."Bank Branch No."))
            {

            }
            column(BankBranch2; Format(BankAccount."Agency Code"))
            {

            }
            column(BankAccount; BankAccount."Bank Account No.")
            {

            }
            column(Clerib; RIB)
            {

            }

            dataitem(PaymentLine; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Account Type" = FILTER(Vendor));
                column(PaymentLineLineNo; PaymentLine."Line No.")
                {
                }
                column(CompanyInfoCity; CompanyInfo.City)
                {
                }
                column(DueDate; "Due Date")
                {
                }
                column(FrsName; Frs.Name)
                {
                }
                column(TxtBranchNo; TxtBranchNo)
                {
                }
                column(TxtAcencyCode; TxtAcencyCode)
                {
                }
                column(TxtAccount1; TxtAccount1)
                {
                }
                column(TxtAccount2; TxtAccount2)
                {
                }
                column(TxtAccount3; TxtAccount3)
                {
                }
                column(TxtAccount4; TxtAccount4)
                {
                }
                column(TxtAccount5; TxtAccount5)
                {
                }
                column(RIB; RIB)
                {
                }
                // column(BankInfo; BankInfo)
                // {
                // }
                column(BankInfo2; BankInfo2)
                {
                }
                column(PaymentLineDebitAmount; '#' + FORMAT("Debit Amount", 0, '<Precision,3:><Standard format,0>') + '#')
                {
                }
                column(MntTTlettre; MntTTlettre)
                {
                }
                column(City; City)
                {
                }
                column(PaymentHeaderPostingDate; PaymentHeader."Posting Date")
                {
                }
                column(CurrencyCode; "Currency Code")
                {
                }
                column(CompanyInfoName; CompanyInfo.Name)
                {
                }
                column(CompanyInfoAddress; CompanyInfo.Address)
                {
                }
                column(CompanyInfoAddress2; CompanyInfo."Address 2")
                {
                }
                column(No; "No.")
                {
                }
                column("BankAccount_grNomModéleTraite"; BankAccount_gr."STSource Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //>>MIG2013 15022013
                    Frs.GET("Account No.");
                    CompBank.RESET();

                    TOT := TOT + PaymentLine."Debit Amount";
                    //<<MIG2013 15022013

                    //>>MIG2013 15022013
                    MntTTlettre := '';
                    Convert."Montant en texte"(MntTTlettre, ABS(Amount));
                    //<<MIG2013 15022013

                    // //>>DELTA-MSAAYDI
                    // CompBank.RESET;
                    // CompBank.SETRANGE("No.", PaymentLine."Header Account No.");//MSAAYDI
                    // IF NOT CompBank.FIND('-') THEN
                    //     CompBank.SETRANGE("No.", CompanyInfo."Default Bank Account No.");
                    // IF CompBank.FIND('-') THEN;
                    // BEGIN
                    //     BankInfo := CompBank.Name + ' ' + CompBank."Name 2" + ' ' + CompBank.Address + ' ' + CompBank."Address 2"
                    //               + ' ' + CompBank.City;
                    //     //BankInfo2:=CompBank."Bank Branch No."+' '+CompBank."Agency Code"+' '+CompBank."Bank Account No."
                    //     // +' '+FORMAT(CompBank."RIB Key");

                    // END;
                    //<<DELTA-MSAAYDI
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>MIG2013 15022013
                CompanyInfo.GET();
                IF PaymentHeader."Currency Code" = '' THEN
                    Devise := 'EUR'
                ELSE
                    Devise := "Currency Code";
                City := "Bank City";

                TxtBranchNo := "Bank Branch No.";
                TxtAcencyCode := COPYSTR("Agency Code", 1, 3);
                //MBK
                TxtAccount1 := COPYSTR("Bank Account No.", 1, 4);
                TxtAccount2 := COPYSTR("Bank Account No.", 5, 3);
                TxtAccount3 := COPYSTR("Bank Account No.", 8, 5);
                TxtAccount4 := COPYSTR("Bank Account No.", 13, 1);
                TxtAccount5 := COPYSTR("Bank Account No.", 14, 2);
                //MBK
                "TxtAccount No" := "Bank Account No.";
                RIB := '';
                RIB := FORMAT("RIB Key");
                IF STRLEN(RIB) < 2 THEN
                    RIB := '0' + RIB;
                //RIB := RIB;

                /*//DELTA-MSAAYDI
                IF BankAccount_gr.GET(DataItem1000000000."Account No.") THEN;
                
                BankInfo:= "Bank Name"+' '+ DataItem1000000000."Bank Name 2"+' '+ "Bank Address"  +' '+ "Bank Address 2"+' '+"Bank City" ;
                */
                //<<MIG2013 15022013


                BankAccount.Reset();
                BankAccount.SetRange("No.", "Account No.");
                if BankAccount.FindFirst() then;

            end;

            trigger OnPreDataItem()
            begin
                //>>MIG2013 15022013
                CompanyInfo.GET();
                //<<MIG2013 15022013
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
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[50];
        Frs: Record Vendor;
        Bank: Record "Vendor Bank Account";
        NomBq: Text[30];
        Compteur: Integer;
        Convert: Codeunit "ST MontantTouteLettre";
        TOT: Decimal;
        NBank: Text[30];
        Nligne: Integer;
        Res: Integer;
        Compte: Integer;
        Devise: Code[10];
        Etab: Text[30];
        Cagence: Text[30];
        CompBank: Record "Bank Account";
        BankInfo: Text[250];
        BankInfo2: Text[250];
        RIB: Text[30];
        TxtBranchNo: Text[30];
        TxtAcencyCode: Text[30];
        "TxtAccount No": Text[30];
        RIBKEY: Integer;
        City: Text[30];
        "---MBY---": Integer;
        MntTTlettre: Text[250];
        TxtAccount1: Text[30];
        TxtAccount2: Text[30];
        TxtAccount3: Text[30];
        TxtAccount4: Text[30];
        TxtAccount5: Text[30];
        Info_gt: Text[80];
        BankAccount_gr: Record "Bank Account";
        BankAccount: Record "Bank Account";
}

