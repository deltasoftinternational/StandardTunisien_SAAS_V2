report 70002 "STPièce de Paiement"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/PiècedePaiement.rdl';

    dataset
    {
        dataitem(PaymentHeader; "Payment Header")
        {
            RequestFilterFields = "No.";
            column(PaymentHeaderNo; PaymentHeader."No.")
            {
            }

            column(Bank_Name; "Bank Name")
            {

            }

            column(DateGWorkDate; DateGWorkDate)
            {
            }
            column(PaymentHeaderPostingDate; PaymentHeader."Posting Date")
            {
            }
            column(PostingDateCaption; FIELDCAPTION("Posting Date"))
            {
            }
            //dh010921
            column(Status_Name; "Status Name")
            {

            }
            column(CurrencyCode; devise)
            {

            }
            column(modeDeReglement; paymentClass.STType_Reg)
            {

            }
            //dh010921

            column(DatEch; DatEch)
            {
            }
            column(TitreCaption; CstG010)
            {
            }
            column(DirectionGenCaption; CstG011)
            {
            }
            column(TotalCaption; CstG012)
            {
            }
            column(PaymentHeaderAmountLCY; PaymentHeader.Amount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(PaymentHeader_Agence; PaymentHeader.STAgence)
            {
            }
            column(Adresse_Agence; Adresse)
            {
            }
            column(telephone_Agence; telephone)
            {
            }
            column(Fax_Agence; Fax)
            {
            }
            column(TextGMnt; TextGMnt)
            {
            }
            column(LaSommeDeCaption; CstG013)
            {
            }
            column(amountL; amountL)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(TotalAmount; TotalAmount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }

            column(Picture; RecGCompanyInfo.Picture)
            {
            }
            column(RecGCompanyInfoCity; RecGCompanyInfo.City)
            {
            }
            column(Phone; RecGCompanyInfo."Phone No.")
            {

            }
            column(Fax; RecGCompanyInfo."Fax No.")
            {

            }
            column(MatriculeFiscal; RecGCompanyInfo."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            dataitem(PaymentLine; "Payment Line")
            {

                DataItemLink = "No." = FIELD("No.");
                RequestFilterFields = "No.";
                DataItemLinkReference = PaymentHeader;

                column(PaymentLineNo; PaymentLine."No.")
                {
                }

                column(AccountNo; "Account No.")
                {

                }
                column(PaymentLineAccountNo; PaymentLine."Account No.")
                {
                }
                column(PaymentLineLineNo; PaymentLine."Line No.")
                {
                }
                column(BeneficiaireCaption; CstG014)
                {
                }
                column(NVendor; NVend)
                {
                }
                column(NomVendor; NomVend)
                {
                }
                column(PayementEffectueCaption; CstG015)
                {
                }
                column(Type; Type)
                {
                }
                column(TypeReglment; TypeReglement)
                {
                }
                column(NumDoc; "External Document No.")
                {
                }
                column(PaymentLineDueDate; DateCompta)
                {
                }
                column(TxtDesignationBanque; TxtDesignationBanque)
                {
                }
                //dh0109/21
                column(DueDate; PaymentLine."Due Date")
                {

                }
                column(Observations; PaymentLine.STObservations)
                {

                }
                //dh0109/21

                column(PaymentLineAmountLCY; PaymentLine."Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(ObjetPayment_PaymentLine; PaymentLine."STLibellé")
                {
                }

                column(Facture; Facture)
                {
                }
                column(total2; total2)
                {

                }
                column(Amount; Amount1)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;

                }
                column(DirecteurADMCaption; CstG016)
                {
                }
                column(DirecteurGeneCaption; CstG017)
                {
                }
                column(affiche1page; affiche1page)
                {
                }
                column(PieceCaption; CstG018)
                {
                }
                column(DirectionCenCaption; CstG019)
                {
                }
                column(PayementLine_Commentaires; PaymentLine.STCommentaires)
                {
                }
                column("Libellé_PaymentLine"; PaymentLine.STLibellé)
                {
                }

                column(MntAssiette; "PaymentLine"."STAssiette RS")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;

                }
                column(PaymentLineMontantRetenueDS; "PaymentLine"."STMontant Retenue")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(PaymentLineMontantInitialDS; "PaymentLine"."STMontant Initial")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Applies_to_ID; "Applies-to ID")
                {

                }
                column(documentN; documentN)
                {

                }

                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {

                    DataItemLink = "Applies-to ID" = FIELD("Applies-to ID"), "Vendor No." = field("Account No.");
                    DataItemLinkReference = PaymentLine;
                    DataItemTableView = sorting("Entry No.") WHERE("Applies-to ID" = FILTER(<> ''));
                    //   DataItemTableView = sorting("Entry No.") where("Applies-to ID"  = filter('No.\*')  );

                    column(Document_No_; "Document No.")
                    {

                    }
                    column(Amount_to_Apply; "Amount to Apply")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;

                    }
                    column(External_Document_No_; "External Document No.")
                    {

                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //IF "Payment Line"."No chèque Alphanum"<>'' THEN
                    //  NumDoc:=FORMAT("Payment Line"."No chèque Alphanum")// + "Payment Line"."N° chèque")
                    //ELSE
                    //    NumDoc:=FORMAT("Payment Line"."External Document No.");
                    //Facture:='';
                    //>>DSFT 13 07 2010
                    total2 := 0;
                    IF PaymentLine."Applies-to ID" <> '' THEN BEGIN

                        IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                            RecEcritureFornisseur.SETRANGE("Applies-to ID", "Applies-to ID");
                            RecEcritureFornisseur.SetRange("Vendor No.", "Account No.");
                            IF RecEcritureFornisseur.FindSet() THEN
                                REPEAT
                                    documentN := RecEcritureFornisseur."Document No.";
                                    Amount1 := RecEcritureFornisseur."Amount to Apply";
                                    total2 := total2 + ABS(RecEcritureFornisseur."Amount to Apply");
                                    Facture := RecEcritureFornisseur."External Document No.";//hejer
                                UNTIL RecEcritureFornisseur.NEXT() = 0;
                        END;

                        IF "Account Type" = "Account Type"::Customer THEN BEGIN

                            RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                            IF RecEcritureClient.FindSet() THEN
                                REPEAT
                                    total2 := total2 + ABS(RecEcritureFornisseur."Amount to Apply");
                                    Facture := RecEcritureClient."External Document No.";  //hejer
                                UNTIL RecEcritureClient.NEXT() = 0;
                        END;
                    END;

                    //<<DSFT 13 07 2010

                    IF PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::Traite then
                        DateCompta := PaymentLine."Due Date" ELSE
                        DateCompta := PaymentHeader."Posting Date";


                    amountL := PaymentLine."Amount";
                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then begin
                        dev := currency."ISO Code";
                        if PaymentHeader."Currency Code" <> '' then
                            devise := currency.Description else
                            devise := 'TND';

                    end;
                    //MTTLETTRE
                    TextGMnt := '';
                    PaymentHeader.CalcFields(Amount);
                    TotalAmount := PaymentHeader.Amount;
                    PaymentHeader.CALCFIELDS("Amount (LCY)");
                    if (dev = '') or (dev = 'TND') then
                        CodeU."Montant en texte"(TextGMnt, Abs(TotalAmount))
                    else
                        CodeU."Montant en texteDevise"(TextGMnt, Abs(TotalAmount), dev);

                end;
            }



            trigger OnAfterGetRecord()
            begin

                //>>IBK DSFT 13 12 2010
                RecBanque.SETRANGE("No.", "Account No.");
                IF RecBanque.FINDFIRST() THEN
                    REPEAT
                        TxtDesignationBanque := RecBanque.Name;
                    UNTIL RecBanque.NEXT() = 0;
                //<<IBK DSFT 13 12 2010

                //IMS
                VERIFTYPE();
                //IMS
                // RecPaymentClass.RESET;
                // RecPaymentClass.SETRANGE(RecPaymentClass.Code, "Payment Class");
                // IF RecPaymentClass.FINDFIRST THEN
                //     TypeReglement := FORMAT(RecPaymentClass.);

                PayClass := '';
                PayClass := "Payment Class";
                PayLine.RESET();
                PayLine.SETFILTER(PayLine."No.", PaymentHeader."No.");
                PayLine.SETRANGE(PayLine."Account Type", PayLine."Account Type"::Vendor);
                IF PayLine.FINDFIRST() THEN BEGIN
                    Nbre := PayLine.COUNT;
                    //IMS
                    IF (PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::Traite) THEN
                        DatEch := 'Date Echéance' ELSE
                        DatEch := 'Date ';

                    //IMS
                    IF Vend.GET(PayLine."Account No.") THEN BEGIN
                        NVend := Vend."No.";
                        NomVend := Vend.Name;
                        FormatAdresse.Vendor(FnsAdr, Vend);
                    END;
                END;


                //dh type reglement 
                paymentClass.Reset();
                paymentClass.SetRange(Code, "Payment Class");
                if paymentClass.FindFirst() then;

                PaymentLine.Reset();
                PaymentLine.SetRange("No.", PaymentHeader."No.");
                if PaymentLine.FindFirst() then;
            end;

            trigger OnPreDataItem()
            begin
                InfoSoc.GET();
                FormatAdresse.Company(AdrSoc, InfoSoc);
                amountL := 0;
                TotalAmount := 0;
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
                    field(DateSel; DateSel)
                    {
                        Caption = 'Date d''impression';
                        ApplicationArea = All;
                    }
                    field(affiche1page; affiche1page)
                    {
                        Caption = 'Aff.une Seule Page';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            //>>MIG2013
            DateSel := TODAY;
            //<<MIG2013
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        RecGCompanyInfo.GET();
        DateGWorkDate := WORKDATE();
        RecGCompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";

    end;

    var
        RecGCompanyInfo: Record "Company Information";
        DateGWorkDate: Date;
        "-----": Integer;
        InfoSoc: Record "Company Information";
        CpteBqe: Record "Bank Account";
        EnTeteFactAchat: Record "Purch. Inv. Header";
        FormatAdresse: Codeunit "Format Address";
        AdrSoc: array[8] of Text[80];
        FnsAdr: array[8] of Text[80];
        DateSel: Date;
        Bnad: array[8] of Text[80];
        BqeSociete: Record "Bank Account";
        EcrtFrs: Record "Vendor Ledger Entry";
        Numfact: Code[20];
        NumcompteB: Code[20];
        Modereg: Record "Payment Method";
        Dep: Code[10];
        PayHeader: Record "Payment Header";
        Vend: Record Vendor;
        NVend: Code[20];
        NomVend: Text[80];
        PayClass: Text[80];
        Nbre: Integer;
        PayLine: Record "Payment Line";
        Nbre1: Integer;
        DocLettrage: Text[80];
        EcrFrs: Record "Vendor Ledger Entry";
        CodeU: Codeunit "ST MontantTouteLettre";
        TextGMnt: Text[250];
        DatEch: Text[50];
        Type: Text[30];
        NumDoc: Text[30];
        RecEcritureFornisseur: Record "Vendor Ledger Entry";
        Facture: Text[250];
        RecEcritureClient: Record "Cust. Ledger Entry";
        RecBanque: Record "Bank Account";
        TxtDesignationBanque: Text[30];
        affiche1page: Boolean;
        paymentClass: Record "Payment Class";
        currency: Record Currency;
        devise: Text[30];

        CstG010: Label 'ORDRE DE PAIEMENT';
        CstG011: Label 'La Direction Générale autorise le paiement designé ci-après :';
        CstG012: Label 'Total';
        CstG013: Label 'LA SOMME DE ';
        CstG014: Label 'BENEFICIAIRE :';
        CstG015: Label 'PAIEMENT EFFECTUE PAR :';
        CstG016: Label 'DIRECTECTION FINANCIER';
        CstG017: Label 'DIRECTION GENERALE';
        CstG018: Label 'PIECE DE PIEMENT';
        CstG019: Label 'D.G.A';
        TypeReglement: Text[200];
        RecPaymentClass: Record "Payment Class";
        Adresse: Text[300];
        telephone: Text[30];
        Fax: Text[30];
        DateCompta: Date;
        total2: Decimal;
        documentN: Code[50];
        Amount1: Decimal;
        dev: Text[30];
        paymentL: Record "Payment Line";
        amountL: Decimal;
        TotalAmount: Decimal;
        TXTADRESSE: Text;

    procedure VERIFTYPE()
    begin

        IF PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::"Chèque" THEN
            Type := 'Chèque N°';
        IF PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::Traite THEN
            Type := 'Traite N°';
        IF PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::"Espèce" THEN
            Type := 'Espèce N°';
        IF PaymentHeader.STType_Reg = PaymentHeader.STType_Reg::Virement THEN
            Type := 'Virement N°';

        //IMS
    end;
}

