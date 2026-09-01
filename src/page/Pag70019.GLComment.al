page 70019 "G/L Comment"
{
    Permissions = tabledata "G/L Entry" = RM,
                  tabledata "Cust. Ledger Entry" = RM,
                  tabledata "Vendor Ledger Entry" = RM;
    Caption = 'Informations écritures';
    PageType = Card;
    SourceTable = "G/L Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the G/L entries were posted.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the number of the document that the general ledger entries apply to.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Note; Rec.Note)
                {
                    ToolTip = 'Specifies the value of the Commentaire field.';
                    ApplicationArea = All;

                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the due date field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        Cust: Record "Cust. Ledger Entry";
                        Vend: Record "Vendor Ledger Entry";
                    begin

                        if Rec."Due Date" <> xRec."Due Date" then begin
                            if Cust.get(Rec."Entry No.") then begin
                                Cust."Due Date" := Rec."Due Date";
                                Cust.Modify();
                                CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Cust);
                            end;
                            if Vend.get(Rec."Entry No.") then begin
                                Vend."Due Date" := Rec."Due Date";
                                Vend.Modify();
                                CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Vend);
                            end;
                        end;
                    end;

                }
            }
        }
    }

}
