pageextension 71054 "STVAT Business Posting Groups" extends "VAT Business Posting Groups" //470
{
    layout
    {
        addafter(Description)
        {
            field("STVAT Account Suspension"; Rec."STVAT Account Suspension")
            {
                ApplicationArea = all;
            }

        }
    }

}
