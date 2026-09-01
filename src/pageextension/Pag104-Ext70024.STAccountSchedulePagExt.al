pageextension 71024 "ST AccountSchedulePagExt" extends "Account Schedule" //104
{
    layout
    {
        addafter("Amount Type")
        {
            field("Totalisation debiteur"; Rec."STTotalisation debiteur")
            {
                ApplicationArea = All;
            }
            field("Totalisation Crediteur"; Rec."STTotalisation Crediteur")
            {
                ApplicationArea = All;
            }

            field(STNote; Rec.STNote)
            {
                ApplicationArea = All;
            }

        }

    }




}





