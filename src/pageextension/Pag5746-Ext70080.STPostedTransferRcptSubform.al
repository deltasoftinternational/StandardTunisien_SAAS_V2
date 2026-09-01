pageextension 71080 "STPosted Transfer Rcpt.Subform" extends "Posted Transfer Rcpt. Subform"//5746
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
