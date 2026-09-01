tableextension 71019 "ST PaymentHeaderTabExt" extends "Payment Header" //10865
{
    fields
    {
        modify("Status No.")
        {
            trigger OnAfterValidate()
            var
                PaymentStep: Record "Payment Step";
                PaymentStatus: Record "Payment Status";
                CompanyBank: Record "Bank Account";

            begin
                IF ("Account Type" = "Account Type"::"Bank Account") AND ("Account No." <> '') THEN BEGIN
                    CompanyBank.RESET();
                    if CompanyBank.GET("Account No.") then
                        "Source Code" := CompanyBank."STSource Code";

                END;
                PaymentStep.Reset();
                PaymentStep.SetRange("Payment Class", "Payment Class");
                PaymentStep.SetFilter("Next Status", '>%1', "Status No.");
                PaymentStep.SetRange("Action Type", PaymentStep."Action Type"::Ledger);
                if PaymentStep.FindFirst() then
                    If rec."Source Code" = '' then
                        rec."Source Code" := PaymentStep."Source Code";
            end;
        }
        field(70000; "STDate Création"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date création';
            Editable = false;
        }
        field(70001; "STCréer par"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Créer par';
            Editable = false;
        }
        field(70002; "STType Règlement"; Code[10]) //TODO:
        {
            DataClassification = ToBeClassified;
            Caption = 'Type règlement';
        }
        field(70003; STCoffre; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Coffre';
            TableRelation = "ST Coffre";

            trigger OnValidate()
            var
                PayStat: Record "Payment Status";
            begin
                //<< DELTA 01 RAD 05/12/2014
                IF STCoffre <> '' THEN
                    IF Rec.STCoffre <> xRec.STCoffre THEN BEGIN
                        CLEAR(PayStat);
                        PayStat.GET("Payment Class", "Status No.");
                        PayStat.TESTFIELD("STAutoriser Modifcation Entête");
                    END;

                //<< Mise à jours des lignes
                PaymentLigne.RESET();
                PaymentLigne.SETRANGE(PaymentLigne."No.", "No.");
                IF NOT PaymentLigne.ISEMPTY THEN
                    PaymentLigne.ModifyAll(PaymentLigne.STCoffre, STCoffre);
                //>> End Mise à jours des lignes
            end;
        }

        field(70004; STAgence; Code[10])

        {
            caption = 'Agence';
        }
        field(70005; Type_ED; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'DELTA STD 01';
            OptionCaption = 'Encaissement,Décaissement';
            OptionMembers = Encaissement,"Décaissement";
        }
        field(70007; "STType paiement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'DELTA STD 01';
            Editable = true;
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;

            trigger OnValidate()
            var
                PayLine: Record "Payment Line";
            begin
                //<< DELTA 01 RAD 05/12/2014
                PayLine.SETRANGE("No.", "No.");
                IF PayLine.FINDFIRST() THEN
                    REPEAT
                        PayLine."STType paiement" := PayLine."STType paiement"::Avance;
                    UNTIL PayLine.NEXT() = 0;

                //>>End DELTA 01
            end;
        }
        field(70008; STCodeSituationPaiement; Code[20])
        {
            Caption = 'Code situation paiement';
            Editable = false;
            TableRelation = STSituationPaiement.Code;
            trigger OnValidate()
            var
                LRecPaymentLine: Record "Payment Line";
            begin
                lrecPaymentLine.SetRange("No.", "No.");
                lrecPaymentLine.ModifyAll(STCodeSituationPaiement, STCodeSituationPaiement);
            end;
        }
        field(70009; STSituationPaiement; Text[50])
        {
            Caption = 'Situation Paiement';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(STSituationPaiement.Description WHERE(Code = FIELD(STCodeSituationPaiement)));
        }

        field(70010; "STbank slip"; code[20])
        {
            Caption = 'N° Bordereau banque';
        }
        field(70011; "STreason code"; code[10])
        {
            Caption = 'Code motif';
            DataClassification = ToBeClassified;
            //tableRelation = "Reason Code" where("ST payment slip" = filter(true));
            trigger OnValidate()
            var
                "lReasonCode": Record "Reason Code";
            begin
                if "STreason code" <> '' then
                    if "lReasonCode".Get("STreason code") then
                        "lReasonCode".TestField("ST payment slip");

            end;

            trigger OnLookup()
            var
                "lReasonCode": Record "Reason Code";
                "ReasonCodes": page "Reason Codes";
            begin
                lReasonCode.RESET();
                lReasonCode.SETRANGE("ST payment slip", true);
                CLEAR("ReasonCodes");
                "ReasonCodes".SETTABLEVIEW(lReasonCode);
                "ReasonCodes".LOOKUPMODE := TRUE;
                "ReasonCodes".EDITABLE := FALSE;

                IF "ReasonCodes".RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    "ReasonCodes".GETRECORD(lReasonCode);
                    Validate("STreason code", lReasonCode.Code);
                end;

            end;
        }
        field(70012; "ST LC shipping date"; Date)
        {
            CaptionML = ENU = 'LC Latest Shipping Date', FRA = 'Date ultime d''expédition LC';
            DataClassification = ToBeClassified;
        }
        field(70013; "ST LC validity date"; Date)
        {
            CaptionML = ENU = 'LC Validity Date', FRA = 'Date validité LC';
            DataClassification = ToBeClassified;
        }
        field(70014; "ST Opninig Deadline"; Date)
        {
            Caption = 'Date limite d''ouverture';
            DataClassification = ToBeClassified;
        }
        field(70015; "ST Import Title Reference"; code[20])
        {
            Caption = 'Réference titre d''import';
            DataClassification = ToBeClassified;
        }
        field(70016; "ST Import Title Date"; Date)
        {
            Caption = 'Date titre d''import';
            DataClassification = ToBeClassified;
        }
        field(70017; "ST Opninig Fees"; Decimal)
        {
            Caption = 'Commissions ouverture';
            DataClassification = ToBeClassified;
        }
        field(70018; "ST Change Fees"; Decimal)
        {
            Caption = 'Commissions modifications';
            DataClassification = ToBeClassified;
        }
        field(70019; "ST Realization Fees"; Decimal)
        {
            Caption = 'Commissions réalisation';
            DataClassification = ToBeClassified;
        }
        field(70020; "ST Deffered Payment Fees"; Decimal)
        {
            Caption = 'Commissions paiement différé';
            DataClassification = ToBeClassified;
        }
        field(70021; STType_Reg; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type règlements';
            OptionMembers = " ","Chèque",Traite,Virement,"Espèce",LettreC,Autre,TPE,RS;
        }

    }





    trigger OnInsert()

    begin


        // //<<DELTA 01
        STInitHeader();
        // //<< DELTA 01 

    end;

    var
        Text001: Label 'There is no line to treat.';

        usersetup: Record "User Setup";
        PaymentLigne: Record "Payment Line";
        Process: Record "Payment Class";
        IsChechVisible: Boolean;

    procedure STTestNbOfLines()
    begin
        CalcFields("No. of Lines");
        if "No. of Lines" = 0 then
            Error(Text001);
    end;

    procedure STInitHeader()
    begin
        "Posting Date" := WORKDATE();
        "Document Date" := WORKDATE();

        VALIDATE("Account Type", "Account Type"::"Bank Account");
        Process.Get("Payment Class");
        Type_ED := Process.STType_ED;
        "STType Règlement" := format(Process.STType_Reg);
        IF usersetup.GET(USERID) THEN
            STCoffre := usersetup.STCoffre;

        "STDate Création" := CURRENTDATETIME;
        "STCréer par" := USERID;
        // Modify();
    end;

    procedure STInitHeader2()
    var
        PaymentLine: Record "Payment Line";
        PaymentHeader: Record "Payment Header";

    begin
        "Posting Date" := WORKDATE();
        "Document Date" := WORKDATE();
        VALIDATE("Account Type", "Account Type"::"Bank Account");
        Process.Get("Payment Class");
        Type_ED := Process.STType_ED;
        "STType Règlement" := format(Process.STType_Reg);

        IF usersetup.GET(USERID) THEN
            STCoffre := usersetup.STCoffre;

        "STDate Création" := CURRENTDATETIME;
        "STCréer par" := USERID;
        Modify();
    end;



}

