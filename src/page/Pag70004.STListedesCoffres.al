page 70004 "ST Liste des Coffres"
{
    Caption = 'Liste des coffres';
    PageType = List;
    SourceTable = "ST Coffre";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(STCode; Rec.STCode)
                {
                    ApplicationArea = All;
                }
                field("STDésignation"; Rec."STDésignation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF GetCoffreFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETFILTER(STCode, GetCoffreFilter());
            Rec.FILTERGROUP(0);
        END;
    end;

    Procedure GetCoffreFilter(): Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(USERID) THEN
            EXIT(UserSetup.STCoffre);
    end;

    var
        UserMgt: Codeunit "User Setup Management";
}

