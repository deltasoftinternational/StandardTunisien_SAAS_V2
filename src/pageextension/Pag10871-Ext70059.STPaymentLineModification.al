pageextension 71059 "Payment Line Modification FR" extends "Payment Line Modification FR"  //10836
{
    layout
    {
        addafter(Control1)
        {
            group("Commission")
            {
                Caption = 'Commission';
                field("stMontant Interret"; Rec."STMontant Interret")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Editable = IseditComm;
                }
                field("stMontant Commission"; Rec."STMontant Commission")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Editable = IseditComm;
                }
                field("STMontant TVA Commission"; Rec."STMontant TVA Commission")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Editable = IseditComm;
                }

            }
        }

    }
    trigger OnOpenPage()
    begin
        EditCommission()
    end;

    trigger OnAfterGetRecord()
    begin
        EditCommission()
    end;

    procedure EditCommission()
    var
        lusersetup: Record "user setup";
    begin
        lusersetup.Get(UserId);
        IseditComm := lusersetup."ST modify commission";
    end;

    var
        IseditComm: Boolean;

}