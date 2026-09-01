page 70000 "ST MontantDef"
{
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Montant défalcation"; Montantdef)
            {
            }
        }
    }

    actions
    {
    }

    var
        Montantdef: Decimal;

    procedure ReturnValue() Montant: Decimal
    begin
        Montant := Montantdef;
    end;
}

