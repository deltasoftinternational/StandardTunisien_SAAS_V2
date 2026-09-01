pageextension 70074 "STPosted Purchase Rcpt.Subform" extends "Posted Purchase Rcpt. Subform"//137
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
