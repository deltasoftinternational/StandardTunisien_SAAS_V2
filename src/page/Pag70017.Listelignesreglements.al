page 71017 "Liste lignes reglements"
{
    Caption = 'Liste lignes reglements';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payment Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the payment.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment line''s entry number.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the payment line.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the currency code for the amount on this line.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount (including VAT) of the payment line.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total amount on the payment line in LCY.';
                    Visible = false;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of account that the payment line will be posted to.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the account that the entry on the journal line will be posted to.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Payment Class"; Rec."Payment Class")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment class used when creating this payment slip line.';
                }
                field("Status Name"; Rec."Status Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the payment.';
                }
                field("Status No."; Rec."Status No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status line entry number.';
                    Visible = false;
                }
                field("Acceptation Code"; Rec."Acceptation Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an acceptation code for the payment line.';
                }
                field("Drawee Reference"; Rec."Drawee Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the file reference which will be used in the electronic payment (ETEBAC) file.';
                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the bank account as entered in the Bank Account Code field.';
                    Visible = false;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the branch number of the bank account.';
                    Visible = false;
                }
                field("Agency Code"; Rec."Agency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the agency code of the bank account.';
                    Visible = false;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the international bank account number (IBAN) for the payment slip.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the international bank identification code for the payment slip.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer or vendor bank account that you want to perform the payment to, or collection from.';
                    Visible = false;
                }
                field("RIB Key"; Rec."RIB Key")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the two digit RIB key associated with the Bank Account No.';
                    Visible = false;
                }
                field("Payment in Progress"; Rec."Payment in Progress")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the payment line is taken into account for the customer or vendor payments in progress.';
                    Visible = false;
                }





                field("Banque Societe"; Rec."Banque Societe")
                {
                    ApplicationArea = all;
                }
                field("Copied To No."; Rec."Copied To No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("STEn Banque"; Rec."STEn Banque")
                {
                    ApplicationArea = all;
                }
                field(Libellé; Rec."STLibellé")
                {
                    ApplicationArea = all;
                }
                field("STDrawee Reference1"; Rec."STDrawee Reference1")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field(STCommentaires; Rec.STCommentaires)
                {
                    ApplicationArea = all;
                }
                field(Coffre; Rec.STCoffre)
                {
                    ApplicationArea = all;
                }
                field("Coffre Origine"; Rec."STCoffre Origine")
                {
                    ApplicationArea = all;
                }
                field("Created from No."; Rec."Created from No.")
                {
                    ApplicationArea = all;
                }
                field("Bank Account Code"; Rec."Bank Account Code")
                {
                    ApplicationArea = all;
                }
            }

        }

    }

    actions
    {

        area(Processing)
        {
            action(Fiche)
            {
                ApplicationArea = all;
                Image = Card;
                RunObject = page "Payment Slip";
                RunPageLink = "No." = field("No.");
            }
        }
    }

}

