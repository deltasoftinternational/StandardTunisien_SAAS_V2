pageextension 70017 "STPaymentStepsPagExt" Extends "Payment Steps" //10866
{
    // /** DELTA 01 SD 02/07/2018 : création page
    // /** DELTA 02 IS 15/11/2018 : Ajout des controles
    layout
    {

        addlast(Control1)
        {
            field("Previous Status"; Rec."Previous Status")
            {
                ApplicationArea = All;
            }
            field("Previous Status Name"; Rec."Previous Status Name")
            {
                ApplicationArea = All;
            }
            field("Next Status"; Rec."Next Status")
            {
                ApplicationArea = All;
            }
            field("Next Status Name"; Rec."Next Status Name")
            {
                ApplicationArea = All;
            }
            field("Report No."; Rec."Report No.")
            {
                ApplicationArea = All;
            }
            field("Source Code"; Rec."Source Code")
            {
                ApplicationArea = All;
            }
            field("Action Type"; Rec."Action Type")
            {
                ApplicationArea = All;
            }
            field(Line; Rec.Line)
            {
                ApplicationArea = All;
            }
            field("STCode Coffre"; Rec."STCode Coffre")
            {
                ToolTip = 'Specifies the value of the Code coffre field';
                ApplicationArea = All;
            }



            field("Tiré Oblig."; Rec."STTiré Oblig.")
            {
                ApplicationArea = All;
            }

            field("Motif Obligatoire"; Rec.STCode_Motif_Obligatoir)
            {
                ApplicationArea = All;
            }

            field("Banque Entête Obligatoire"; Rec."STBanque Entête Obligatoire")
            {
                ApplicationArea = All;
            }
        }
        addafter("STCode Coffre")
        {
            field(STOption; Rec.STOption)
            {
                ApplicationArea = All;
            }
            field("STControle Solde Caisse"; Rec."STControle Solde Caisse")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        addlast(Creation)
        {
            action("Autorisation Etapes")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "ST Autorisation Etape";
                RunPageLink = "STPayment Class" = FIELD("Payment Class"), STLine = FIELD(Line);
                RunPageOnRec = false;
                Image = Permission;
            }

        }

    }


}
