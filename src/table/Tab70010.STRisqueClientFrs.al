table 70010 "STRisqueClientFRs"
{
    Caption = 'RisqueClientFRs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; enum STTypeRisqueCltFRs)
        {
            Caption = 'Type';
            Editable = false;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'N°';
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = if (Type = const(Customer)) Customer."No."
            else
            if (Type = const(Vendor)) Vendor."No.";
        }
        field(3; CltChequeEnCoffreFilter; Text[50])
        {
            Caption = 'FiltreChequeEnCoffre';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(4; CltChequeEnCoffreMnt; Decimal)
        {
            Caption = 'Chèque en coffre';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEnCoffreFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                   "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(5; CltChequeImpayeFilter; Text[50])
        {
            Caption = 'FiltreChequeImpaye';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(6; CltChequeImpayeMnt; Decimal)
        {
            Caption = 'Chèque Impayé';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                   "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(7; CltChequeContentieuxFilter; Text[50])
        {
            Caption = 'FiltreChequeContentieux';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(8; CltChequeContentieuxMnt; Decimal)
        {
            Caption = 'Chèque Contentieux';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeContentieuxFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),

                                                                    "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(9; CltChequeEncVersFilter; Text[50])
        {
            Caption = 'FiltreChequeEncVers';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(10; CltChequeEncVersMnt; Decimal)
        {
            Caption = 'Chèque Encours Versement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEncVersFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                   "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }

        field(11; CltHistChequeImpayeMnt; Decimal)
        {
            Caption = 'Historique Chèque Impayé';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                   "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = filter(<> '')));
        }
        field(12; CltTraiteEnCoffreFilter; Text[50])
        {
            Caption = 'FiltreTraiteEnCoffre';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(13; CltTraiteEnCoffreMnt; Decimal)
        {
            Caption = 'Traite en coffre';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEnCoffreFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                   "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(14; CltTraiteRemisEncFilter; Text[50])
        {
            Caption = 'FiltreTraiteRemisEnc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(15; CltTraiteRemisEncMnt; Decimal)
        {
            Caption = 'Traite remise à l''encaissement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteRemisEncFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                              "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(16; CltTraiteEncoursEncFilter; Text[50])
        {
            Caption = 'FiltreTraiteEncoursEnc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(17; CltTraiteEncoursEncMnt; Decimal)
        {
            Caption = 'Traite encours d''encaissement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEncoursEncFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(18; CltTraiteRemisEscFilter; Text[50])
        {
            Caption = 'FiltreTraiteRemisEsc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(19; CltTraiteRemisEscMnt; Decimal)
        {
            Caption = 'Traite remise à l''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteRemisEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(20; CltTraiteEncoursEscFilter; Text[50])
        {
            Caption = 'FiltreTraiteEncoursEsc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; CltTraiteEncoursEscMnt; Decimal)
        {
            Caption = 'Traite encours d''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEncoursEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(22; CltTraiteImpayeFilter; Text[50])
        {
            Caption = 'FiltreTraiteImpaye';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(23; CltTraiteImpayeMnt; Decimal)
        {
            Caption = 'Traite impayée';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(24; CltTraiteContentieuxFilter; Text[50])
        {
            Caption = 'FiltreTraiteContentieux';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(25; CltTraiteContentieuxMnt; Decimal)
        {
            Caption = 'Traite contentieux';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteContentieuxFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(26; CltHistTraiteImpMnt; Decimal)
        {
            Caption = 'Historique Traite impayée';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteImpayeFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = filter(<> '')));
        }
        field(27; FrsTraiteRemiseFilter; Text[50])
        {
            Caption = 'FrsTraiteRemiseFilter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(28; FrsTraiteRemiseMnt; Decimal)
        {
            Caption = 'Traite remise';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(FrsTraiteRemiseFilter),
                                                                  "Account Type" = const(Vendor),
                                                                  "Account No." = field(Code),
                                                                  "Copied To No." = const('')));
        }
        field(29; FrsChequeEncoursFilter; Text[50])
        {
            Caption = 'FrsChequeEncoursFilter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(30; FrsChequeEncoursMnt; Decimal)
        {
            Caption = 'Chèque encours';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(FrsChequeEncoursFilter),
                                                                  "Account Type" = const(Vendor),
                                                                  "Account No." = field(Code),
                                                                  "Copied To No." = const('')));
        }
        field(31; FrsTraiteEncoursFilter; Text[50])
        {
            Caption = 'FrsTraiteEncoursFilter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(32; FrsTraiteEncoursMnt; Decimal)
        {
            Caption = 'Traite encours';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(FrsTraiteEncoursFilter),
                                                                  "Account Type" = const(Vendor),
                                                                  "Account No." = field(Code),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(33; DateRefEscompteFilter; Date)
        {
            Caption = 'DateRefEscompteFilter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(34; CltTraiteRemiseEscNonEchueMnt; Decimal)
        {
            Caption = 'Traite remise à l''escompte non échue';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteRemisEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  "Copied To No." = const(''),
                                                                  "Due Date" = field(DateRefEscompteFilter)));
        }
        field(35; "DLT Customer G/L Amount"; Decimal)
        {
            Caption = 'Montant comptes généraux associés client';
            FieldClass = FlowField;
            Editable = false;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("DLT G/L Account Filter"), "Source Type" = filter(Customer), "Source No." = FIELD("code")));

        }
        field(36; "DLT G/L Account Filter"; text[500])
        {
            Caption = 'Filtre compte général';
            FieldClass = flowfilter;
        }
        field(37; "DLT Vendor G/L Amount"; Decimal)
        {
            Caption = 'Montant comptes généraux associés fournisseurs';
            FieldClass = FlowField;
            AutoFormatType = 1;
            Editable = false;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("DLT G/L Account Filter"), "Source Type" = filter(Vendor), "Source No." = FIELD("code")));

        }
        field(50; CltChequeCertifEnCoffreMnt; Decimal)
        {
            Caption = 'Chèque Certifié en coffre';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEnCoffreFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(51; CltChequeCertifEncVersMnt; Decimal)
        {
            Caption = 'Chèque Certifié Encours Versement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEncVersFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(52; CltTraiteAvalEnCoffreMnt; Decimal)
        {
            Caption = 'Traite avalisée en coffre';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEnCoffreFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(53; CltTraiteAvalRemisEncMnt; Decimal)
        {
            Caption = 'Traite avalisée remise à l''encaissement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteRemisEncFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(54; CltTraiteAvalEncoursEncMnt; Decimal)
        {
            Caption = 'Traite avalisée encours d''encaissement';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEncoursEncFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(55; CltTraiteAvalRemisEscMnt; Decimal)
        {
            Caption = 'Traite avalisée remise à l''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteRemisEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(56; CltTraiteAvalEncoursEscMnt; Decimal)
        {
            Caption = 'Traite avalisée encours d''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltTraiteEncoursEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }


        field(57; CltChequeRemisEscFilter; Text[50])
        {
            Caption = 'FiltreChequeRemisEsc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(58; CltChequeRemisEscMnt; Decimal)
        {
            Caption = 'Chèque remise à l''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeRemisEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(59; CltChequeCertifRemisEscMnt; Decimal)
        {
            Caption = 'Chèque Certifié remise à l''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeRemisEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(60; CltChequeEncoursEscFilter; Text[50])
        {
            Caption = 'FiltreChequeEncoursEsc';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(61; CltChequeEncoursEscMnt; Decimal)
        {
            Caption = 'Chèque encours d''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEncoursEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(false),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(62; CltChequeCertifEncoursEscMnt; Decimal)
        {
            Caption = 'Chèque encours d''escompte';
            Editable = False;
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where(STCodeSituationPaiement = field(CltChequeEncoursEscFilter),
                                                                  "Account Type" = const(Customer),
                                                                  "Account No." = field(Code),
                                                                  STCertifAval = const(true),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Copied To No." = const('')));
        }
        field(63; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }
    procedure GetMntChequeImpayer(PCodeClient: Code[20]): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        If LRecRisqueClientSetup.CltChequeImpaye <> '' then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeImpayeFilter, LRecRisqueClientSetup.CltChequeImpaye);
            LRecRisqueClient.CalcFields(CltChequeImpayeMnt);
            Mnt := LRecRisqueClient.CltChequeImpayeMnt;
        end;
        Exit(Mnt)
    end;

    procedure GetMntChequeContentieux(PCodeClient: Code[20]): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        If LRecRisqueClientSetup.CltChequeContentieux <> '' then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeContentieuxFilter, LRecRisqueClientSetup.CltChequeContentieux);
            LRecRisqueClient.CalcFields(CltChequeContentieuxMnt);
            Mnt := LRecRisqueClient.CltChequeContentieuxMnt;
        end;
        Exit(Mnt)
    end;

    procedure GetMntTraiteImpayer(PCodeClient: Code[20]): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        If LRecRisqueClientSetup.CltTraiteImpaye <> '' then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteImpayeFilter, LRecRisqueClientSetup.CltTraiteImpaye);
            LRecRisqueClient.CalcFields(CltTraiteImpayeMnt);
            Mnt := LRecRisqueClient.CltTraiteImpayeMnt;
        end;
        Exit(Mnt)
    end;

    procedure GetMntTraiteContentieux(PCodeClient: Code[20]): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        If LRecRisqueClientSetup.CltTraiteContentieux <> '' then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteContentieuxFilter, LRecRisqueClientSetup.CltTraiteContentieux);
            LRecRisqueClient.CalcFields(CltTraiteContentieuxMnt);
            Mnt := LRecRisqueClient.CltTraiteContentieuxMnt;
        end;
        Exit(Mnt)
    end;

    procedure GetMntEcoursPeriode(PCodeClient: Code[20]; FilterDate: Text): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        if (LRecRisqueClientSetup.CltChequeEncVersUsage) and (LRecRisqueClientSetup.CltChequeEncVers <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEncVersFilter, LRecRisqueClientSetup.CltChequeEncVers);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeEncVersMnt);
            Mnt += LRecRisqueClient.CltChequeEncVersMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeEnCoffreUsage) and (LRecRisqueClientSetup.CltChequeEnCoffre <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEnCoffreFilter, LRecRisqueClientSetup.CltChequeEnCoffre);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeEnCoffreMnt);
            Mnt += LRecRisqueClient.CltChequeEnCoffreMnt;

        end;
        if (LRecRisqueClientSetup.CltTraiteEnCoffreUsage) and (LRecRisqueClientSetup.CltTraiteEnCoffre <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEnCoffreFilter, LRecRisqueClientSetup.CltTraiteEnCoffre);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteEnCoffreMnt);
            Mnt += LRecRisqueClient.CltTraiteEnCoffreMnt;

        end;
        if (LRecRisqueClientSetup.CltTraiteRemisEncUsage) and (LRecRisqueClientSetup.CltTraiteRemisEnc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteRemisEncFilter, LRecRisqueClientSetup.CltTraiteRemisEnc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteRemisEncMnt);
            Mnt += LRecRisqueClient.CltTraiteRemisEncMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteRemisEscUsage) and (LRecRisqueClientSetup.CltTraiteRemisEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteRemisEscFilter, LRecRisqueClientSetup.CltTraiteRemisEsc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteRemiseEscNonEchueMnt);
            Mnt += LRecRisqueClient.CltTraiteRemiseEscNonEchueMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteEncoursEncUsage) and (LRecRisqueClientSetup.CltTraiteEncoursEnc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEncoursEncFilter, LRecRisqueClientSetup.CltTraiteEncoursEnc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteEncoursEncMnt);
            Mnt += LRecRisqueClient.CltTraiteEncoursEncMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteEncoursEscUsage) and (LRecRisqueClientSetup.CltTraiteEncoursEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEncoursEscFilter, LRecRisqueClientSetup.CltTraiteEncoursEsc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteEncoursEscMnt);
            Mnt += LRecRisqueClient.CltTraiteEncoursEscMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeContentieuxUsage) and (LRecRisqueClientSetup.CltChequeContentieux <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeContentieuxFilter, LRecRisqueClientSetup.CltChequeContentieux);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeContentieuxMnt);
            Mnt += LRecRisqueClient.CltChequeContentieuxMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeImpayeUsage) and (LRecRisqueClientSetup.CltChequeImpaye <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeImpayeFilter, LRecRisqueClientSetup.CltChequeImpaye);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeImpayeMnt);
            Mnt += LRecRisqueClient.CltChequeImpayeMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteContentieuxUsage) and (LRecRisqueClientSetup.CltTraiteContentieux <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteContentieuxFilter, LRecRisqueClientSetup.CltTraiteContentieux);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteContentieuxMnt);
            Mnt += LRecRisqueClient.CltTraiteContentieuxMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteImpayeUsage) and (LRecRisqueClientSetup.CltTraiteImpaye <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteImpayeFilter, LRecRisqueClientSetup.CltTraiteImpaye);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltTraiteImpayeMnt);
            Mnt += LRecRisqueClient.CltTraiteImpayeMnt;
        end;
        ///Cheque remis escompte
        if (LRecRisqueClientSetup.CltChequeRemisEscUsage) and (LRecRisqueClientSetup.CltChequeRemisEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeRemisEscFilter, LRecRisqueClientSetup.CltChequeRemisEsc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeRemisEscMnt);
            Mnt += LRecRisqueClient.CltChequeRemisEscMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeEncoursEscUsage) and (LRecRisqueClientSetup.CltChequeEncoursEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEncoursEscFilter, LRecRisqueClientSetup.CltChequeEncoursEsc);
            LRecRisqueClient.SetFilter("Date Filter", FilterDate);
            LRecRisqueClient.CalcFields(CltChequeEncoursEscMnt);
            Mnt += LRecRisqueClient.CltChequeEncoursEscMnt;
        end;
        exit(Mnt)
    end;

    procedure GetMntEcours(PCodeClient: Code[20]): Decimal
    var
        LRecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Mnt: Decimal;
        LRecRisqueClient: Record STRisqueClientFRs;
    begin
        LRecRisqueClientSetup.GET();
        if (LRecRisqueClientSetup.CltChequeEncVersUsage) and (LRecRisqueClientSetup.CltChequeEncVers <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEncVersFilter, LRecRisqueClientSetup.CltChequeEncVers);
            LRecRisqueClient.CalcFields(CltChequeEncVersMnt);
            Mnt += LRecRisqueClient.CltChequeEncVersMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeEnCoffreUsage) and (LRecRisqueClientSetup.CltChequeEnCoffre <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEnCoffreFilter, LRecRisqueClientSetup.CltChequeEnCoffre);
            LRecRisqueClient.CalcFields(CltChequeEnCoffreMnt);
            Mnt += LRecRisqueClient.CltChequeEnCoffreMnt;

        end;
        if (LRecRisqueClientSetup.CltTraiteEnCoffreUsage) and (LRecRisqueClientSetup.CltTraiteEnCoffre <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEnCoffreFilter, LRecRisqueClientSetup.CltTraiteEnCoffre);
            LRecRisqueClient.CalcFields(CltTraiteEnCoffreMnt);
            Mnt += LRecRisqueClient.CltTraiteEnCoffreMnt;

        end;
        if (LRecRisqueClientSetup.CltTraiteRemisEncUsage) and (LRecRisqueClientSetup.CltTraiteRemisEnc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteRemisEncFilter, LRecRisqueClientSetup.CltTraiteRemisEnc);
            LRecRisqueClient.CalcFields(CltTraiteRemisEncMnt);
            Mnt += LRecRisqueClient.CltTraiteRemisEncMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteRemisEscUsage) and (LRecRisqueClientSetup.CltTraiteRemisEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteRemisEscFilter, LRecRisqueClientSetup.CltTraiteRemisEsc);
            LRecRisqueClient.CalcFields(CltTraiteRemiseEscNonEchueMnt);
            Mnt += LRecRisqueClient.CltTraiteRemiseEscNonEchueMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteEncoursEncUsage) and (LRecRisqueClientSetup.CltTraiteEncoursEnc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEncoursEncFilter, LRecRisqueClientSetup.CltTraiteEncoursEnc);
            LRecRisqueClient.CalcFields(CltTraiteEncoursEncMnt);
            Mnt += LRecRisqueClient.CltTraiteEncoursEncMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteEncoursEscUsage) and (LRecRisqueClientSetup.CltTraiteEncoursEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteEncoursEscFilter, LRecRisqueClientSetup.CltTraiteEncoursEsc);
            LRecRisqueClient.CalcFields(CltTraiteEncoursEscMnt);
            Mnt += LRecRisqueClient.CltTraiteEncoursEscMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeContentieuxUsage) and (LRecRisqueClientSetup.CltChequeContentieux <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeContentieuxFilter, LRecRisqueClientSetup.CltChequeContentieux);
            LRecRisqueClient.CalcFields(CltChequeContentieuxMnt);
            Mnt += LRecRisqueClient.CltChequeContentieuxMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeImpayeUsage) and (LRecRisqueClientSetup.CltChequeImpaye <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeImpayeFilter, LRecRisqueClientSetup.CltChequeImpaye);
            LRecRisqueClient.CalcFields(CltChequeImpayeMnt);
            Mnt += LRecRisqueClient.CltChequeImpayeMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteContentieuxUsage) and (LRecRisqueClientSetup.CltTraiteContentieux <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteContentieuxFilter, LRecRisqueClientSetup.CltTraiteContentieux);
            LRecRisqueClient.CalcFields(CltTraiteContentieuxMnt);
            Mnt += LRecRisqueClient.CltTraiteContentieuxMnt;
        end;
        if (LRecRisqueClientSetup.CltTraiteImpayeUsage) and (LRecRisqueClientSetup.CltTraiteImpaye <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltTraiteImpayeFilter, LRecRisqueClientSetup.CltTraiteImpaye);
            LRecRisqueClient.CalcFields(CltTraiteImpayeMnt);
            Mnt += LRecRisqueClient.CltTraiteImpayeMnt;
        end;
        ///Cheque remis escompte
        if (LRecRisqueClientSetup.CltChequeRemisEscUsage) and (LRecRisqueClientSetup.CltChequeRemisEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeRemisEscFilter, LRecRisqueClientSetup.CltChequeRemisEsc);
            LRecRisqueClient.CalcFields(CltChequeRemisEscMnt);
            Mnt += LRecRisqueClient.CltChequeRemisEscMnt;
        end;
        if (LRecRisqueClientSetup.CltChequeEncoursEscUsage) and (LRecRisqueClientSetup.CltChequeEncoursEsc <> '')
        then begin
            LRecRisqueClient.get(LRecRisqueClient.Type::Customer, PCodeClient);
            LRecRisqueClient.SetFilter(CltChequeEncoursEscFilter, LRecRisqueClientSetup.CltChequeEncoursEsc);
            LRecRisqueClient.CalcFields(CltChequeEncoursEscMnt);
            Mnt += LRecRisqueClient.CltChequeEncoursEscMnt;
        end;
        exit(Mnt)
    end;
}
