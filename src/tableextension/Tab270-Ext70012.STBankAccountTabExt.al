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


        field(70000; "STSource Code"; Code[20])
        {
            Caption = 'Source code';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(70001; STCaisse; Option)
        {
            Caption = 'Caisse';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Dépense,Recette';
            OptionMembers = " ","Dépense",Recette;
        }
        field(70002; "STModèle chèques"; Enum "ST Modele cheque")
        {
            Caption = 'modèles chèques';
            DataClassification = ToBeClassified;
        }
        field(70003; "STNbre Ligne Bord. Versement"; Integer)
        {
            Caption = 'Nbre ligne Bord. verement';
            DataClassification = ToBeClassified;
        }
        field(70004; Status; Option)
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
        field(70005; "User ID"; Code[50])
        {
            Caption = 'User id';
            FieldClass = FlowFilter;
        }
        field(70006; Visible; Boolean)
        {
            CalcFormula = Exist("ST Users Bank Accounts" WHERE("ST Bank No." = FIELD("No."),
                                                             "ST User ID" = FIELD("User ID")));
            Caption = 'Visible';
            FieldClass = FlowField;

        }

        field(70007; "STmodele lettre cheq."; Enum "ST Modele cheque")
        {
            Caption = 'Modèles lettre chèques';
            DataClassification = ToBeClassified;
        }

        field(70008; "ST Vendor LC"; code[20])//Lettre Credit
        {
            Caption = 'Vendor LC No.';
            TableRelation = Vendor;
        }
        field(70009; "ST Negative Balance Controle"; Boolean)
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

