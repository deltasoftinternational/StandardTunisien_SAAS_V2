report 70063 "STPosted Retenue a la Source"
{
    Caption = 'Retenue à la source';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/PostedRetSource.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(PaymentHeader; "Payment Header")
        {
            CalcFields = Amount;
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";

            column(PaymentHeaderNo; PaymentHeader."No.")
            {
            }
            column(NDocumentCaption; CstG033)
            {
            }
            column(CodeJournalCaption; CstG034)
            {
            }
            column(PaymentHeaderSourceCode; PaymentHeader."Source Code")
            {
            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = ORDER(Ascending)
                                    WHERE(Amount = FILTER(<> 0),
                                          "Account Type" = CONST(Vendor));
                column(PaymentLineAccountNo; "Payment Line"."Account No.")
                {
                }
                column(Line_No; "Payment Line"."Line No.")
                {

                }
                column(PaymentLineDebitAmount; "Payment Line"."Debit Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(DecTotMontantNet; DecTotMontantNet)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(REPUBLIQUECaption; CstG010)
                {
                }
                column(DIRECTIONCaption; CstG011)
                {
                }
                column(DUPCaption; CstG012)
                {
                }
                column(TitreCaption; CstG013)
                {
                }
                column(SousTitreCaption; CstG014)
                {
                }
                column(OrganismePayCaption; CstG015)
                {
                }
                column(InfoSocName; InfoSoc.Name)
                {
                }
                column(MatriculeFiscaleCaption; CstG016)
                {
                }
                column(CodeTVACaption; CstG017)
                {
                }
                column(CodeCategCaption; CstG018)
                {
                }
                column(NEtablissementCaption; CstG019)
                {
                }
                column(DeneminationCaption; CstG020)
                {
                }
                column(AdresseCaption; CstG021)
                {
                }
                column(InfoSocAddress; InfoSoc.Address)
                {
                }
                column(BeneficiaireCaption; CstG022)
                {
                }
                column("PaymentLineLibellé"; "Payment Line"."STDrawee Reference1")
                {
                }
                column(CINCCaption; CstG023)
                {
                }
                column(CIN; CIN)
                {
                }
                column(PiedCaption; CstG024)
                {
                }
                column(PaymentHeaderPostingDate; PaymentHeader."Posting Date")
                {
                }
                column(InfoSocCity; InfoSoc.City)
                {
                }
                column(SignatureCaption; CstG025)
                {
                }
                column(RetenuEffectueCaption; CstG026)
                {
                }
                column(TauxCaption; CstG027)
                {
                }
                column(BaseRetenueCaption; CstG028)
                {
                }
                column(MontantRetenueCaption; CstG029)
                {
                }
                column(MontantNetCption; CstG030)
                {
                }
                column(Taux; Taux)
                {
                }
                column(PaymentLineMontantInitialDS; "Payment Line"."STMontant Initial DS")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                // column(PaymentLineMontantRetenueGDS; "Payment Line"."Montant Retenue G. DS") MMOK
                // {
                // }
                column(PaymentLineMontantRetenueDS; "Payment Line"."STMontant Retenue Validé DS")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(PaymentLineAmountLCY; "Payment Line"."Amount (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TxtDesignation; TxtDesignation)
                {
                }
                column(DecTotBAseRetenu; DecTotBAseRetenu)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(DecTotMontantRetenu; DecTotMontantRetenu)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalCaption; CstG031)
                {
                }
                column(FatcureCaption; CstG032)
                {
                }
                column(Facture; "Payment Line"."Applies-to Invoices Nos.")
                {
                }
                column(InfoSocMatriculeFiscale18; COPYSTR(NewStringSTE, 1, 8))
                {
                }
                column(InfoSocMatriculeFiscale91; COPYSTR(NewStringSTE, 9, 1))
                {
                }
                column(InfoSocMatriculeFiscale101; COPYSTR(NewStringSTE, 10, 1))
                {
                }
                column(InfoSocMatriculeFiscale113; COPYSTR(NewStringSTE, 11, 3))
                {
                }
                column(FrnsrMatriculeFiscal18; COPYSTR(NewString, 1, 8))
                {
                }
                column(FrnsrMatriculeFiscal91; COPYSTR(NewString, 9, 1))
                {
                }
                column(FrnsrMatriculeFiscal101; COPYSTR(NewString, 10, 1))
                {
                }
                column(FrnsrMatriculeFiscal113; COPYSTR(NewString, 11, 3))
                {
                }
                column(FrnsrAddress; Frnsr.Address)
                {
                }
                column(FrnsrName; Frnsr.Name)
                {

                }
                column(FrnsrNCIN; Frnsr.STCIN)
                {
                }
                column(afficherdetail; afficherdetail)
                {
                }
                column(MntAssiette; "Payment Line"."STAssiette RS")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                trigger OnAfterGetRecord()
                begin
                    //>>MIG2013 20022013
                    Frnsr.GET("Account No.");

                    Adr := Frnsr.Address;
                    //  Matr:=Frnsr."Date Création";
                    //CIN := Frnsr."C.I.N";
                    //$END;

                    EcrFrs.RESET();

                    //>> SODKI CODE ERRONE!!!!

                    //>>SODKI DSFT 26022009
                    //IBK 23/04/2010

                    ///////////////////
                    Retenu.SETRANGE(STCode, "STCode Retenue à la Source");
                    IF Retenu.FIND('-') THEN
                        REPEAT
                            Taux := Retenu."ST% Retenue";
                            TxtDesignation := Retenu.STDesignation;
                        UNTIL Retenu.NEXT() = 0;

                    IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                        RecEcritureFornisseur1.SetRange("Vendor No.", "Account No.");
                        RecEcritureFornisseur1.SetRange("Document Type", RecEcritureFornisseur1."Document Type"::Payment);
                        RecEcritureFornisseur1.SetRange("Document No.", "Payment Line"."No.");
                        if RecEcritureFornisseur1.FindFirst() then begin
                            RecEcritureFornisseur.SetRange("Closed by Entry No.", RecEcritureFornisseur1."Entry No.");
                            IF RecEcritureFornisseur.FIND('-') THEN BEGIN
                                Facture := '';
                                REPEAT
                                    Facture += RecEcritureFornisseur."External Document No." + ' , ';
                                UNTIL RecEcritureFornisseur.NEXT() = 0;
                                Facture := copystr(Facture, 1, strlen(Facture) - 2);
                            END;
                        end;

                    end;

                    IF "Account Type" = "Account Type"::Customer THEN BEGIN

                        RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                        RecEcritureClient.SetRange("Customer No.", "Account No.");
                        IF RecEcritureClient.FIND('-') THEN
                            REPEAT
                                Facture += RecEcritureClient."External Document No.";
                            UNTIL RecEcritureClient.NEXT() = 0;
                    END;

                    //****************TOTAL************

                    DecTotBAseRetenuT := 0;
                    DecTotMontantRetenuT := 0;
                    DecTotMontantNetT := 0;
                    RecPayementLine.SETRANGE("No.", "No.");
                    RecPayementLine.SETRANGE("Account No.", "Account No.");
                    RecPayementLine.SETRANGE("STCode Retenue à la Source", "STCode Retenue à la Source");
                    IF RecPayementLine.FINDFIRST() THEN
                        REPEAT
                            DecTotBAseRetenuT += RecPayementLine."STMontant Initial DS";//+ RecPayementLine."Montant Retenue G. DS";
                            DecTotMontantRetenuT += RecPayementLine."STMontant Retenue DS";
                            DecTotMontantNetT += RecPayementLine."Amount (LCY)";
                        UNTIL RecPayementLine.NEXT() = 0;

                    //SECTION PAYMENT LINE

                    DecTotBAseRetenu += "STMontant Initial DS";// + "Montant Retenue G. DS";
                    DecTotMontantRetenu += "STMontant Retenue DS";
                    DecTotMontantNet += "Amount (LCY)";
                    //<<MIG2013 20022013


                    //dh010921
                    NewString := DELCHR(Frnsr."VAT Registration No.", '=', '/');
                    NewStringSTE := DELCHR(InfoSoc."VAT Registration No.", '=', '/');
                    //dh010921

                end;
            }

            trigger OnPreDataItem()
            begin
                //>>MIG2013 20022013
                InfoSoc.GET();
                Facture := '';
                //<<MIG2013 20022013
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
                    field(Marché; Marché)
                    {
                        Caption = 'Objet du marché';
                        ApplicationArea = All;
                    }
                    field(afficherdetail; afficherdetail)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            OnBeforeOpenRequestPage(afficherdetail);
        end;
    }

    labels
    {
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenRequestPage(var afficherdetail: Option "Afficher Total","Afficher Detail")
    begin
    end;

    var
        CstG010: Label 'REPUBLIQUE TUNISIENNE MINISTERE DES FINANCES';
        CstG011: Label 'DIRECTION GENERALE DU CONTROLE FISCAL';
        CstG012: Label 'Duplicata';
        CstG013: Label 'CERTIFICAT DE RETENUE D''IMPOT SUR LES REVENUS OU D''IMPOTS SUR LES SOCIETES';
        CstG014: Label '( Article 52 du code de l''IRPP & de l''IS )';
        CstG015: Label 'Organisme payeur :';
        CstG016: Label 'Matricule Fiscale';
        CstG017: Label 'Code TVA';
        CstG018: Label 'Code Catégorie';
        CstG019: Label 'N° Etablissement Secondaire';
        CstG020: Label 'Dénomination sociale :';
        CstG021: Label 'Adresse :';
        CstG022: Label 'Bénéficiaire :';
        CstG023: Label 'Ou N° C.I.N. :';
        CstG024: Label 'Le soussigné, certifie exacts les renseignements figurant sur le présent certificat et m''expose aux sanctions par la loi pour toute inexactitude.';
        CstG025: Label 'Cachet et signature  du payeur';
        CstG026: Label 'Retenues effectuées';
        CstG027: Label 'Taux';
        CstG028: Label 'Base Retenue';
        CstG029: Label 'Montant Retenue';
        CstG030: Label 'Montant Net';
        CstG031: Label 'Total:';
        CstG032: Label 'Factures objet de retenues :';
        Frnsr: Record Vendor;
        Adr: Text[100];
        CIN: Code[10];
        //Converts: Codeunit  
        "Marché": Text[100];
        Retenu: Record "ST Groupe retenue";
        Taux: Decimal;
        InfoSoc: Record "Company Information";
        EcrFrs: Record "Vendor Ledger Entry";
        Facture: Text;
        TxtDesignation: Text[250];
        RecEcritureFornisseur: Record "Vendor Ledger Entry";
        RecEcritureFornisseur1: Record "Vendor Ledger Entry";
        RecEcritureClient: Record "Cust. Ledger Entry";
        DecTotBAseRetenu: Decimal;
        DecTotMontantRetenu: Decimal;
        DecTotMontantNet: Decimal;
        afficherdetail: Option "Afficher Total","Afficher Detail";
        RecPayementLine: Record "Payment Line";
        DecTotBAseRetenuT: Decimal;
        DecTotMontantRetenuT: Decimal;
        DecTotMontantNetT: Decimal;
        CstG033: Label 'N° Document :';
        CstG034: Label 'Code journal :';
        NewString: Text[20];
        NewStringSTE: Text[20];
}

