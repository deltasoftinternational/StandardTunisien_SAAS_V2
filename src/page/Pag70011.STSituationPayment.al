page 70011 "STSituationPayment"
{

    ApplicationArea = All;
    Caption = 'Situation Paiement';
    PageType = List;
    SourceTable = STSituationPaiement;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {

                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("InitSetup")
            {
                Caption = 'Initialiser';
                Image = Setup;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.InitDefaultSetup();
                end;
            }
        }
    }
}
