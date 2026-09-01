pageextension 70071 "STPosted Return Receipt" extends "Posted Return Receipt"//6660
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
