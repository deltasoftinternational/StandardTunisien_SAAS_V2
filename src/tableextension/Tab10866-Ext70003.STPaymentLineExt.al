tableextension 70003 "ST PaymentLineExt" extends "Payment Line" //10866
{
    fields
    {
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                vendor: Record Vendor;
                GeneralLedgerSetup: Record "General Ledger Setup";
            begin
                GeneralLedgerSetup.get();
                if "Account Type" = "Account Type"::Vendor then
                    if vendor.get("Account No.") then
                        if vendor."STCode Retenue a la Source" = '' then
                            rec."STCode Retenue à la Source" := GeneralLedgerSetup."STRetenu par def."
                        else
                            "STCode Retenue à la Source" := vendor."STCode Retenue a la Source";

            end;
        }
        field(70000; "STCode Retenue à la Source"; Code[10])
        {

            Caption = 'Code retenue à la source';

            TableRelation = "ST Groupe retenue".STCode WHERE("STType Retenue" = FILTER("à la source"));
            trigger OnValidate()
            var

                Vend: record Vendor;
            begin
                //<< DELTA 01 RAD 05/12/2014
                IF "Account Type" = "Account Type"::Vendor THEN
                    IF "STCode Retenue à la Source" <> '' THEN BEGIN
                        CLEAR(Vend);
                        Vend.GET("Account No.");
                        Vend.TESTFIELD("STExonoré de la R.S", FALSE);
                    END;

                //>> End DELTA 01
            end;

        }
        field(70001; "STMontant Retenue"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Montant retenue';

            trigger OnValidate()
            var
                RecGCurrency: Record Currency;
                RecGCurrencyExchangeRate: Record "Currency Exchange Rate";
                RecGPaymentStatus: Record "Payment Status";
                RecGGeneralLedgerSetup: Record "General Ledger Setup";
            begin
                RecGGeneralLedgerSetup.GET();
                IF ((Amount > 0) AND ("STMontant Retenue" > 0)) OR ((Amount < 0) AND ("STMontant Retenue" < 0)) THEN
                    "STMontant Retenue" := -"STMontant Retenue";

                // Calc Montant Retenu
                IF "Currency Code" <> '' THEN RecGCurrency.GET("Currency Code");
                IF ("STMontant Retenue" <> 0) AND ("STMontant Retenue Validé" = 0) AND (RecGPaymentStatus."STCalculer retenue a la source") THEN
                    IF "Currency Code" <> '' THEN
                        "STMontant Retenue DS" := ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date",
                        "Currency Code", "STMontant Retenue", "Currency Factor")
                        , RecGGeneralLedgerSetup."Amount Rounding Precision")
                    ELSE
                        "STMontant Retenue DS" := ROUND("STMontant Retenue", RecGGeneralLedgerSetup."Amount Rounding Precision");
            end;
        }
        field(70002; "STMontant Retenue Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Montant retenue validé';
            Editable = false;
        }
        field(70003; "STMontant Retenue DS"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant retenue DS';
        }
        field(70004; "STMontant Retenue Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant retenue validé DS';
            Editable = false;
        }


        field(70005; "STAppliquer Retenue Source"; Boolean)
        {
            Caption = 'Appliquer retenue à la source';
        }

        field(70006; "STMontant Initial"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Montant initial';
        }
        field(70007; "STMontant Initial DS"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Montant initial DS';
        }
        field(70008; "STDrawee Reference1"; Text[100])
        {
            DataClassification = ToBeClassified;
            CaptionML = FRA = 'Référence tiré', ENU = 'Drawee Reference';
        }

        field(70009; "STLibellé"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Libellé';
        }

        field(70010; STCommentaires; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commentaires';
        }

        field(70011; "STEn Banque"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'En banque';
            Editable = false;
        }

        field(70012; "STGroupe Comptabilisation"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Groupe comptabilisation';
            TableRelation = IF ("Account Type" = CONST(1)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(2)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST(5)) "FA Posting Group";
        }
        field(70013; "STAvance ouvert"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Avance ouvert';
        }
        field(70014; "STJob No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job No.';
        }

        field(70015; "STCode_Mode_Règlement"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code mode règlement';
        }
        field(70016; "STRib_Entête"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rib entête';
        }

        field(70017; "STMontant Frais a Déduire"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Montant frais à déduire';

            trigger OnValidate()
            begin

                "STAssiette RS" := "STMontant Initial" - "STMontant Frais a Déduire" + "STMnt Déduction";
            end;
        }
        field(70018; "STAssiette RS"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Assiette RS';

            trigger OnValidate()
            begin
                "STMontant Frais a Déduire" := 0;
                "STMontant Frais a Déduire" := "STMontant Initial" - "STAssiette RS" + "STMnt Déduction";
            end;
        }
        field(70019; "STMnt Déduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
            Caption = 'Montant déduction';

            trigger OnValidate()
            begin
                "STAssiette RS" := "STMontant Initial" - "STMontant Frais a Déduire" + "STMnt Déduction";
            end;
        }
        field(70020; STCoffre; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coffre';
            TableRelation = "ST Coffre";
        }
        field(70021; "STType Règlement"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type règlement';
        }

        field(70022; "STCoffre Origine"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coffre origine';
        }

        field(70024; STObservations; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Observations';
        }
        field(70023; "STInvoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Invoice No.';
        }
        field(70025; STCode_Motif; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code motif';
            TableRelation = "Reason Code".Code;
        }
        field(70026; "STOrder Type"; Enum "ST Order Type Enum")
        {
            Caption = 'Order Type';
        }
        field(70027; "STOrder No."; Code[20])
        {
            Caption = 'N° commande';
            DataClassification = ToBeClassified;

            TableRelation = IF ("STOrder Type" = FILTER("Sales Orders")) "Sales Header"."No." WHERE("Document Type" = FILTER(Order), "Bill-to Customer No." = FIELD("Account No.")) ELSE
            IF ("STOrder Type" = FILTER("Purchase Orders")) "Purchase Header"."No." WHERE("Document Type" = FILTER(Order), "Buy-from Vendor No." = FIELD("Account No.")) ELSE
            IF ("STOrder Type" = FILTER("Sales Blanket Order")) "Sales Header"."No." WHERE("Document Type" = FILTER("Blanket Order"), "Bill-to Customer No." = FIELD("Account No."));
            trigger OnValidate()
            var
                salesline: Record "Sales Line";
                salesheader: Record "Sales Header";
                purchaseLine: Record "Purchase Line";
                prurchaseHeader: Record "Purchase Header";
            begin
                salesline.Reset();
                salesheader.Reset();
                "Credit Amount" := 0;
                "Debit Amount" := 0;
                case "STOrder Type" of
                    "STOrder Type"::"Sales Blanket Order":
                        begin
                            salesline.SetRange("Document No.", "STOrder No.");
                            if salesline.FindFirst() then begin
                                salesheader.SetRange("No.", salesline."Document No.");
                                if salesheader.FindFirst() then
                                    "Credit Amount" := salesline."Amount Including VAT" + salesheader."STStamp Amount";

                            end;
                        end;
                    "STOrder Type"::"Sales orders":
                        begin
                            salesline.SetRange("Document No.", "STOrder No.");
                            if salesline.FindFirst() then begin
                                salesheader.SetRange("No.", salesline."Document No.");
                                if salesheader.FindFirst() then
                                    "Credit Amount" := salesline."Amount Including VAT" + salesheader."STStamp Amount";

                            end;
                        end;
                    "STOrder Type"::"Purchase Orders":
                        begin
                            purchaseLine.SetRange("Document No.", "STOrder No.");
                            if purchaseLine.FindFirst() then begin
                                prurchaseHeader.SetRange("No.", purchaseLine."Document No.");
                                if prurchaseHeader.FindFirst() then
                                    "Debit Amount" := purchaseLine."Amount Including VAT" + prurchaseHeader."STStamp Fiscal Amount";

                            end;
                        end;
                end;
            end;
        }
        field(70028; "STNo. chèque"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'DELTA STD 01';
        }
        field(70033; "STType paiement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'DELTA STD 01';
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;
        }
        field(70034; "ST Check No"; Code[35])
        {
            DataClassification = ToBeClassified;
            Caption = 'No chéque';
            Description = 'DELTA MD 10-01-20';

            trigger OnValidate()
            var
                PaymentHeader_lr: Record "Payment Header";
                lCheckReference: Record "ST Référence chèque";
                lChecks: Record "ST chéque";
                Text001: Label 'Numéro utilisé';
                Text002: Label 'Numéro hors intervalle';
                Text003: Label 'Numéro bloqué';
                lPaymentLine: Record "Payment Line";
                lPaymentHeader: Record "Payment Header";
                Text004: Label 'This Check is used in another payment slip';
                lChecks2: Record "ST chéque";
            begin
                //>>DELTA 21
                IF ("ST Check No" <> '') THEN BEGIN
                    VALIDATE("External Document No.", FORMAT("ST Check No"));
                    PaymentHeader_lr.RESET();
                    IF PaymentHeader_lr.GET("No.") THEN;
                    IF lChecks.GET(PaymentHeader_lr."Account No.", "ST Réference chéque", "ST Check No") THEN BEGIN
                        lChecks."ST Status" := lChecks."ST Status"::"In Progress";
                        lChecks."ST Payment Slip No." := Rec."No.";
                        lChecks."ST Line Payment Slip No" := Rec."Line No.";
                        lChecks."ST Account Type" := FORMAT(Rec."Account Type");
                        lChecks."ST Amount line" := Rec.Amount;
                        lChecks.MODIFY();
                    END;

                    IF lCheckReference.GET(PaymentHeader_lr."Account No.", "ST Réference chéque") THEN
                        IF ("ST Check No" < lCheckReference."ST Starting No.") OR ("ST Check No" > lCheckReference."ST Ending No.") THEN
                            ERROR(Text002);

                END;
                IF (Rec."ST Check No" <> xRec."ST Check No") AND (Rec."ST Check No" = '') THEN BEGIN
                    Rec."External Document No." := '';
                    // Rec."Réference chéque":='';
                    Rec.MODIFY();
                END;
                //
                IF (Rec."ST Check No" <> xRec."ST Check No") AND (Rec."ST Check No" = '') THEN BEGIN
                    PaymentHeader_lr.GET("No.");
                    lChecks2.RESET();
                    IF lChecks2.GET(PaymentHeader_lr."Account No.", Rec."ST Réference chéque", xRec."ST Check No") THEN BEGIN
                        lChecks2."ST Status" := lChecks2."ST Status"::New;
                        lChecks2."ST Payment Slip No." := '';
                        lChecks2."ST Line Payment Slip No" := 0;
                        lChecks2."ST Account Type" := '';
                        lChecks2.MODIFY();
                    END;
                END;


                IF ("ST Check No" <> xRec."ST Check No") AND (xRec."ST Check No" <> '') THEN BEGIN
                    PaymentHeader_lr.GET("No.");
                    lChecks2.RESET();
                    IF lChecks2.GET(PaymentHeader_lr."Account No.", Rec."ST Réference chéque", xRec."ST Check No") THEN BEGIN
                        lChecks2."ST Status" := lChecks2."ST Status"::New;
                        lChecks2."ST Payment Slip No." := '';
                        lChecks2."ST Line Payment Slip No" := 0;
                        lChecks2."ST Account Type" := '';
                        lChecks2.MODIFY();
                    END;
                END;

                //
                RecPaymentHeader.GET("No.");
                IF "ST Check No" <> '' THEN BEGIN
                    lPaymentLine.RESET();
                    lPaymentLine.SETRANGE("ST Réference chéque", Rec."ST Réference chéque");
                    lPaymentLine.SETRANGE("ST Check No", Rec."ST Check No");
                    IF lPaymentLine.FINDSET() THEN
                        REPEAT
                            lPaymentHeader.GET(lPaymentLine."No.");
                            IF (lPaymentHeader."Account No." = RecPaymentHeader."Account No.") AND (lPaymentHeader."No." <> RecPaymentHeader."No.") THEN
                                ERROR(Text004, lPaymentHeader."No.");
                        UNTIL lPaymentLine.NEXT() = 0;
                END;

                //<<DELTA 21
            end;

            trigger OnLookup()
            var
                GLSetup: Record "General Ledger Setup";
                PaymentHeader_lr: Record "Payment Header";
                lChecks: Record "ST chéque";
                lChecksOld: Record "ST chéque";
                lCheckReference: Record "ST Référence chèque";
                lChecksPage: Page "ST chèque";
                Text0014: Label 'Veuillez d''abord sélectionner une référence chèque.';
            begin
                GLSetup.GET();
                IF NOT GLSetup."ST Manual Check Selection" THEN
                    EXIT;

                IF Rec."ST Réference chéque" = '' THEN
                    ERROR(Text0014);

                PaymentHeader_lr.GET(Rec."No.");

                CLEAR(lChecks);
                lChecks.SETRANGE("ST Banque Code", PaymentHeader_lr."Account No.");
                lChecks.SETRANGE("ST Réference chéque", Rec."ST Réference chéque");
                lChecks.SETRANGE("ST Status", lChecks."ST Status"::New);

                CLEAR(lChecksPage);
                lChecksPage.SETTABLEVIEW(lChecks);
                lChecksPage.SETRECORD(lChecks);
                IF lChecksPage.RUNMODAL() = ACTION::OK THEN BEGIN
                    lChecksPage.GETRECORD(lChecks);

                    IF (Rec."ST Check No" <> '') AND (Rec."ST Check No" <> lChecks."ST Check No") THEN
                        IF lChecksOld.GET(PaymentHeader_lr."Account No.", Rec."ST Réference chéque", Rec."ST Check No") THEN BEGIN
                            lChecksOld."ST Status" := lChecksOld."ST Status"::New;
                            lChecksOld."ST Payment Slip No." := '';
                            lChecksOld."ST Line Payment Slip No" := 0;
                            lChecksOld."ST Account Type" := '';
                            lChecksOld."ST Amount line" := 0;
                            lChecksOld.MODIFY();
                        END;

                    VALIDATE("ST Check No", lChecks."ST Check No");
                    VALIDATE("External Document No.", "ST Check No");

                    lCheckReference.GET(PaymentHeader_lr."Account No.", Rec."ST Réference chéque");
                    lCheckReference."ST Last No. Used" := lChecks."ST Check No";
                    lCheckReference."ST Last Date Used" := TODAY;
                    lCheckReference.MODIFY();
                END;
            end;
        }
        field(70035; "ST Réference chéque"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Réference chéque';
            Description = 'DELTA MD 10-01-20';
            TableRelation = "ST Référence chèque";

            trigger OnLookup()
            var
                PaymentHeader_lr: Record "Payment Header";
                lCheckReferenceList: Page "ST Référence chèque";
                lCheckReference: Record "ST Référence chèque";
                lChecks: Record "ST chéque";
                PaymentLine_lr: Record "Payment Line";
                Text0010: Label 'Le n° de chèque est inValide';
                Text0011: Label 'Veuillez choisir le numéro de compte.';
                Text0012: Label 'Check No. is empty';
                l_Checks: Record "ST chéque";
                Text0013: Label 'Le n° de chèque est vide';
                GLSetup: Record "General Ledger Setup";
            begin
                IF (rec."ST Check No" <> '') THEN
                    ERROR(Text0013);
                IF (Rec."ST Réference chéque" = '') OR (Rec."ST Réference chéque" <> '') OR (Rec."ST Réference chéque" <> xRec."ST Réference chéque") THEN BEGIN
                    PaymentHeader_lr.RESET();
                    IF PaymentHeader_lr.GET("No.") THEN;
                    CLEAR(lCheckReferenceList);
                    lCheckReference.SETRANGE("ST Bank Code", PaymentHeader_lr."Account No.");
                    lCheckReference.SETRANGE("ST Check Generated", TRUE);
                    lCheckReferenceList.SETTABLEVIEW(lCheckReference);
                    lCheckReferenceList.SETRECORD(lCheckReference);
                    IF lCheckReferenceList.RUNMODAL() = ACTION::OK THEN BEGIN
                        lCheckReferenceList.GETRECORD(lCheckReference);
                        "ST Réference chéque" := lCheckReference."ST Réference chéque";
                    END;
                    /////// MISE A JOUR N CHEQUE
                    /// 
                    GLSetup.GET();
                    IF NOT GLSetup."ST Manual Check Selection" THEN BEGIN
                        lCheckReference.RESET();
                        CLEAR(lChecks);
                        lChecks.SETRANGE(lChecks."ST Banque Code", PaymentHeader_lr."Account No.");
                        lChecks.SETRANGE("ST Réference chéque", "ST Réference chéque");
                        lChecks.SETRANGE(lChecks."ST Status", lChecks."ST Status"::New);
                        IF lChecks.FINDFIRST() THEN BEGIN
                            PaymentLine_lr.RESET();
                            PaymentLine_lr.SETRANGE("No.", PaymentHeader_lr."No.");
                            IF PaymentLine_lr.FINDSET() THEN
                                REPEAT
                                    IF PaymentLine_lr."ST Check No" <> '' THEN
                                        "ST Check No" := PaymentLine_lr."ST Check No";
                                UNTIL PaymentLine_lr.NEXT() = 0;

                            //IF PaymentLine_lr.COUNT =1 THEN
                            VALIDATE("ST Check No", lChecks."ST Check No");
                            // VALIDATE("Check No",lChecks."N°Chèque");
                            VALIDATE("External Document No.", "ST Check No");
                            lCheckReference."ST Last No. Used" := lChecks."ST Check No";
                            lCheckReference.MODIFY();
                            lCheckReference."ST Last Date Used" := TODAY;
                            lCheckReference.MODIFY();
                        END;
                    END;
                END;
                //<<DELTA 21
            end;

            trigger OnValidate()
            var
                PaymentHeader_lr: Record "Payment Header";
                "Listréférencechèques_lf": Page "ST Référence chèque";
                "RéférenceChèques_lr": Record "ST Référence chèque";
                Text0010: Label 'Référence chéque non valide';
                Text0011: Label 'Veuillez choisir le N° compte';
                "Chèquemouvementé_lr": Record "ST chéque";
                PaymentLine_lr: Record "Payment Line";
                Text0012: Label 'Vous devez choisir le N° Compte ';
            begin
                //>>DELTA 21
                IF (Rec."ST Réference chéque" <> xRec."ST Réference chéque") AND (Rec."ST Check No" <> '') THEN
                    ERROR(Text0013);
                //>>DELTA 21
            end;
        }
        field(70036; "Numéro CIN"; code[10])
        {
            Caption = 'Numéro CIN';
            DataClassification = ToBeClassified;
            CharAllowed = '09';
            trigger OnValidate()
            var
                PaymentLedgerSetup: Record "General Ledger Setup";
                Text004: Label 'Le nombre de caractères saisis diffèrent de %1 caractère';
            begin
                PaymentLedgerSetup.Get();
                If StrLen("Numéro CIN") <> PaymentLedgerSetup."Nombre caractères CIN" then
                    Error(Text004, PaymentLedgerSetup."Nombre caractères CIN");
            end;
        }
        field(70037; "Date CIN"; Date)
        {
            Caption = 'Date CIN';
            DataClassification = ToBeClassified;
        }

        field(70029; "Applies-to Invoices Nos."; Code[1024])
        {
            Caption = 'N° factures lettrage';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70030; STType_ED; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Encaissement,Décaissement';
            OptionMembers = Encaissement,"Décaissement";
            Caption = 'Type_ED';
        }
        modify(Posted)
        {
            Caption = 'comptabilisé';
        }
        field(70031; STCodeSituationPaiement; Code[20])
        {
            Caption = 'Code situation paiement';
            Editable = false;
            TableRelation = STSituationPaiement.Code;
        }
        field(70032; STSituationPaiement; Text[50])
        {
            Caption = 'Situation Paiement';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(STSituationPaiement.Description WHERE(Code = FIELD(STCodeSituationPaiement)));
        }

        field(70038; STCertifAval; Boolean)
        {
            Caption = 'Certifié/Avalisé';
        }
        field(70040; "Banque Societe"; Text[50])
        {
            Caption = 'Banque Société';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Header"."Account No." where("No." = field("No."), "Account Type" = filter('Bank Account')));

        }

        field(70041; "STCréer par"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Créer par';
            Editable = false;

        }

        field(70042; "STSlip Origin No."; Code[20])
        {
            Caption = 'Bordereau origine';
            Editable = false;
        }

        field(70043; "STSlip Origin line No."; Integer)
        {
            Caption = 'N° ligne bordereau origine';
            Editable = false;
        }


        field(70051; "STMontant Commission"; Decimal)
        {
            Caption = 'Montant Commission';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant Commission" < 0)) OR ((Amount < 0) AND ("stMontant Commission" > 0)))
 AND ("Account Type" = "Account Type"::Vendor) THEN
                    "stMontant Commission" := -"stMontant Commission"
                ELSE
                    IF (((Amount > 0) AND ("stMontant Commission" > 0)) OR ((Amount < 0) AND ("stMontant Commission" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "stMontant Commission" := -"stMontant Commission";

                "STMontant TVA Commission" := 0;
                "STMontant TVA Commission DS" := 0;
            end;
        }

        field(70052; "STMontant Commission DS"; Decimal)
        {
            Caption = 'Montant Commission DS';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant Commission DS" < 0)) OR ((Amount < 0) AND ("STMontant Commission DS" > 0)))
  AND ("Account Type" = "Account Type"::Vendor) THEN
                    "STMontant Commission DS" := -"STMontant Commission DS"
                ELSE
                    IF (((Amount > 0) AND ("STMontant Commission DS" > 0)) OR ((Amount < 0) AND ("STMontant Commission DS" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "STMontant Commission DS" := -"STMontant Commission DS";

                "STMontant TVA Commission" := 0;
                "STMontant TVA Commission DS" := 0;
            end;
        }

        field(70053; "STMontant TVA Commission"; Decimal)
        {
            Caption = 'Montant TVA Commission';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant TVA Commission" < 0)) OR ((Amount < 0) AND ("STMontant TVA Commission" > 0)))
                AND ("Account Type" = "Account Type"::Vendor) THEN
                    "STMontant TVA Commission" := -"STMontant TVA Commission"
                ELSE
                    IF (((Amount > 0) AND ("STMontant TVA Commission" > 0)) OR ((Amount < 0) AND ("STMontant TVA Commission" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "STMontant TVA Commission" := -"STMontant TVA Commission";

            end;
        }
        field(70054; "STMontant TVA Commission DS"; Decimal)
        {
            Caption = 'Montant TVA sur Commission DS';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant TVA Commission DS" < 0)) OR ((Amount < 0) AND ("STMontant TVA Commission DS" > 0)))
                 AND ("Account Type" = "Account Type"::Vendor) THEN
                    "STMontant TVA Commission DS" := -"STMontant TVA Commission DS"
                ELSE
                    IF (((Amount > 0) AND ("STMontant TVA Commission DS" > 0)) OR ((Amount < 0) AND ("STMontant TVA Commission DS" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "STMontant TVA Commission DS" := -"STMontant TVA Commission DS";

            end;
        }

        field(70055; "STMontant Interret"; Decimal)
        {
            Caption = 'Montant Interrêt';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant Interret" < 0)) OR ((Amount < 0) AND ("STMontant Interret" > 0)))
                AND ("Account Type" = "Account Type"::Vendor) THEN
                    "STMontant Interret" := -"STMontant Interret"
                ELSE
                    IF (((Amount > 0) AND ("STMontant Interret" > 0)) OR ((Amount < 0) AND ("STMontant Interret" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "STMontant Interret" := -"STMontant Interret";


            end;
        }
        field(70056; "STMontant Interret DS"; Decimal)
        {
            Caption = 'Montant Interrêt DS';
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                IF (((Amount > 0) AND ("STMontant Interret DS" < 0)) OR ((Amount < 0) AND ("STMontant Interret DS" > 0)))
              AND ("Account Type" = "Account Type"::Vendor) THEN
                    "STMontant Interret DS" := -"STMontant Interret DS"
                ELSE
                    IF (((Amount > 0) AND ("STMontant Interret DS" > 0)) OR ((Amount < 0) AND ("STMontant Interret DS" < 0)))
                      AND ("Account Type" = "Account Type"::Customer) THEN
                        "STMontant Interret DS" := -"STMontant Interret DS";


            end;
        }

        field(70057; "ST LC confirmed"; Boolean)
        {
            CaptionML = ENU = 'LC Confirmed', FRA = 'LC confirmé';
        }
        field(70058; "ST REG Debit Filter"; CODE[20])
        {
            Caption = 'REG Debit filtre';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(70059; "ST REG Debit"; Decimal)
        {

            CaptionML = ENU = 'Debit Settlement Account', FRA = 'Réglement Débit/Compte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = FIELD("ST REG Debit Filter"),

                                                                  "Account Type" = const(Vendor),
                                                                 "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                  "Copied To No." = const('')));

        }

        field(70060; "ST FED progress Filter"; code[20])
        {
            Caption = 'FED In Progress Filter';
            Editable = false;
            FieldClass = FlowFilter;

        }
        field(70061; "ST FED progress"; Decimal)
        {

            Caption = 'FED In Progress';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST FED progress Filter"),
                                                                  "Account Type" = const(Vendor),
                                                                  "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                   "Copied To No." = const('')));
        }

        field(70062; "ST FED Accepted filter"; CODE[20])
        {
            Caption = 'FED Accepted Filtre';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70063; "ST FED Accepted"; Decimal)
        {

            Caption = 'FED Accepted';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST FED Accepted filter"),

                                                                  "Account Type" = const(Vendor),
                                                                  "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                         "Copied To No." = const('')));
        }

        field(70064; "ST FED Regle filter"; CODE[20])
        {
            CaptionML = ENU = 'FED Regle Filter', FRA = 'FED Reglé filtre';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70065; "ST FED regle"; Decimal)
        {

            Caption = 'FED Reglé';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST FED Regle filter"),

                                                                  "Account Type" = const(Vendor),
                                                                  "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                         "Copied To No." = const('')));
        }


        field(70066; "ST Prorogation 1 filter"; CODE[20])
        {
            Caption = 'Prorogation 1 Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70067; "ST Prorogation 2 filter"; CODE[20])
        {
            Caption = 'Prorogation 2 Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70068; "ST Prorogation 3 filter"; CODE[20])
        {
            Caption = 'Prorogation 3 Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70069; "ST Prorogation 1"; Decimal)
        {

            Caption = 'Prorogation 1';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST Prorogation 1 filter"),

                                                                  "Account Type" = const(Vendor),
                                                                   "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                     "Copied To No." = const('')));
        }
        field(70070; "ST Prorogation 2"; Decimal)
        {

            Caption = 'Prorogation 2';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST Prorogation 2 filter"),

                                                                  "Account Type" = const(Vendor),
                                                                   "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                     "Copied To No." = const('')));
        }
        field(70071; "ST Prorogation 3"; Decimal)
        {

            Caption = 'Prorogation 3';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field("ST Prorogation 3 filter"),

                                                                  "Account Type" = const(Vendor),
                                                                  "STSlip Origin No." = field("No."),
                                                                  "STSlip Origin line No." = field("Line No."),
                                                                  "Copied To No." = const('')));
        }









        field(70072; "ST LC validity date"; Date)
        {
            Caption = 'Validity Date';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Header"."ST LC validity date" where("No." = field("No.")));

        }
        field(70073; "ST LC shipping date"; Date)
        {
            CaptionML = ENU = 'LC Shipping Date', FRA = 'Date Ultime Expédition';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Header"."ST LC shipping date" where("No." = field("No.")));

        }


        field(70074; "ST Cours"; Decimal)
        {
            Caption = 'Rate';
            DecimalPlaces = 1 : 6;
            Editable = True;

            trigger OnValidate()
            begin
                TestField("ST Cours");
            end;
        }

        field(70075; "ST Date AT"; Date)
        {
            Caption = 'AT Date';
            Editable = True;
        }

        field(70076; "ST Prorog"; CODE[20])
        {
            Caption = 'Prorogation';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(70077; "ST date Prorogation"; date)
        {

            Caption = 'Prorogation Date';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Line"."Due Date" where(STCodeSituationPaiement = field("ST Prorog"),
                                                                  "Account Type" = const(Vendor),
                                                                   "STSlip Origin No." = field("No."),
                                                                    "STSlip Origin line No." = field("Line No."),
                                                                     "Copied To No." = const('')));
        }
        field(70078; "ST FED currency"; Decimal)
        {

            Caption = 'Cours de devise FED';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = lookup("Payment Line"."Currency Factor" where(STCodeSituationPaiement = field("ST Prorog"),
                                                                  "Account Type" = const(Vendor),
                                                                   "STSlip Origin No." = field("No."),
                                                                    "STSlip Origin line No." = field("Line No."),
                                                                     "Copied To No." = const('')));
        }






    }

    trigger OnInsert()
    var
        statement: record "Payment Header";
        Currency: record Currency;
    begin
        //<< DELTA 01 RAD 05/12/2014
        Statement.GET(Rec."No.");
        rec.STCoffre := Statement.STCoffre;
        IF "STCoffre Origine" = '' THEN
            rec."STCoffre Origine" := Statement.STCoffre;
        "STType Règlement" := Statement."STType Règlement";
        "Payment Class" := Statement."Payment Class";
        "STType_ED" := statement.Type_ED;
        //   "Banque Societe" := statement."Account No.";
        "STCréer par" := statement."STCréer par";
        //<< DELTA 01 RAD 05/12/2014
        IF "Currency Code" <> '' THEN
            Currency.GET("Currency Code");

        //add controle date echeance doit être sup ou = ala date de compta si statut ligne siaise
        IF "Status No." = 0 THEN
            IF ("Due Date" < "Posting Date") AND ("Due Date" <> 0D) THEN ERROR('Date echéance erronée');
        //>> End DELTA 01

    end;

    trigger OnDelete()
    var
        Text001: Label 'Vous ne pouvez pas supprimer cette ligne de paiement.';
        lPaymentStep: Record "Payment Step";
        lPaymentLine: record "Payment Line";
        GeneralLedgerSetup: record "General Ledger Setup";
        lPaymentHeader: Record "Payment Header";
        lChecks: Record "ST chéque";
    begin
        // IF (Posted = TRUE) OR ("Status No." > 0) THEN
        //     ERROR(Text001);
        IF (Posted = TRUE) THEN
            ERROR(Text001);
        GeneralLedgerSetup.get();
        lPaymentStep.RESET();
        lPaymentStep.SETRANGE("Payment Class", Rec."Payment Class");
        lPaymentStep.SETRANGE("Next Status", Rec."Status No.");
        IF lPaymentStep.FINDSET() THEN
            if not (GeneralLedgerSetup."Delete Autorised Payment") then
                IF ("Status No." > 0) AND (lPaymentStep."Action Type" <> lPaymentStep."Action Type"::"Create New Document") THEN
                    ERROR(Text001);

        IF (lPaymentStep."Action Type" = lPaymentStep."Action Type"::"Create New Document") THEN BEGIN
            lPaymentLine.RESET();
            lPaymentLine.SETRANGE("Copied To No.", "No.");
            lPaymentLine.SETRANGE("Copied To Line", "Line No.");
            lPaymentLine.SETRANGE("Document No.", Rec."Document No.");
            IF lPaymentLine.FINDSET() THEN BEGIN
                lPaymentLine."Copied To No." := '';
                lPaymentLine."Copied To Line" := 0;
                lPaymentLine.MODIFY();
            END;
        END;
        IF Rec."ST Check No" <> '' THEN BEGIN
            IF lPaymentHeader.GET(Rec."No.") THEN
                IF lChecks.GET(lPaymentHeader."Account No.", Rec."ST Réference chéque", Rec."ST Check No") THEN BEGIN
                    lChecks."ST Status" := lChecks."ST Status"::New;
                    lChecks."ST Payment Slip No." := '';
                    lChecks."ST Line Payment Slip No" := 0;
                    lChecks."ST Account Type" := '';
                    lChecks."ST Amount line" := 0;
                    lChecks.MODIFY();
                END;
        END;


    end;


    procedure STGetCurrency()
    var
        Header: Record "Payment Header";
    begin
        Header.Get("No.");
        if Header."Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision();
        end else
            Currency.Get(Header."Currency Code");
    end;

    procedure FractionnerLine()
    var
        RecT: Record "Payment Line";
        Wind: Dialog;
        Montantsdef: Decimal;
        RecTmp: Record "Payment Line";
        Mntinit: Decimal;
        MntinitDS: Decimal;
        RecPaymLine: Record "Payment Line";
        PagMontantDef2: Page "ST MontantDef";
    begin

        IF NOT (("Copied To No." = '') AND ("Copied To Line" = 0)) THEN
            EXIT;

        Montantsdef := 0;

        IF NOT CONFIRM(STRSUBSTNO('Vous allez fractionné la ligne %1  %2  %3', "Line No.", "Account No.", Amount), FALSE, TRUE) THEN
            EXIT;

        Wind.OPEN('Montant a fractionner #1############## ');
        //Wind.INPUT(1,Montantdef);

        //>> Code ki remplace la methode obselète input.
        //*création d'une page avec action OK
        //*une page qui retourne la variable saisie par l'utilisateur avec une fct "ReturnValue"
        CLEAR(PagMontantDef2);
        IF PagMontantDef2.RUNMODAL() = ACTION::OK THEN
            //MESSAGE(FORMAT(PagMontantDef2.ReturnValue));
            Montantsdef := PagMontantDef2.ReturnValue();
        //<<

        IF Montantsdef = 0 THEN
            EXIT;

        CLEAR(RecTmp);
        RecTmp.RESET();
        RecTmp.SETFILTER("No.", '=%1', "No.");
        RecT := Rec;
        RecTmp.SETFILTER("Line No.", '%1..', "Line No." + 1);
        IF RecTmp.FIND('-') THEN
            RecT."Line No." := ROUND(("Line No." + ((RecTmp."Line No." - "Line No.") / 2)), 1, '=')   //hejer 15/06/2012
                                                                                                      //RecT."Line No.":= "Line No."+((RecTmp."Line No."-"Line No.")/2)
        ELSE
            RecT."Line No." := "Line No." + 10000;
        IF Amount > 0 THEN
            RecT.VALIDATE(Amount, Montantsdef)
        ELSE
            RecT.VALIDATE(Amount, -Montantsdef);
        RecT."STMontant Initial" := RecT.Amount;
        RecT."STMontant Initial DS" := RecT."Amount (LCY)";
        RecT."STMontant Retenue" := 0;
        RecT."STMontant Retenue Validé" := 0;
        RecT."STMontant Retenue DS" := 0;
        RecT."STMontant Retenue Validé DS" := 0;

        IF RecT.INSERT() THEN BEGIN
            Mntinit := "STMontant Initial";
            MntinitDS := "STMontant Initial DS";
            IF Amount > 0 THEN
                VALIDATE(Amount, Amount - Montantsdef)
            ELSE
                VALIDATE(Amount, Amount + Montantsdef);
            "STMontant Initial" := Mntinit - RecT.Amount;
            "STMontant Initial DS" := MntinitDS - RecT."Amount (LCY)";
            MODIFY();
        END;
    end;

    procedure CalcAmount()
    var
        MntRGart: Decimal;
        Custledger: Record "Cust. Ledger Entry";
        MntRet: Decimal;
        MntRetenu: Decimal;
        MntTva: Decimal;
        MntComm: Decimal;
        MntTvaComm: Decimal;
        RecGGLAccount: Record "G/L Account";
        RecGEmployee: Record Employee;
        RecGBankAccount: Record "Bank Account";
        RecGGLSetup: Record "General Ledger Setup";
        RecGItemCharge: Record "Item Charge";
        RecGCurrency: Record Currency;
        RecGPaymentStatus: Record "Payment Status";
        RecGGeneralLedgerSetup: Record "General Ledger Setup";
        RecGPaymentStatus1: Record "Payment Status";
        RecGCustomer: Record Customer;
        RecGVendor: Record Vendor;
        RecGCurrency1: Record Currency;
        RecGPaymentStepLedger: Record "Payment Step Ledger";
        RecGCurrencyExchangeRate: Record "Currency Exchange Rate";

    begin
        CLEAR(RecGPaymentStatus1);
        RecGPaymentStatus1.RESET();
        MntRetenu := 0;
        MntRGart := 0;
        MntRet := 0;
        MntTva := 0;
        MntComm := 0;
        MntTvaComm := 0;
        IF RecGPaymentStatus1.GET("Payment Class", "Status No.") THEN;
        // Retenu sur TVA
        CLEAR(RecGGeneralLedgerSetup);
        RecGGeneralLedgerSetup.RESET();
        RecGGeneralLedgerSetup.GET();
        CLEAR(RecGCurrency1);
        RecGCurrency1.RESET();



        IF RecGPaymentStatus1."STCalculer retenue a la source" THEN
            MntRetenu := "STMontant Retenue";

        VALIDATE(Amount, "STMontant Initial" + (MntRetenu + MntTva));

    end;

    procedure UpdateFactor()
    var
        RecGCurrencyExchangeRate: Record "Currency Exchange Rate";
    begin

        IF ("Copied To No." = '') AND ("Copied To Line" = 0) THEN BEGIN
            "Amount (LCY)" := RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", Amount, "Currency Factor");
            "STMontant Retenue DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "STMontant Retenue", "Currency Factor");

            "STMontant Retenue Validé DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "STMontant Retenue Validé", "Currency Factor");

            "STMontant Initial DS" :=
            RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "STMontant Initial", "Currency Factor");

            MODIFY();
        END;
    end;

    procedure CalcRetenu()
    var
        GroupeRetenu: Record "ST Groupe retenue";
        StepT: Record "Payment Step Ledger";
        RecGPaymentStatus1: Record "Payment Status";
        RecGCustomer: Record Customer;
        RecGVendor: Record Vendor;
        RecGGeneralLedgerSetup: Record "General Ledger Setup";
        RecGCurrency1: Record Currency;
        RecGPaymentStepLedger: Record "Payment Step Ledger";
        "VarD%Retenue": Decimal;
        RecGPaymentStatus: Record "Payment Status";
        lStepT: Record "Payment Step Ledger";
        RecGCurrencyExchangeRate: Record "Currency Exchange Rate";
    begin

        CLEAR(RecGPaymentStatus1);
        RecGPaymentStatus1.RESET();
        CLEAR(RecGCustomer);
        RecGCustomer.RESET();
        CLEAR(RecGVendor);
        RecGVendor.RESET();
        CLEAR(RecGGeneralLedgerSetup);
        RecGGeneralLedgerSetup.RESET();
        RecGGeneralLedgerSetup.GET();
        CLEAR(RecGCurrency1);
        RecGCurrency1.RESET();
        IF "Currency Code" <> '' THEN RecGCurrency1.GET("Currency Code");

        CLEAR(lStepT);
        lStepT.RESET();
        lStepT.SETFILTER("Payment Class", "Payment Class");
        lStepT.SETRANGE("STInclure Commission", TRUE);
        lStepT.SETFILTER(StPerTVA, '<>0');
        IF (lStepT.FINDFIRST()) AND (("STMontant TVA Commission" = 0) AND ("STMontant TVA Commission DS" = 0)) THEN
            IF "stMontant Commission DS" <> 0 THEN BEGIN
                "STMontant TVA Commission DS" := ROUND("STMontant Commission DS" * lStepT."StPerTVA" / 100, RecGGeneralLedgerSetup."Amount Rounding Precision");
                "STMontant Commission DS" := "STMontant Commission DS" - "STMontant TVA Commission DS";
            END ELSE
                IF "STMontant Commission" <> 0 THEN BEGIN
                    IF "Currency Code" <> '' THEN
                        "STMontant TVA Commission" := ROUND("STMontant Commission" * lStepT."StPerTVA" / 100, RecGCurrency1."Amount Rounding Precision")
                    ELSE
                        "STMontant TVA Commission" := ROUND("STMontant Commission" * lStepT."StPerTVA" / 100, RecGGeneralLedgerSetup."Amount Rounding Precision");

                    "STMontant Commission" := "STMontant Commission" - "STMontant TVA Commission";
                END;

        CLEAR(RecGPaymentStepLedger);
        RecGPaymentStepLedger.RESET();
        RecGPaymentStepLedger.SETFILTER("Payment Class", "Payment Class");

        "VarD%Retenue" := 0;
        CLEAR(GroupeRetenu);
        GroupeRetenu.RESET();
        IF GroupeRetenu.GET(0, "STCode Retenue à la Source") THEN;
        "VarD%Retenue" := GroupeRetenu."ST% Retenue";
        IF "STMontant Retenue DS" = 0 THEN
            "STMontant Retenue DS" := -ROUND("STMontant Initial DS" * ("VarD%Retenue" / 100),
            RecGGeneralLedgerSetup."Amount Rounding Precision");

        IF RecGPaymentStatus1.GET("Payment Class", "Status No.") THEN
            IF /*("Montant Retenue" = 0) AND*/ ("STMontant Retenue Validé" = 0) AND (RecGPaymentStatus1."STCalculer retenue a la source") THEN BEGIN
                "VarD%Retenue" := GroupeRetenu."ST% Retenue";
                IF "Currency Code" <> '' THEN BEGIN
                    "STMontant Retenue" := -ROUND("STAssiette RS" * ("VarD%Retenue" / 100), RecGCurrency1."Amount Rounding Precision");
                    "STMontant Retenue DS" := -ROUND(RecGCurrencyExchangeRate.ExchangeAmtFCYToLCY("Posting Date", "Currency Code", "STAssiette RS" * ("VarD%Retenue" / 100), "Currency Factor"), RecGGeneralLedgerSetup."Amount Rounding Precision")
                END
                ELSE begin
                    "STMontant Retenue" := -ROUND("STAssiette RS" * ("VarD%Retenue" / 100), RecGGeneralLedgerSetup."Amount Rounding Precision");
                    "STMontant Retenue DS" := "STMontant Retenue";
                END;
                CalcAmount();
                //VALIDATE(Amount,"Montant Initial"+"Montant Retenu"+"Montant Retenu TVA");
            END;

    end;

    var
        Text0013: Label 'Please Empty the Check No. Field';
        RecPaymentHeader: Record "Payment Header";
        Currency: Record Currency;



}