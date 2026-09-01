tableextension 71001 "Payment Step Ledger fr" extends "Payment Step Ledger fr" //10841
{
    fields
    {
        field(70000; "STCompta. Retenue à la source"; Boolean)
        {
            CaptionML = FRA = 'Compta. Retenue à la source';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Step1: record "Payment Step FR";
                Step2: record "Payment Step FR";
            begin
                CLEAR(PaymentStepLedger);
                PaymentStepLedger.RESET();
                PaymentStepLedger.SETCURRENTKEY("Payment Class", "STCompta. Retenue à la source", Line);
                PaymentStepLedger.SETFILTER("Payment Class", "Payment Class");
                PaymentStepLedger.SETRANGE("STCompta. Retenue à la source", TRUE);
                CLEAR(Step1);
                CLEAR(Step2);
                Step1.GET("Payment Class", Line);

                IF "STCompta. Retenue à la source" THEN
                    IF PaymentStepLedger.FIND('-') AND ((PaymentStepLedger.Line <> Line) OR (PaymentStepLedger.Sign <> Sign)) THEN BEGIN
                        Step2.GET("Payment Class", Line);
                        IF Step1."Previous Status" <> Step2."Previous Status" THEN
                            ERROR(Error001);
                    END;
                IF NOT "STCompta. Retenue à la source" THEN
                    "STCompte Retenue à la source" := '';
            end;
        }
        field(70001; "STCompte Retenue à la source"; Code[20])
        {
            CaptionML = FRA = 'Compte Retenue à la source';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                IF NOT "STCompta. Retenue à la source" THEN
                    "STCompte Retenue à la source" := '';
            end;

        }
        field(70002; "STAnnuler Compta Retn. à la Sour"; Boolean)
        {
            CaptionML = FRA = 'Annuler Compta Retn. à la Source';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CLEAR(PaymentStepLedger);
                PaymentStepLedger.RESET();
                PaymentStepLedger.SETCURRENTKEY("Payment Class", "STAnnuler Compta Retn. à la Sour", Line);
                PaymentStepLedger.SETFILTER("Payment Class", "Payment Class");
                PaymentStepLedger.SETRANGE("STAnnuler Compta Retn. à la Sour", TRUE);
                IF "STCompta. Retenue à la source" THEN
                    IF PaymentStepLedger.FIND('-') AND ((PaymentStepLedger.Line <> Line) OR (PaymentStepLedger.Sign <> Sign)) THEN
                        ERROR(Error004);
                IF "STAnnuler Compta Retn. à la Sour" THEN
                    "STCompta. Retenue à la source" := FALSE;
            end;
        }

        field(70003; "STBlocage Frs Solde Debit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Blocage Fournisseur solde débit';
        }

        field(70050; "STInclure Commission"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Inclure Commission';
            trigger OnValidate()
            var
                lPayStepLedger: record "Payment Step Ledger FR";
            begin
                CLEAR(lPayStepLedger);
                lPayStepLedger.RESET();
                lPayStepLedger.SETFILTER("Payment Class", "Payment Class");
                lPayStepLedger.SETFILTER(Line, '%1', Line);
                lPayStepLedger.SETRANGE("STInclure Commission", TRUE);
                IF "STInclure Commission" THEN
                    IF lPayStepLedger.FIND('-') THEN
                        IF (lPayStepLedger.Sign <> Sign) THEN
                            ERROR(Error003)
                        ELSE BEGIN
                            "StCompte Commission" := '';
                            "StCompte TVA/Commission" := '';
                        END;

            end;
        }


        field(70051; "StCompte Commission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Commission';
            TableRelation = "G/L Account";


        }

        field(70052; "StCompte TVA/Commission"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte TVA/Commission';
            TableRelation = "G/L Account";

        }

        field(70053; "StPerTVA"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '% TVA';
            DecimalPlaces = 0 : 5;

        }

        field(70054; "StCompte Int"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte Interrêt';
            TableRelation = "G/L Account";

        }

        field(70055; "ST Account vendor LC"; Boolean)
        {
            caption = 'Account vendor LC';
            trigger onvalidate()
            begin
                if "ST Account vendor LC" then
                    IF NOT ("Accounting Type" IN ["Accounting Type"::"Header Payment Account",
                                                  "Accounting Type"::"Payment Line Account"]) then
                        error(ErrOR006);
            end;

        }
        modify("Accounting Type")
        {

            trigger OnAfterValidate()
            begin
                if ("Accounting Type" <> xrec."Accounting Type") then
                    "ST Account vendor LC" := false;
            end;

        }





    }
    var
        PaymentStepLedger: record "Payment Step Ledger FR";
        Error001: Label 'Vous avez déjà spécifié la Retenu à la Source !';
        Error002: Label 'Vous avez déjà spécifié la Retenu Sur T.V.A !';
        Error003: Label 'Vous avez déjà spécifié la Commission !';
        Error004: Label 'Vous avez déjà Annuler la Retenu à la Source !';
        Error005: Label 'Vous avez déjà spécifier la Retenu de Garantie !';
        ErrOR006: Label 'Type de comptabilisation doit être (Compte en-tête) ou (Compte ligne paiement)';
}