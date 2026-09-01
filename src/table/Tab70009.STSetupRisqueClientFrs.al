table 70009 "STSetupRisqueClientFrs"
{
    Caption = 'STSetupRisqueClientFrs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; CltChequeEnCoffre; Text[50])
        {
            Caption = 'Chèque en coffre';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(3; CltChequeImpaye; Text[50])
        {
            Caption = 'Chèque Impayé';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(4; CltChequeContentieux; Text[50])
        {
            Caption = 'Chèque contentieux';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(5; CltChequeEncVers; Text[50])
        {
            Caption = 'Chèque encours de versement';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(6; CltTraiteEnCoffre; Text[50])
        {
            Caption = 'Traite en coffre';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(7; CltTraiteRemisEnc; Text[50])
        {
            Caption = 'Traite Remise à l''encaissement';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(8; CltTraiteEncoursEnc; Text[50])
        {
            Caption = 'Traite encours d''encaissement';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(9; CltTraiteRemisEsc; Text[50])
        {
            Caption = 'Traite remise à l''escompte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(10; CltTraiteEncoursEsc; Text[50])
        {
            Caption = 'Traite encours d''escompte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(11; CltTraiteImpaye; Text[50])
        {
            Caption = 'Traite impayée';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(12; CltTraiteContentieux; Text[50])
        {
            Caption = 'Traite contentieux';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(13; FrsTraiteRemise; Text[50])
        {
            Caption = 'Traite remise';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(14; FrsChequeEncours; Text[50])
        {
            Caption = 'Chèque encours';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(15; FrsTraiteEncours; Text[50])
        {
            Caption = 'Traite encours';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(16; CltChequeEnCoffreUsage; Boolean)
        {
            Caption = 'Chèque en coffre inclus dans encours';

        }

        field(19; CltChequeEncVersUsage; Boolean)
        {
            Caption = 'Chèque encours de versement inclus dans encours';

        }
        field(20; CltTraiteEnCoffreUsage; Boolean)
        {
            Caption = 'Traite en coffre inclus dans encours';
        }
        field(21; CltTraiteRemisEncUsage; Boolean)
        {
            Caption = 'Traite Remise à l''encaissement inclus dans encours';

        }
        field(22; CltTraiteEncoursEncUsage; Boolean)
        {
            Caption = 'Traite encours d''encaissement inclus dans encours';

        }
        field(23; CltTraiteRemisEscUsage; Boolean)
        {
            Caption = 'Traite remise à l''escompte non échue inclus dans encours';

        }
        field(24; CltTraiteEncoursEscUsage; Boolean)
        {
            Caption = 'Traite encours d''escompte inclus dans encours';
        }
        field(25; CltChequeImpayeUsage; Boolean)
        {
            Caption = 'Chèque impayé inclus dans encours';
        }
        field(26; CltChequeContentieuxUsage; Boolean)
        {
            Caption = 'Chèque Contentieux inclus dans encours';
        }
        field(27; CltTraiteImpayeUsage; Boolean)
        {
            Caption = 'Traite impayée inclus dans encours';
        }
        field(28; CltTraiteContentieuxUsage; Boolean)
        {
            Caption = 'Traite Contentieux inclus dans encours';
        }
        field(29; PeriodRefEscopmte; DateFormula)
        {
            Caption = 'Période Référence Escompte';
        }
        field(50; CltChequeRemisEsc; Text[50])
        {
            Caption = 'Chèque remise à l''escompte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(51; CltChequeEncoursEsc; Text[50])
        {
            Caption = 'Chèque encours d''escompte';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = false;
        }
        field(52; CltChequeRemisEscUsage; Boolean)
        {
            Caption = 'Chèque remise à l''escompte inclus dans encours';

        }
        field(53; CltChequeEncoursEscUsage; Boolean)
        {
            Caption = 'Chèque encours d''escompte inclus dans encours';
        }
        field(54; CltTraiteEscPaye; Code[20])
        {
            Caption = 'Traite escomptée payée';
            TableRelation = STSituationPaiement.Code;
            ValidateTableRelation = true;
        }
        field(55; PeriodPayEffetEsc; DateFormula)
        {
            Caption = 'Période Effet Escompté payé';
        }

    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure InitSetup()
    begin
        Init();
        Insert();
        SynchroniseClientFrs();

    end;

    procedure SynchroniseClientFrs()
    var
        lRecCustomer: Record Customer;
        lRecVendor: Record Vendor;
        lRecRisque: Record STRisqueClientFRs;

    begin
        if lRecCustomer.FindSet() then
            repeat
                lRecRisque.Init();
                lRecRisque.Type := lRecRisque.Type::Customer;
                lRecRisque.Code := lRecCustomer."No.";
                if lRecRisque.Insert() then;
            until lRecCustomer.Next() = 0;
        if lRecVendor.FindSet() then
            repeat
                lRecRisque.Init();
                lRecRisque.Type := lRecRisque.Type::Vendor;
                lRecRisque.Code := lRecVendor."No.";
                if lRecRisque.Insert() then;
            until lRecVendor.Next() = 0;
    end;
}
