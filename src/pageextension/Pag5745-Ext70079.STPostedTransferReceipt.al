pageextension 70079 "STPosted Transfer Receipt" extends "Posted Transfer Receipt"//5745
{
    trigger OnDeleteRecord(): Boolean
    begin
        Error('Vous ne pouvez pas supprimer %1', Caption);
    end;
}
