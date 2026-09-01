pageextension 70026 "ST VendorCardPagExt" extends "Vendor Card" //26
{
    layout
    {
        addafter("Prices Including VAT")
        {
            field("Code Retenue a la Source"; Rec."STCode Retenue a la Source")
            {
                ApplicationArea = All;
            }
            field(CIN; Rec.STCIN)
            {
                ApplicationArea = All;
            }

        }
        addafter(Invoicing)
        {
            group("Risque Fournisseur")
            {
                ShowCaption = true;
                part(STRisqueFrs; STRisqueFrs)
                {
                    Caption = 'Risque fournisseur';
                    ApplicationArea = all;
                    Editable = false;
                    SubPageLink = type = const(Vendor), code = field("No.");
                }
            }
        }
        addlast(General)
        {
            field("Execute FNP"; Rec."Execute FNP")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}