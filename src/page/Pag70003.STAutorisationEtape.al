page 71003 "ST Autorisation Etape"
{
    Caption = 'Autorisation étape';
    PageType = List;
    SourceTable = "ST Autorisation Etapes";
    ApplicationArea = All;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("STPayment Class"; Rec."STPayment Class")
                {
                    ApplicationArea = All;
                }
                field(STLine; Rec.STLine)
                {
                    ApplicationArea = All;
                }
                field("STNom Etapes"; Rec."STNom Etapes")
                {
                    ApplicationArea = All;
                }
                field("STUser Code"; Rec."STUser Code")
                {
                    ApplicationArea = All;
                }



            }
        }
        area(Factboxes)
        {

        }
    }


}