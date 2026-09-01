pageextension 71075 "STPosted Return Shipment" extends "Posted Return Shipment"//6650
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
