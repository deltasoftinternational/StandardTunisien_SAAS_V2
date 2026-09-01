pageextension 71041 "Purchase Invoice Statistics" extends "Purchase Invoice Statistics" //400
{
    layout
    {

        modify(AmountInclVAT)
        {
            Visible = false;
        }

        addafter(VATAmount)
        {

            field("STStamp Fiscal Amount"; Rec."STStamp Fiscal Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(MontantTTC; Rec."Amount Including VAT" + Rec."STStamp Fiscal Amount")
            {
                Caption = 'Montant TTC';
                ApplicationArea = All;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Amount Including VAT");
    end;


    var
        MontantTTC: Decimal;

}