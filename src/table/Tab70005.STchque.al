table 71005 "ST chéque"
{

    fields
    {
        field(2; "ST Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(3; "ST Banque Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Code';
            TableRelation = "Bank Account"."No.";
        }
        field(4; "ST Réference chéque"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Réference chéque';
        }
        field(5; "ST Check No"; Code[35])
        {
            DataClassification = ToBeClassified;
            Caption = 'Check No.';
        }
        field(9; "ST Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
            OptionCaption = 'New,Bloqued,In Progress,Confirmed,Printed,Posted,Canceled';
            OptionMembers = New,Bloqued,"In Progress",Confirmed,Printed,ledger,Canceled;
        }
        field(10; "ST Payment Slip No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Slip No.';
        }
        field(11; "ST Line Payment Slip No"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Slip Line No.';
        }
        field(12; "ST Payment Slip Status"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Slip Status';
        }
        field(13; "ST Status No"; Integer)
        {
            CalcFormula = Lookup("Payment Header"."Status No." WHERE("No." = FIELD("ST Payment Slip No.")));
            Caption = 'Status No.';
            FieldClass = FlowField;

            trigger OnValidate()
            var
                PaymentHeader: Record "Payment Header";
            begin
            end;
        }
        field(14; "ST Status Modifiable"; Boolean)
        {
            CalcFormula = Exist("Payment Header" WHERE("No." = FIELD("ST Payment Slip No."),
                                                        "Status No." = CONST(0)));
            Enabled = false;
            FieldClass = FlowField;
        }
        field(15; "ST Account Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Type';
        }
        field(16; "ST Account No"; Code[20])
        {
            CalcFormula = Lookup("Payment Line"."Account No." WHERE("No." = FIELD("ST Payment Slip No.")));
            Caption = 'Account No';
            FieldClass = FlowField;
        }
        field(17; "ST Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Account Name';
        }
        field(18; "ST Amount line"; Decimal)
        {
            CalcFormula = Sum("Payment Line".Amount WHERE("No." = FIELD("ST Payment Slip No."),
                                                           "ST Check No" = FIELD("ST Check No")));
            Caption = 'Amount line';
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; "ST Banque Code", "ST Réference chéque", "ST Check No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ERROR(Error001);
    end;

    var
        Error001: Label 'You cannot delete check lines';
        Checks: Page "ST chèque";
}

