pageextension 71021 "Payment Class fr" Extends "Payment Class fr" //10834
{

    layout
    {
        modify(Suggestions)
        {
            Visible = false;
        }
        addafter("SEPA Transfer Type")
        {
            field("Caisse"; Rec.STCaisse)
            {
                ApplicationArea = All;
            }
            field("Header Account Type"; Rec."STHeader Account Type")
            {
                ApplicationArea = All;
            }
            field(Observation; Rec.STObservation)
            {
                ApplicationArea = All;
            }
            field("Type_Reg"; Rec.STType_Reg)
            {
                ApplicationArea = All;
            }
            field(Type_ED; Rec.STType_ED)
            {
                ApplicationArea = All;
            }
            field("Controle Agent Remis"; Rec."STControle Agent Remis")
            {
                ApplicationArea = All;
            }
            //
            field("Doc. Extene  Obligatoir"; Rec."STDoc. Extene  Obligatoir")
            {
                ApplicationArea = All;
            }

            field("Petite dépense"; Rec."STPetite dépense")
            {
                ApplicationArea = All;
            }

            field("Caisse par défaut"; Rec."STCaisse par défaut")
            {
                ApplicationArea = All;
            }
            field("Compte ligne"; Rec."STCompte ligne")
            {
                ApplicationArea = All;
            }
            /* field("Profile Bordereau filter"; Rec."STProfile Bordereau filter")
             {
                 ApplicationArea = All;
             }*/
            field("Type Piece Paiement"; Rec."STType Piece Paiement")
            {
                ApplicationArea = All;
                visible = false; //Champ en double, utiliser la clolonne "STType_Reg" 70004
            }
            field(StepPayment; Rec."STepPayment")
            {
                ApplicationArea = All;
                trigger OnAssistEdit()
                var
                    AutorisationStepPayment: record "STAutorisationStepPayment";
                begin
                    AutorisationStepPayment.SETRANGE(PaymentType, Rec.Code);
                    PAGE.RUNMODAL(Page::STAutorisationStepPayment, AutorisationStepPayment);
                end;


            }


        }
        addafter("Suggestions")
        {
            field(STSuggestions; Rec.STSuggestions)
            {
                ApplicationArea = All;
            }


        }

    }
    actions
    {

        addafter(DuplicateParameter)
        {
            action(DuplicateParameter2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dupliquer paramétre avec autorisation';
                Image = CopySerialNo;
                ToolTip = 'Create a new payment class based on an existing payment class.';

                trigger OnAction()
                var
                    PaymentClass: record "Payment Class FR";
                    DuplicateParameter: Report "STDuplicate parameter";
                begin
                    if Rec.Code <> '' then begin
                        PaymentClass.SetRange(Code, Rec.Code);
                        DuplicateParameter.SetTableView(PaymentClass);
                        DuplicateParameter.InitParameter(Rec.Code);
                        DuplicateParameter.RunModal();
                    end;
                end;
            }
        }
    }
}