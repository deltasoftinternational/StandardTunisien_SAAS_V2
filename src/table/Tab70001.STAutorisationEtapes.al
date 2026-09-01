table 71001 "ST Autorisation Etapes"
{

    fields
    {

        field(1; "STPayment Class"; Text[30])
        {
            Caption = 'Type règlement';
            DataClassification = ToBeClassified;

        }
        field(2; STLine; Integer)
        {
            Caption = 'Ligne';
            DataClassification = ToBeClassified;
        }
        field(3; "STUser Code"; Code[50])
        {
            Caption = 'Utilisateur';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(4; "STNom Etapes"; Text[50])
        {
            Caption = 'Nom étape règlement';
            CalcFormula = Lookup("Payment Step".Name WHERE("Payment Class" = FIELD("STPayment Class"),
                                                            Line = FIELD(STLine)));
            FieldClass = FlowField;

        }

    }


    keys
    {
        key(Key1; "STPayment Class", STLine, "STUser Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

