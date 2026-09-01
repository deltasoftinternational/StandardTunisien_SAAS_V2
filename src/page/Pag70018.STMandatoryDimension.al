page 71018 "ST Mandatory Dimension"
{

    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Axes analytiques obligatoires';
    SourceTable = "ST Mandatory Dimension";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;



    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Table Id"; Rec."Table Id")
                {
                    ApplicationArea = All;
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}
