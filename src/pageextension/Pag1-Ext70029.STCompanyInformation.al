pageextension 70029 "ST CompanyInformation" extends "Company Information" //1
{
    layout
    {
        addlast(Payments)
        {
            field("STNombre cheque"; Rec."STNombre cheque")
            {
                ApplicationArea = All;
            }
            field("STNombre traite"; Rec."STNombre traite")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
    }
}