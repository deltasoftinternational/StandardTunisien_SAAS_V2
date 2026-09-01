pageextension 70031 "STSales Order Statistics" extends "Sales Order Statistics" //402
{
    layout
    {

        addafter("TotalSalesLineLCY[1].Amount")
        {
            field("ST STStamp Amount"; Rec."STStamp Amount")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("DLT Totalwithstamp"; Totalwithstamp)
            {
                Editable = false;
                Caption = 'Montant Net à Payer',;
                ApplicationArea = All;
            }

        }


    }

    trigger OnOpenPage()
    begin
        clear(Totalwithstamp);
    end;


    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Amount Including VAT");
        if not Rec."STApply Stamp Fiscal" then
            Totalwithstamp := Rec."Amount Including VAT"
        else
            Totalwithstamp := Rec."Amount Including VAT" + Rec."STStamp Amount";
    end;

    protected var
        Totalwithstamp: Decimal;



}
