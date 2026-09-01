pageextension 70025 "ST BankAccountCardPagExt" extends "Bank Account Card" //370
{
    layout
    {
        addafter(Blocked)
        {
            field("Source Code"; Rec."STSource Code")
            {
                ApplicationArea = All;
            }

            field("Modèle chèques"; Rec."STModèle chèques")
            {
                ApplicationArea = All;
                Visible = isVisible;
            }

            field("STmodele lettre cheq."; Rec."STmodele lettre cheq.")
            {
                ApplicationArea = All;

            }

            field("Nbre Ligne Bord. Versement"; Rec."STNbre Ligne Bord. Versement")
            {
                ApplicationArea = All;
            }
            field(STCaisse; Rec.STCaisse)
            {
                ApplicationArea = All;
            }
            field("ST Negative Balance Controle"; Rec."ST Negative Balance Controle")
            {
                ApplicationArea = All;
            }

        }

        addafter("Bank Account No.")
        {
            field("DLT Vendor LC"; REC."ST Vendor LC")//Lettre Credit
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        addlast(navigation)
        {

            action("Référence chéque")
            {
                Caption = 'Référence chéque';
                Image = CheckJournal;
                RunObject = Page "ST Référence chèque";
                RunPageLink = "ST Bank Code" = FIELD("No.");
                ApplicationArea = All;

            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        GeneralLedgerSetup.Get();
        if GeneralLedgerSetup."STmodele cheque" then
            isVisible := true;


    end;

    var
        isVisible: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
}



