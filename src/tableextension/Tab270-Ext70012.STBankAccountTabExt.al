tableextension 71012 "ST BankAccountTabExt" extends "Bank Account" //270
{


    fields
    {
        modify("Agency Code")
        {
            trigger OnAfterValidate()
            var
                IsHandled: Boolean;
            begin
                OnBeforecheckAgencyCodeLength(Rec, IsHandled);
                if not IsHandled then
                    "Agency Code" := CopyStr("Agency Code", 3, 3);
            end;
        }


        field(71000; "STSource Code"; Code[20])
        {
            Caption = 'Source code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(71001; STCaisse; Option)
        {
            Caption = 'Caisse';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Dépense,Recette';
            OptionMembers = " ","Dépense",Recette;
        }
        field(71002; "STModèle chèques"; Enum "ST Modele cheque")
        {
            Caption = 'modèles chèques';
            DataClassification = ToBeClassified;
        }
        field(71003; "STNbre Ligne Bord. Versement"; Integer)
        {
            Caption = 'Nbre ligne Bord. verement';
            DataClassification = ToBeClassified;
        }
        field(71004; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Waiting,Validated';
            OptionMembers = Waiting,Validated;

            // trigger OnValidate()
            // begin

            //     IF Status = Status::Validated THEN BEGIN
            //         IF UserSetup.GET(UPPERCASE(USERID)) THEN
            //             IF NOT UserSetup."Release Bank Account Card" THEN
            //                 ERROR(Text018);
            //         CheckFields;
            //         CheckDimension;
            //     END
            // end;
        }
        field(71005; "User ID"; Code[50])
        {
            Caption = 'User id';
            FieldClass = FlowFilter;
        }
        field(71006; Visible; Boolean)
        {
            CalcFormula = Exist("ST Users Bank Accounts" WHERE("ST Bank No." = FIELD("No."),
                                                             "ST User ID" = FIELD("User ID")));
            Caption = 'Visible';
            FieldClass = FlowField;

        }

        field(71007; "STmodele lettre cheq."; Enum "ST Modele cheque")
        {
            Caption = 'Modèles lettre chèques';
            DataClassification = ToBeClassified;
        }

        field(71008; "ST Vendor LC"; code[20])//Lettre Credit
        {
            Caption = 'Vendor LC No.';
            TableRelation = Vendor;
        }
        field(71009; "ST Negative Balance Controle"; Boolean)
        {
            Caption = 'Contrôle solde négatif';
            DataClassification = CustomerContent;
        }

    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforecheckAgencyCodeLength(var Rec: Record "Bank Account"; var IsHandled: Boolean)
    begin
    end;

    var
        UserSetup: Record "User Setup";
        RIBKey: Codeunit "RIB Key";


}

