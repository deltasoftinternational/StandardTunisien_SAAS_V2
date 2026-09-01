table 70007 "ST Users Bank Accounts"
{

    fields
    {
        field(1; "ST User ID"; Code[50])
        {
        }
        field(2; "ST Bank No."; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                CALCFIELDS("ST Bank Name");
            end;
        }
        field(3; "ST Bank Name"; Text[50])
        {
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("ST Bank No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "ST User ID", "ST Bank No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

