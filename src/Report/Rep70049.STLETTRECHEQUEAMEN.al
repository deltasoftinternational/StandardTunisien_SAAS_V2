report 71049 "ST LETTRECHEQUEAMEN"
{
    DefaultLayout = RDLC;
    caption = ' Lettre de chèque';
    RDLCLayout = './src/report/RDLC/LETTRECHEQUEAMEN.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(PaymentHeaderNo; "No.")
            {
            }
            column(Account_No_; "Account No.")
            {

            }

            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                //DataItemTableView = SORTING("No chèque", "Line No.")
                DataItemTableView = SORTING("No.", "Line No.")
                                    ORDER(Ascending);
                column("PaymentLineNchèque"; "Payment Line"."STNo. chèque")
                {
                }
                column(TOTCheque_gd; '#' + FORMAT(TOTCheque_gd, 0, '<Precision,3:><Standard format,0>') + '#')
                {
                }
                column(PaymentLineLineNo; "Payment Line"."Line No.")
                {
                }
                column(Mnt1; Mnt1)
                {
                }
                column(AutreNom; AutreNom)
                {
                }
                column(numeroFrns; numeroFrns)
                {

                }
                column(CompanyInfoCity; CompanyInfo.City)
                {
                }
                column(PaymentLinePostingDate; "Payment Line"."Posting Date")
                {
                }
                column(Bank_Account_No; "Bank Account Code")
                {

                }
                column(Facture; Facture)
                {

                }
                column(TypeBank; CompBank."STModèle chèques")
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

                dataitem("Payment Class"; "Payment Class")
                {
                    DataItemLinkReference = "Payment Line";
                    DataItemLink = code = field("Payment Class");

                    column(paymentClass_Type_ED; STType_ED)
                    {

                    }
                    column(TypeReglement; STType_Reg)
                    {

                    }
                }
                trigger OnAfterGetRecord()
                begin
                    //>>MIG2013 14022013
                    IF Frs.GET("Account No.") THEN;
                    CompBank.RESET();
                    TOT := TOT + "Payment Line"."Debit Amount";
                    //TOTCheque_gd+= Amount;
                    //<<MIG2013 14022013

                    //>>MIG2013 14022013 ADD C/AL CODE :Total des  RecGPaymentLine.Amount par n° chèque
                    RecGPaymentLine.RESET();
                    RecGPaymentLine.SETRANGE(RecGPaymentLine."No.", "Payment Header"."No.");
                    RecGPaymentLine.SETRANGE(RecGPaymentLine."STNo. chèque", "Payment Line"."STNo. chèque");
                    IF RecGPaymentLine.FINDSET() THEN
                        TOTCheque_gd := 0;
                    REPEAT
                        TOTCheque_gd += RecGPaymentLine.Amount;
                    UNTIL RecGPaymentLine.NEXT() = 0;
                    //<<MIG2013 14022013

                    //>> MIG2013 14022013
                    MntTTlettre := '';
                    Convert."Montant en texte"(MntTTlettre, ABS(TOTCheque_gd));
                    Mnt1 := '                           ' + MntTTlettre;
                    IF AutreNom = '' THEN
                        AutreNom := Frs.Name;
                    if AutreNom = Frs.Name then
                        numeroFrns := Frs."No.";
                    //<< MIG2013 14022013



                    IF "Payment Line"."Applies-to ID" <> '' THEN BEGIN

                        IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                            RecEcritureFornisseur.SETRANGE("Applies-to ID", "Applies-to ID");
                            RecEcritureFornisseur.SetRange("Vendor No.", "Account No.");
                            IF RecEcritureFornisseur.FIND('-') THEN
                                REPEAT
                                    Facture += RecEcritureFornisseur."Document No." + ' , ';   //hejer 23/11/2012
                                UNTIL RecEcritureFornisseur.NEXT() = 0;
                        END;

                        IF "Account Type" = "Account Type"::Customer THEN BEGIN

                            RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                            RecEcritureClient.SetRange("Customer No.", "Account No.");
                            IF RecEcritureClient.FIND('-') THEN
                                REPEAT
                                    Facture += RecEcritureClient."Document No.";
                                UNTIL RecEcritureClient.NEXT() = 0;
                        END;
                    END;

                    CLEAR(CompBank);
                    RecGPaymentHeader.GET("Payment Line"."No.");
                    IF CompBank.GET(RecGPaymentHeader."Account No.") THEN;
                end;



            }

            trigger OnAfterGetRecord()
            begin
                //>>MIG2013 14022013
                CompanyInfo.GET();
                IF "Payment Header"."Currency Code" = '' THEN
                    Devise := 'EUR'
                ELSE
                    Devise := "Currency Code";
                City := "Bank City";

                TxtBranchNo := "Bank Branch No.";
                TxtAcencyCode := COPYSTR("Agency Code", 3, 3);
                "TxtAccount No" := "Bank Account No.";
                RIB := FORMAT("RIB Key");
                IF STRLEN(RIB) < 2 THEN
                    RIB := '0' + RIB;



                BankInfo := "Bank Name" + ' ' + "Payment Header"."Bank Name 2" + ' ' + "Bank Address" + ' ' + "Bank Address 2" + ' ' + "Bank City";
                TOTCheque_gd := 0;

                //<<MIG2013 14022013
            end;

            trigger OnPreDataItem()
            begin
                //>>MIG2013 14022013
                CompanyInfo.GET();
                //<<MIG2013 14022013
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(AutreNom; AutreNom)
                    {
                        Caption = 'Autre Nom fournisseur :';
                        ApplicationArea = All;
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
        "------DeltaSoft": Integer;
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
        "-MBK-": Integer;
        Mnt1: Text[250];
        Mnt2: Text[250];
        AutreNom: Text[80];
        numeroFrns: Code[20];
        TOTCheque_gd: Decimal;
        RecGPaymentLine: Record "Payment Line";
        RecEcritureFornisseur: Record "Vendor Ledger Entry";
        RecEcritureClient: Record "Cust. Ledger Entry";
        Facture: Text[250];
        RecGPaymentHeader: Record "Payment Header";
}

