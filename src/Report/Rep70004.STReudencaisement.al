report 71004 "STReçu dencaisement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Reçudencaisement.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Reçu d''encaisement';
    dataset
    {
        dataitem(PaymentHead; 10865)
        {
            CalcFields = "Amount (LCY)";
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";
            column(TitreCaption; CstG010)
            {
            }
            column(RecInfoSocieteName; RecInfoSociete.Name)
            {
            }
            column(RecInfoSocieteName2; RecInfoSociete."Name 2")
            {
            }
            column(Logo; RecInfoSociete.Picture)
            {

            }
            column(TelCaption; CstG011)
            {
            }
            column(FaxCaption; CstG012)
            {
            }
            column(RecInfoSocietePhoneNo; RecInfoSociete."Phone No.")
            {
            }
            column(RecInfoSocietePhoneNo2; RecInfoSociete."Phone No. 2")
            {
            }
            column(RecInfoSocieteFaxNo; RecInfoSociete."Fax No.")
            {
            }
            column(Type; Type)
            {
            }
            column(PaymentHeaderNo; "No.")
            {
            }
            column(RecuClientCaption; CstG013)
            {
            }
            // column(recpaiementlineAccountNo; recpaiementline."Account No.")
            // {
            // }
            column(MontantCaption; CstG014)
            {
            }


            column(DateCaption; CstG015)
            {
            }
            column(ImpParCaption; CstG016)
            {
            }
            column(DateGWorkDate; WorkDate())
            {
            }
            column(PaymentHeaderPostingDate; "Posting Date")
            {
            }
            column(STType_Règlement; "STType Règlement")
            {

            }
            column(RecGPaymentClassTypeBordereau; RecGPaymentClass.STType_Reg)
            {
            }

            column(Picture; RecInfoSociete.Picture)
            {
            }
            column(RecGCompanyInfoCity; RecInfoSociete.City)
            {
            }
            column(Phone; RecInfoSociete."Phone No.")
            {

            }
            column(Fax; RecInfoSociete."Fax No.")
            {

            }
            column(MatriculeFiscal; RecInfoSociete."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            dataitem(PaymentLine; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = sorting("Account Type", "Account No.", "Copied To Line", "Payment in Progress");
                column(IntGCounter; IntGCounter)
                {
                }
                column(Line_No_; "Line No.")
                {

                }
                column(NPieceCaption; CstG017)
                {
                }
                column(BanqueClientCaption; CstG018)
                {
                }
                column(DateEcheanceCaption; CstG019)
                {
                }
                column(MontanCaption; CstG020)
                {
                }
                column(NDocLettrageCaption; CstG021)
                {
                }
                column(PaymentLineExternalDocumentNo; PaymentLine."External Document No.")
                {
                }
                column(PaymentLineBankAccountName; PaymentLine."Bank Account Name")
                {
                }
                column(DateEch; DateEch)
                {
                }
                column(Commentaires; STCommentaires)
                {

                }
                column(ABSPaymentLineAmountLCY; PaymentLine."Amount (LCY)")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                // column(Facture; Facture + ' / ')
                // {
                // }
                // column(Facture; PaymentLine."STObject Payment")
                // {
                // }
                column(ListFactLettr; ListFactLettr)
                {

                }
                column(DateRecuCaption; CstG022)
                {
                }
                column(SignatureClientCaption; CstG023)
                {
                }
                column(CaissierCaption; CstG024)
                {
                }
                column(TodayTime; 'Edité le :' + FORMAT(TODAY) + ' - ' + FORMAT(TIME(), 0, 0))
                {
                }
                column(USERID; USERID)
                {
                }
                column(Pied1Caption; CstG025)
                {
                }
                column(Pied2Caption; CstG026)
                {
                }
                column(Pied3Caption; CstG027)
                {
                }
                column(AgencyCodeCaption; CstG028)
                {

                }

                column(AgencyCode; PaymentLine."Bank City")
                {

                }
                column(Order_Type; "STOrder Type")
                {

                }
                column(Order_No; "STOrder No.")
                {

                }
                column(ValeurTimbre; RecSalesHeader."STStamp Amount")
                {

                }
                column(AmountIncludingVAT; RecSalesHeader."Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(recpaiementlineAccountNo; PaymentLine."Account No.")
                {
                }
                column(recpaiementlineLibelle; PaymentLine."STDrawee Reference1")
                {
                }
                column(ABSPaymentHeaderAmountLCY; TotalAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(ABSPaymentHeaderAmountLetter; AmountLetter) //MMOK
                {

                }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {

                    DataItemLink = "Applies-to ID" = FIELD("Applies-to ID"), "Customer No." = field("Account No.");
                    DataItemLinkReference = PaymentLine;
                    DataItemTableView = sorting("Entry No.") WHERE("Applies-to ID" = FILTER(<> ''));

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
                var
                    IDLettrage: Code[50];
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                begin
                    //>>MIG2013 18022013
                    /*   //  IF RecSalesHeader.GET("Payment Line"."N° Bon Commande") THEN;
                       RecSalesHeader.SETFILTER(RecSalesHeader."No.","Payment Line"."N° Bon Commande");
                       IF RecSalesHeader.FIND('-') THEN;
                       IF "Payment Line"."N° Bon Commande"='' THEN
                       TxtValorisation:=''
                       ELSE
                       TxtValorisation:='Réglement Bon de Commande';
                     */

                    TxtValorisation := TxtValorisation + ' | ' + STCommentaires;


                    //IMS
                    IF "Account Type" = "Account Type"::Customer THEN BEGIN

                        RecEcritureClient.SETRANGE("Applies-to ID", "Applies-to ID");
                        IF RecEcritureClient.FIND('-') THEN
                            //MESSAGE('%1',RecEcritureClient.COUNT );
                            REPEAT
                                IF "Applies-to ID" <> '' THEN
                                    Facture += RecEcritureClient."Document No.";
                            UNTIL RecEcritureClient.NEXT() = 0;
                    END;
                    // MESSAGE('%1', Facture);
                    //IMS
                    ///>>section

                    IntCompteur := IntCompteur + 1;
                    IF IntCompteur = 6 THEN BEGIN
                        IntGCounter += 1;
                        IntCompteur := 1;
                        //CurrReport.NEWPAGE;
                    END;
                    //ims
                    //>>DELTA-MSAAYDI-09052013
                    /*
                    IF ("Payment Header"."Payment Class"= 'DECAISS EFFET') OR ("Payment Header"."Payment Class" = 'ENCAISS EFFET') THEN
                       DateEch :="Due Date";
                    */
                    //ims
                    RecGPaymentClass.RESET();
                    RecGPaymentClass.SETRANGE(Code, PaymentHead."Payment Class");
                    IF RecGPaymentClass.FINDFIRST() THEN
                        CASE RecGPaymentClass.STType_Reg OF
                            RecGPaymentClass.STType_Reg::"Chèque", RecGPaymentClass.STType_Reg::Traite:
                                DateEch := "Due Date";

                            ELSE
                                DateEch := PaymentHead."Document Date";
                        END;
                    //<<DELTA-MSAAYDI-09052013

                    //<<MIG2013 18022013
                    if customer.get(PaymentLine."Account No.") then;
                    // DELTA 01
                    ListFactLettr := '';
                    IDLettrage := '';
                    //IDLettrage := "Payment Line"."No." + '/' + FORMAT("Payment Line"."Line No.");
                    IDLettrage := "PaymentLine"."Document No.";

                    CustLedgerEntry.SETRANGE("Applies-to ID", IDLettrage);
                    IF CustLedgerEntry.FINDSET() THEN
                        REPEAT
                            ListFactLettr += CustLedgerEntry."Document No." + ', ';
                        UNTIL CustLedgerEntry.NEXT() = 0;
                    IF STRLEN(ListFactLettr) > 2 THEN
                        ListFactLettr := COPYSTR(ListFactLettr, 1, STRLEN(ListFactLettr) - 2);
                    //
                    /*RecSalesHeader.Reset();
                    RecSalesHeader.SetRange("No.", "STOrder No.");
                    if RecSalesHeader.FindFirst() then;
                    RecSalesLine.Reset();
                    RecSalesLine.SetRange("Document No.", "STOrder No.");
                    if RecSalesLine.FindFirst() then;*/

                    if RecSalesHeader.get(RecSalesHeader."Document Type"::Order, "STOrder No.") then
                        RecSalesHeader.CalcFields("Amount Including VAT");

                    if (PaymentLine."Account No." = PreviousAccountNo) then
                        TotalAmount := TotalAmount + PaymentLine.Amount
                    else begin
                        PreviousAccountNo := PaymentLine."Account No.";
                        TotalAmount := PaymentLine.Amount;
                    end;
                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then
                        dev := currency."ISO Code";

                    AmountLetter := '';
                    if (dev = '') or (dev = 'TND') then
                        CodeU2."Montant en texte"(AmountLetter, Abs(TotalAmount))
                    else
                        CodeU2."Montant en texteDevise"(AmountLetter, abs(TotalAmount), dev);

                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                //>>MIG2013 18022013
                IF RecUserStep.GET(USERID) THEN;
                //IF RecCentreResp.GET(RecUserStep."Filtre Ctr. gestion Reglement") THEN;
                //  ( RecCentreResp basé sur T50100) qui est responsabilite center 2
                ///alors on a laissé RecGResCenter basé sur T5714
                //RecGResCenter.GET(RecUserStep."Filtre Ctr. gestion Reglement") THEN;

                IF PaymentHead."Payment Class" = 'Chèque Client' THEN BEGIN
                    TxtChèque := '*';
                    TxtNcpteCheque := PaymentLine."Bank Account No.";
                    TxtBanqueCheque := PaymentLine."Bank Account Name";
                    TxtNcheque := PaymentLine."External Document No.";
                END
                ELSE
                    IF PaymentHead."Payment Class" = 'Effet Client' THEN BEGIN
                        TxtTraite := '*';
                        TxtNbreTraite := FORMAT(IntCompteur);
                        TxtNcpteTraite := PaymentLine."Bank Account Name";
                        TxtBanqueTraite := PaymentLine."Bank Account Name";
                        TxtNtraite := PaymentLine."External Document No.";
                        //DateEch := "Payment Line"."Due Date";
                    END
                    ELSE
                        IF PaymentHead."Payment Class" = 'Espèce Client' THEN
                            TxtEspèces := '*';
                //>>MBY 25/05/2009


                //<<MIG2013 18022013
                // if PaymentClass.Get(PaymentHead."Payment Class") then
                //     if PaymentClass."Type Bordereau" = PaymentClass."Type Bordereau"::"Chèque" then
                //         Payment_ClassIdentifier := 1
                //     else
                //         if PaymentClass."Type Bordereau" = PaymentClass."Type Bordereau"::Traite then
                //             Payment_ClassIdentifier := 2;
                GLSetup.Get();
                //RepCheck.InitTextVariable;
                //RepCheck.FormatNoTextFR(AmountLetter, ROUND(Abs(PaymentHead."Amount (LCY)"), 0.001), 'TND');
                AmountLetter := '';


            end;

            trigger OnPreDataItem()
            begin
                RecInfoSociete.GET();
                RecInfoSociete.CALCFIELDS(Picture);
                TXTADRESSE := RecInfoSociete.Address + ' ' + RecInfoSociete.City + ' ' + RecInfoSociete."Post Code";
            end;
        }
    }


    var
        GLSetup: Record "General Ledger Setup";
        //  AmountLetter: array[3] of Text[200];
        AmountLetter: Text[1024];
        TextGMnt: Text[250];
        CodeU2: Codeunit "ST MontantTouteLettre";
        Affich: Boolean;
        RepCheck: Report Check;
        PaymentClass: Record "Payment Class";
        Payment_ClassIdentifier: Integer;
        RecInfoSociete: Record "Company Information";
        customer: Record Customer;
        RecUserStep: Record "User Setup";
        "TxtEspèces": Text[30];
        "TxtChèque": Text[30];
        TxtTraite: Text[30];
        TxtNcpteCheque: Text[30];
        TxtNcpteTraite: Text[30];
        TxtBanqueCheque: Text[30];
        TxtBanqueTraite: Text[30];
        TxtNcheque: Text[30];
        TxtNtraite: Text[30];
        IntCompteur: Integer;
        TxtNbreTraite: Text[30];
        RecSalesHeader: Record "Sales Header";
        TxtValorisation: Text[120];
        //recpaiementline: Record "Payment Line";
        PrixText: Text[100];
        DateEch: Date;
        RecEcritureClient: Record "Cust. Ledger Entry";
        Facture: Text[250];
        Type: Text[30];
        DATECH: Date;
        CstG010: Label 'Reçu d''encaissement ';
        CstG011: Label 'Tél :';
        CstG012: Label 'Fax :';
        CstG013: Label 'Reçu du client :';
        CstG014: Label 'Montant :';
        IntGCounter: Integer;
        CstG015: Label 'Date :';
        CstG016: Label 'Impr. par :';
        DateGWorkDate: Date;
        CstG017: Label 'Référence ';
        CstG018: Label 'Banque Client';
        CstG019: Text[100];
        CstG020: Label 'Montant';
        CstG021: Label 'Objet de Règlement';
        test: Integer;
        CstG022: Label 'Date Reçu';
        CstG023: Label 'Signature Client';
        CstG024: Label 'Le caissier';
        CstG025: Label '- EXIGEZ QUE TOUTES LES MENTIONS SOIENT CORRECTEMENT REMPLIES.';
        CstG026: Label '- SAUF CHEQUE OU TRAITE IMPAYE, CE RECU CONSTITUE VOTRE QUITTANCE DE REGLEMENT POUR LES MONTANT QUI Y PORTE';
        CstG027: Label 'NOTE AU CLIENT';
        CstG028: Label 'Agence';

        RecGResCenter: Record "Responsibility Center";
        RecGPaymentClass: Record "Payment Class";
        ListFactLettr: Text[1024];
        dev: Text[5];
        currency: Record Currency;
        TXTADRESSE: Text;
        RecSalesLine: Record "Sales Line";
        PreviousAccountNo: Code[20];
        TotalAmount: Decimal;

    procedure VERIFTYPE()
    begin
        //IMS
        IF PaymentHead."Payment Class" IN ['Décaiss Chèque', 'Encaiss Chèque'] THEN
            Type := 'Chèques';
        IF PaymentHead."Payment Class" IN ['Décaiss Traite', 'Encaiss Traite'] THEN
            Type := 'Traites';
        IF PaymentHead."Payment Class" IN ['DECAISS ESPECE', 'Encaiss Espece ARIANA', 'Encaiss Espece Tozeur'] THEN
            Type := 'Espèces';
        IF PaymentHead."Payment Class" IN ['Décaiss Virement', 'Encaiss Virement'] THEN
            Type := 'Virements';
        //IMS
    end;
}

