pageextension 71000 "Payment Status FR" extends "Payment Status FR" //10849
{
    layout
    {
        addlast(Control1)
        {
            field("Calculer retenue a la source"; Rec."STCalculer retenue a la source")
            {
                ApplicationArea = All;
            }

            field("Obligatoire Cheque/Traite"; Rec."STObligatoire Cheque/Traite")
            {
                ApplicationArea = All;
            }
            field("Obligatoire Code Banque"; Rec."STObligatoire Code Banque")
            {
                ApplicationArea = All;
            }
            field("Obligatoire Commentaire"; Rec."STObligatoire Commentaire")
            {
                ApplicationArea = All;
            }

            field("Compte en-tête"; Rec."STCompte en-tête")
            {
                ApplicationArea = All;
            }
            field("Mofi automatique BQ Entê"; Rec."STMofi automatique BQ Entê")
            {
                ApplicationArea = All;
            }
            field(STModifiable; Rec.STModifiable)
            {
                ApplicationArea = All;
            }
            field("Autoriser Modifcation Entête"; Rec."STAutoriser Modifcation Entête")
            {
                ApplicationArea = All;
            }
            field("Libelle modifiable"; Rec."STLibelle modifiable")
            {
                ApplicationArea = All;


            }
            field("STDue Date Obligatoire"; Rec."STDue Date Obligatoire")
            {
                ApplicationArea = All;


            }
            field(STModifyDueDateRef; Rec."ST Autorise Modify Due Date")
            {
                Caption = 'Autoriser Modifier Date D''échenace';
                ApplicationArea = all;
            }
            field("Référence chèque"; Rec."ST Référence chèque")
            {
                ApplicationArea = All;
            }
            field(Status; Rec."ST Status")
            {
                ApplicationArea = All;


            }
            field(STCodeSituationPaiement; Rec.STCodeSituationPaiement)
            {
                ApplicationArea = all;
            }
            field("ST LC Ship. date mandatory"; REC."ST LC Ship. date mandatory")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST LC valid. date mandatory"; REC."ST LC valid. date mandatory")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }

        }

    }

    trigger OnOpenPage()
    begin
        VisibleFields();
    end;

    trigger OnAfterGetRecord()
    begin
        VisibleFields();
    end;

    procedure VisibleFields()
    var
        lpurchasesetup: Record "Purchases & Payables Setup";

    begin
        lpurchasesetup.Get();
        if not lpurchasesetup."ST Enable Lettre Of Cr." then
            EnableLC := false
        else
            EnableLC := true;


    end;

    var
        EnableLC: Boolean;
}