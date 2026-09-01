pageextension 70077 "STPosted Transfer Shipment" extends "Posted Transfer Shipment"//5743
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
