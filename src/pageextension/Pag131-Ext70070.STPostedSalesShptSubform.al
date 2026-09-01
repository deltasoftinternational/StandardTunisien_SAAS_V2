pageextension 70070 "STPosted Sales Shpt. Subform" extends "Posted Sales Shpt. Subform"//131
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
