// DELTA 
pageextension 71065 "STGeneralLedgerEntries" extends "General Ledger Entries"//20
{
    layout
    {
        addafter("External Document No.")
        {
            field(STCoffre; Rec.STCoffre)
            {
                ApplicationArea = All;

            }
            field(Note; Rec.Note)
            {
                ApplicationArea = all;
            }

            field("ST adjt cost"; Rec."ST adjt cost")
            {
                ApplicationArea = all;
            }

        }
        modify("Source Code")
        {
            Visible = true;
        }
        modify("User ID")
        {
            Visible = true;
        }
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
        modify(Reversed)
        {
            Visible = true;
        }
        modify("Reversed by Entry No.")
        {
            Visible = true;
        }
        modify("Reversed Entry No.")
        {
            Visible = true;
        }
        modify("FA Entry Type")
        {
            Visible = true;
        }
        modify("FA Entry No.")
        {
            Visible = true;
        }
        addafter("Global Dimension 2 Code")
        {

            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
            }
            field(Letter; Rec.Letter)
            {
                ApplicationArea = all;
            }
            field("Letter Date"; Rec."Letter Date")
            {
                ApplicationArea = all;
            }
            field("ST Accrual"; Rec."ST Accrual")
            {
                ApplicationArea = all;
            }
            field("ST PR Date"; Rec."ST PR Date")
            {
                ApplicationArea = all;
            }
        }

        addlast(content)
        {
            group("Sum")
            {
                ShowCaption = false;
                Visible = SumVisible;
                Editable = false;
                field(SumSelect; SumSelect)
                {
                    Caption = 'Solde';
                    ApplicationArea = all;
                }
            }
        }
    }



    actions
    {
        addafter("Value Entries")
        {

            action("C&omment")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Modifier informations écriture';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "G/L comment";
                RunPageLink = "Entry No." = FIELD("Entry No.");

            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        Visiblefield();
    end;

    trigger OnAfterGetRecord()
    begin
        Visiblefield();
    end;

    trigger OnAfterGetCurrRecord()
    begin

        VGeneralLedgerEntries.RESET();
        CLEAR(SumSelect);
        CurrPage.SETSELECTIONFILTER(VGeneralLedgerEntries);
        IF VGeneralLedgerEntries.FINDSET() THEN
            REPEAT
                SumSelect += VGeneralLedgerEntries."Amount";
            UNTIL VGeneralLedgerEntries.NEXT() = 0;


    end;

    procedure Visiblefield()
    var
        GLsetup: Record "General Ledger Setup";
    begin
        GLsetup.get();
        SumVisible := GLsetup."STView Sum GLEntries";

    end;

    var

        SumSelect: Decimal;
        VGeneralLedgerEntries: Record "G/L Entry";

        SumVisible: Boolean;
}