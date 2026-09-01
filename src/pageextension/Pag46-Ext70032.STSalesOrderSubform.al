pageextension 70032 "ST SalesOrderSubForm" extends "Sales Order Subform"//46
{

    layout
    {


        addafter("Total Amount Incl. VAT")
        {
            field("ST Totalwithstamp"; Totalwithstamp)
            {
                Editable = false;
                Caption = 'Montant Net à Payer';
                ApplicationArea = All;

            }
        }
    }

    trigger OnOpenPage()
    begin
        clear(Totalwithstamp);

    end;

    trigger OnAfterGetCurrRecord()
    var
        lsalesheader: Record "Sales Header";
    begin
        if lsalesheader.get(Rec."Document Type", Rec."Document No.") then begin
            lsalesheader.CalcFields("Amount Including VAT");
            if not lsalesheader."STApply Stamp Fiscal" then
                Totalwithstamp := lsalesheader."Amount Including VAT"
            else
                Totalwithstamp := lsalesheader."Amount Including VAT" + lsalesheader."STStamp Amount";
        end;
    end;


    protected var
        Totalwithstamp: Decimal;

}