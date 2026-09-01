table 70004 "STAutorisationStepPayment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; User; Code[50])
        {
            Caption = 'Utilisateur';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

        }
        field(2; PaymentType; Code[50])
        {
            Caption = 'Type règlement';
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; User, PaymentType)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}