pageextension 70078 "STPosted Transfer Shpt.Subform" extends "Posted Transfer Shpt. Subform"//5744
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
