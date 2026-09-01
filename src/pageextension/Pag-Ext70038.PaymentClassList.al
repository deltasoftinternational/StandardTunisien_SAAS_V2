pageextension 71038 "Payment Class List" extends "Payment Class List"
{
    layout
    {
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        LrecUserSetup: record "User Setup";
    begin
        //>>DELTA 01
        if LrecUserSetup.get(UserId) then;
        If LrecUserSetup."ST Admin Payment Slip" = false then begin
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("ST User Filter", USERID);
            Rec.SETRANGE("ST Visible", TRUE);

            Rec.FILTERGROUP(0);
        end;
        //<<DELTA 01
    end;
}