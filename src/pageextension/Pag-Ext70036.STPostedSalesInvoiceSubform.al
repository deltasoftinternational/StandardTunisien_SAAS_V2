pageextension 71036 "STPosted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
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
        LSalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if LSalesInvoiceHeader.get(Rec."Document No.") then begin
            LSalesInvoiceHeader.CalcFields("Amount Including VAT");
            if not LSalesInvoiceHeader."STApply Stamp Fiscal" then
                Totalwithstamp := LSalesInvoiceHeader."Amount Including VAT"
            else
                Totalwithstamp := LSalesInvoiceHeader."Amount Including VAT" + LSalesInvoiceHeader."STStamp Amount";
        end;
    end;


    protected var
        Totalwithstamp: Decimal;
}