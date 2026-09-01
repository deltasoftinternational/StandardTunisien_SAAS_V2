pageextension 71050 "STCustomer List PagExt" extends "Customer List" //22
{
    layout
    {
        modify("Customer Posting Group")
        {
            Visible = true;
        }
        addafter("Balance (LCY)")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action(ReleveCompte)
            {
                ApplicationArea = All;
                Caption = 'Relevé de compte';
                RunObject = report "STRelevee de compte";
                Image = Report;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}