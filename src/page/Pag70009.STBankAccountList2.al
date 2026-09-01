page 71009 "ST Bank Account List 2"
{
    Caption = 'Bank Account List 2';
    CardPageID = "Bank Account Card";
    UsageCategory = Administration;
    Editable = false;
    PageType = List;
    SourceTable = "Bank Account";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(GROUP)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Check Report Name");
    end;
}

