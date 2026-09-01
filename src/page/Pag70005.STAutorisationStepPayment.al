page 70005 "STAutorisationStepPayment"
{
    Caption = 'Autorisation Types Règlement';
    PageType = List;
    SourceTable = "STAutorisationStepPayment";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(User; Rec."User")
                {
                    ApplicationArea = All;

                }
                field(PaymentType; Rec."PaymentType")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

}