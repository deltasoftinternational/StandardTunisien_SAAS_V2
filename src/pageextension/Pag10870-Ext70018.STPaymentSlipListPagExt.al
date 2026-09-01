pageextension 71018 "Payment Slip List FR" extends "Payment Slip List FR" //10846
{
    layout
    {
        addafter("Status Name")
        {
            field(Coffre; Rec.STCoffre)
            {
                ApplicationArea = All;
            }
            field("Account No."; Rec."Account No.")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount (LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("STCréer par"; Rec."STCréer par")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {
        modify("Create Payment Slip")
        {
            visible = false;
            Enabled = false;
        }
        addafter("Create Payment Slip")
        {
            action("ST Create Payment Slip")
            {
                ApplicationArea = All;
                Caption = 'Créer bordereau paiement';
                Image = NewDocument;
                RunObject = Codeunit "ST Payment Management";
                ToolTip = 'Manage information about customer and vendor payments.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Liste des ligne bord")
            {
                ApplicationArea = All;
                Caption = 'Liste des lignes bordereaux';
                Image = NewDocument;
                RunObject = page "STPayment Lines List";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
        addlast(Processing)
        {
            action(EtatDesReglement)
            {
                Caption = 'Etat des réglements';
                ApplicationArea = All;
                RunObject = report "Etat Des Reglements";
                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //<< DELTA 01 RAD 09/12/2014 Gestion de Coffre par Site
        IF userSetup.GET(UPPERCASE(USERID)) THEN
            IF userSetup.STCoffre <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETRANGE(STCoffre, userSetup.STCoffre);
                Rec.FILTERGROUP(0);
            END;
        //>>END DELTA 01
        //CurrPage.UPDATE;
    end;

    var
        userSetup: Record "User Setup";

}

