pageextension 71076 "STPosted ReturnShipmentSubform" extends "Posted Return Shipment Subform"//6651
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
