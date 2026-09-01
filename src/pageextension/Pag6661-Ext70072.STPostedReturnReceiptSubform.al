pageextension 70072 "STPosted Return ReceiptSubform" extends "Posted Return Receipt Subform"//6661
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
