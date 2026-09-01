tableextension 71013 "Payment Class FR" extends "Payment Class FR" //10833
{


    fields
    {
        field(70000; STCaisse; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Caisse';
        }
        field(70001; "STHeader Account Type"; Option)
        {
            Caption = 'Type compte entête';
            DataClassification = ToBeClassified;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(70002; STObservation; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Observation';
        }
        field(70003; "STMode Règlement"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mode règlement';
            TableRelation = "Payment Method".Code;
        }
        field(70004; STType_Reg; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type règlement';
            OptionMembers = " ","Chèque",Traite,Virement,"Espèce",LettreC,Autre,TPE,RS;
        }
        field(70005; "STControle Agent Remis"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Controle agenet remis';
        }
        field(70006; "STDoc. Extene  Obligatoir"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Doc. externe obligatoire';
        }

        field(70007; "STPetite dépense"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Petite dépense';
        }

        field(70008; "STCaisse par défaut"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Caisse par défaut';
            OptionCaption = ' ,Dépense,Recette';
            OptionMembers = " ","Dépense",Recette;
        }
        field(70009; "STCompte ligne"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compte ligne';
            OptionCaption = ' ,Caisse dépense, Caisse recette, fournisseur local, fournisseur étranger, salarié';
            OptionMembers = " ","Caisse dépense"," Caisse recette"," fournisseur local"," fournisseur étranger"," salarié";
        }
        // field(70010; Visible; Boolean)
        // {
        //     CalcFormula = Exist("Rank range" WHERE("Rank range value" = FIELD("Profile Bordereau filter")));

        //     Description = 'DELTA STD 01';
        //     FieldClass = FlowField;
        // }
        field(70011; "STProfile Bordereau filter"; Option)
        {
            Caption = 'Filtre profile bordereau';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Caissier,Financier,Comptable,Admin Borderau';
            OptionMembers = " ",Caissier,Financier,Comptable,"Admin Borderau";

        }
        field(70012; "STType Piece Paiement"; Option)
        {
            Caption = 'Type pièce paiement';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Chéque",Traite,Virement,"Espéce";
        }
        field(70013; "STType Bordereau"; Enum "ST Type Borderau ENUM")
        {
            Caption = 'Type bordereau';
            DataClassification = ToBeClassified;

        }
        field(70010; STType_ED; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'DELTA STD 01';
            OptionCaption = 'Encaissement,Décaissement';
            OptionMembers = Encaissement,"Décaissement";
        }
        field(70014; STSuggestions; Enum "ST Suggestions ENUM")
        {
            Caption = 'Propositions';
            trigger OnValidate()

            begin
                IF STSuggestions <> STSuggestions::Bank THEN
                    Validate(Suggestions, STSuggestions);
            end;

        }
        field(70015; StepPayment; Code[20])
        {
            Caption = 'Affectation';
            DataClassification = ToBeClassified;

        }
        field(70016; "ST Visible"; Boolean)
        {
            CalcFormula = Exist("ST Autorisation Etapes" WHERE("STPayment Class" = FIELD(Code),
                                                                    "STUser Code" = FIELD("ST User Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70017; "ST User Filter"; Code[50])
        {
            FieldClass = FlowFilter;
        }

        ////
        field(70018; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50001; "Payment Type"; Option)
        {
            Caption = 'Payment Type';
            OptionCaption = ' ,Check,Bill,Cash,Transfer,Letter of Credit';
            OptionMembers = " ",Check,Bill,Cash,Transfer,"Letter of Credit";
        }
        field(76000; "Default Bank Account"; Code[20])
        {

            TableRelation = "Bank Account"."No.";

        }
        modify("Header No. Series")
        {
            //
            trigger OnBeforeValidate()
            begin
                //code realisé pour augmenter taille souche 
                NSouche := "Header No. Series";
                "Header No. Series" := '';

            end;

            trigger OnAfterValidate()
            var
                NoSeriesLine: Record "No. Series Line";
            begin
                if NSouche <> '' then begin
                    NoSeriesLine.SetRange("Series Code", NSouche);
                    if NoSeriesLine.FindLast() then
                        if (StrLen(NoSeriesLine."Starting No.") > 20) or (StrLen(NoSeriesLine."Ending No.") > 20) then
                            Error(Text002);
                    "Header No. Series" := NoSeriesLine."Series Code";
                end;
            end;

        }

    }







    var
        Text001: Label 'You cannot delete this Payment Class because it is already in use.';
        //PaymentStep: Record 10862;
        Text002: Label 'You cannot assign numbers longer than 10 characters.';
        GLSetup: Record "General Ledger Setup";
        Text003: Label '%1 %2 has at least one %3 for which %4 is checked.';
        NSouche: Code[20];
}

