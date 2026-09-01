pageextension 71069 "STPosted Sales Shipment" extends "Posted Sales Shipment"//142
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
