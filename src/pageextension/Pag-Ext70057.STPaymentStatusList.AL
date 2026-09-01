pageextension 71057 "ST Payment Status List" extends "Payment Status List"
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
