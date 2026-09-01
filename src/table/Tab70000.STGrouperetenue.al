table 71000 "ST Groupe retenue"
{
    DrillDownPageID = "ST Groupe Retenue";
    LookupPageID = "ST Groupe Retenue";

    fields
    {
        field(1; STCode; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; STDesignation; Text[80])
        {
            Caption = 'Désignation';
            DataClassification = ToBeClassified;
        }
        field(3; "ST% Retenue"; Decimal)
        {
            Caption = '% Retenue';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(4; "STCompte Retenue"; Code[20])
        {
            Caption = 'Compte retenue';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(5; "STType Retenue"; Option) //FIXME:
        {
            Caption = 'Type retenue';
            DataClassification = ToBeClassified;
            OptionCaption = 'à la source';
            OptionMembers = "à la source";
        }
        field(6; STProposition; Option)
        {
            Caption = 'Proposition';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP pr filtrer les codes retenues à la source au niveau du BP';
            OptionCaption = ' ,Clients,Fournisseurs,Salarié';
            OptionMembers = " ",Clients,Fournisseurs,"Salarié";
        }
        field(7; STAnnexe; Option)
        {
            Caption = 'Annexe';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP Num Annexe contenant ce type de retenue';
            OptionMembers = " ",I,II,III,IV,V,VI;
        }
        field(8; "STPos. mnt Brut Dans Annexe"; Code[10])
        {
            Caption = 'Pos. mnt brut dans annexe';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP Position du montant brut de la retenue appliquée dans annexe II..V, Exemple A213';
        }
        field(9; "STSous Pos Mnt Brut ds Annexe"; Code[10])
        {
            Caption = 'Sous pos mnt brut ds annexe';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP Indique le type des montants servis dans annexe II IV, Exemple 1 : honoraires, 2 : commissions ...';
        }
        field(50001; "STActivé"; Boolean)
        {
            Caption = 'Activé';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP type utilisé par la société ou pas';
        }
        field(50002; STRistourne; Boolean)
        {
            Caption = 'Ristourne';
            DataClassification = ToBeClassified;
            Description = 'MT - DEC EMP pr les ristournes ne remplir qe le champ montant base';
        }
    }

    keys
    {
        key(Key1; "STType Retenue", STCode)
        {
            Clustered = true;
        }
        key(Key2; STCode)
        {
        }
    }

    fieldgroups
    {
    }
}

