page 71002 "STPayment Lines List"
{
    Caption = 'Liste des lignes bordereaux';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payment Line";
    ApplicationArea = all;
    UsageCategory = Lists;

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

                field("Label"; Rec."STLibellé")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the Label of the account that the entry on the journal line will be posted to.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("STCoffre Origine"; Rec."STCoffre Origine")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the origin coffre.';
                }
                field(STCoffre; Rec.STCoffre)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Banque Societe"; Rec."Banque Societe")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Copied To No."; Rec."Copied To No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Created from No."; Rec."Created from No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Bank Account Code"; Rec."Bank Account Code")
                {
                    ApplicationArea = Basic, Suite;

                }
                field(STCommentaires; Rec.STCommentaires)
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Payment Class"; Rec."Payment Class")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment class used when creating this payment slip line.';
                }
                field("Status Name"; Rec."STatus Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the payment.';
                }
                field("Status No."; Rec."STatus No.")
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

                field("STCréer par"; Rec."STCréer par")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the User id.';

                }
            }
            group(" ")
            {
                field(SumSelect; SumSelect)
                {
                    Caption = 'Montant Total';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = '&Payment';
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Open the card for the entity on the selected line to view more details.';

                    trigger OnAction()
                    var
                        Statement: Record "Payment Header";
                        StatementForm: Page "Payment Slip";
                    begin
                        if Statement.Get(Rec."No.") then begin
                            Statement.SetRange("No.", Rec."No.");
                            StatementForm.SetTableView(Statement);
                            StatementForm.Run();
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions2")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(Modify)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Modify';
                    Image = EditFilter;
                    ToolTip = 'View and edit line information for payments and collections.';

                    trigger OnAction()
                    var
                        PaymentLine: Record "Payment Line";
                        Consult: Page "Payment Line Modification";
                    begin
                        PaymentLine.Copy(Rec);
                        PaymentLine.SetRange("No.", Rec."No.");
                        PaymentLine.SetRange("Line No.", Rec."Line No.");
                        Consult.SetTableView(PaymentLine);
                        Consult.RunModal();
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = ACTION::LookupOK then
            LookupOKOnPush();
    end;

    trigger OnAfterGetCurrRecord()
    begin

        GPaymentLine.RESET();
        CLEAR(SumSelect);
        CurrPage.SETSELECTIONFILTER(GPaymentLine);
        IF GPaymentLine.FINDSET() THEN
            REPEAT
                SumSelect += GPaymentLine."Amount (LCY)";
            UNTIL GPaymentLine.NEXT() = 0;


    end;

    var
        Steps: Integer;
        PayNum: Code[20];
        GPaymentLine: Record "Payment Line";
        SumSelect: Decimal;


    procedure SetSteps(Step: Integer)
    begin
        Steps := Step;
    end;


    procedure SetNumBor(N: Code[20])
    begin
        PayNum := N;
    end;


    procedure GetNumBor() N: Code[20]
    begin
        N := PayNum;
    end;

    local procedure LookupOKOnPush()
    var
        StatementLine: Record "Payment Line FR";
        PostingStatement: Codeunit "ST Payment Management";
    begin
        CurrPage.SetSelectionFilter(StatementLine);
        PostingStatement.CopyLigBor(StatementLine, Steps, PayNum);
        CurrPage.Close();
    end;
}

