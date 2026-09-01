tableextension 71015 "ST GenJournalLineTabExt" extends "Gen. Journal Line" //81
{
    fields
    {
        field(71000; "STOrder No."; Code[20])
        {
            Caption = 'N° commande';
            DataClassification = ToBeClassified;

        }
        field(71001; STCoffre; Code[20])
        {
            Caption = 'Coffre';
            DataClassification = ToBeClassified;
        }
        field(71002; "ST adjt cost"; Boolean)
        {
            Caption = 'Ajustement coût';
            DataClassification = ToBeClassified;
        }
        field(71005; "ST Accrual"; Boolean)
        {
            Caption = 'Accrual';
            DataClassification = ToBeClassified;
        }
        field(71006; "ST PR Date"; Date)
        {
            Caption = 'Date Réception';
            DataClassification = ToBeClassified;
        }
        field(71008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Option step';
        }
        field(71007; "STCode Retenue à la Source"; Code[10])
        {
            Caption = 'Code retenue à la source';
            TableRelation = "ST Groupe retenue".STCode WHERE("STType Retenue" = FILTER("à la source"));
        }

    }
}