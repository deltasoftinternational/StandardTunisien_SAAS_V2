page 71008 "ST User Banks"
{
    Caption = 'User Banks';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "ST Users Bank Accounts";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank No."; Rec."ST Bank No.")
                {
                    LookupPageID = "ST Bank Account List 2";
                }
                field("Bank Name"; Rec."ST Bank Name")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    var
        Navigate: Page Navigate;
}

