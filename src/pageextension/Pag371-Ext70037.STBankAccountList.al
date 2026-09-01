pageextension 70037 "STBank Account List" extends "Bank Account List"//371
{
    layout
    {
        addafter("SWIFT Code")
        {
            field("Source Code"; Rec."STSource Code")
            {
                ApplicationArea = All;
            }

            field("Modèle chèques"; Rec."STModèle chèques")
            {
                ApplicationArea = All;
            }

            field("STmodele lettre cheq."; Rec."STmodele lettre cheq.")
            {
                ApplicationArea = All;

            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
            field("Nbre Ligne Bord. Versement"; Rec."STNbre Ligne Bord. Versement")
            {
                ApplicationArea = All;
            }

        }
        modify("Bank Acc. Posting Group")
        {
            Visible = true;
        }
    }

    actions
    {

    }
    trigger OnOpenPage()
    var
        RecUserBank: Record "ST Users Bank Accounts";
        LUserSetupRec: Record "User Setup";
    begin
        if LUserSetupRec.get(UserId) then;
        if LUserSetupRec."ST View All Bank Account" = false then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("User ID", USERID);
            Rec.SETRANGE(Visible, TRUE);

            Rec.FILTERGROUP(0);
        end;
    end;

    var
        myInt: Integer;
}