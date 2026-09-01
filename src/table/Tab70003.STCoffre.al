table 71003 "ST Coffre"
{
    DrillDownPageID = "ST Liste des Coffres";
    LookupPageID = "ST Liste des Coffres";
    fields
    {
        field(1; STCode; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "STDésignation"; Text[30])
        {
            Caption = 'Désignation';
            DataClassification = ToBeClassified;
        }
        // field(3; "STCentre de Gestion"; Code[20])
        // {
        //     Caption = 'entre de Gestion';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Responsibility Center".Code;
        // }
    }

    keys
    {
        key(Key1; STCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; STCode, "STDésignation")
        {
        }
    }
}

