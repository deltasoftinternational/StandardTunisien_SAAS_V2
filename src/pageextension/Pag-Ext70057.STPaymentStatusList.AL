pageextension 71057 "Payment Status List FR" extends "Payment Status List FR"//10850
{
    layout
    {
        addafter(Name)
        {
            field(STCodeSituationPaiement; Rec.STCodeSituationPaiement)
            {
                ApplicationArea = All;
            }
        }
    }
}
