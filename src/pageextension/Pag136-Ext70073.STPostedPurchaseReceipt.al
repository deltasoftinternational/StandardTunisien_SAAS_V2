pageextension 71073 "STPosted Purchase Receipt" extends "Posted Purchase Receipt"//136
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
