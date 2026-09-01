
pageextension 70063 "ST PurchasesPayablesSetup EXT" extends "Purchases & Payables Setup" //460
{
    layout
    {
        addlast(General)
        {
            field("Activer Fodec"; Rec."Activer Fodec")
            {
                ApplicationArea = All;

            }

            field("Fodec Charge Item"; Rec."Fodec Charge Item")
            {
                ApplicationArea = All;

            }

            field("Taux Fodec"; Rec."Taux Fodec")
            {
                ApplicationArea = All;

            }
            field("Item Charge Cur. Factor Adj"; Rec."Item Charge Cur. Factor Adj")
            {
                ApplicationArea = all;
            }
            field("Vendor Cur. Factor Adj"; Rec."Vendor Cur. Factor Adj")
            {
                ApplicationArea = all;
            }

            field("ST Auto-Run Bill Not Received"; Rec."ST Auto-Run Bill Not Received")
            {
                ApplicationArea = All;
                ToolTip = 'Spécifie si le batch FNP sera lancer automatiquement ou non.';
            }
            group("DLT LC Setup")//Lettre Credit
            {
                CaptionML = ENU = 'Setup Lettre Of Cr.', FRA = 'Paramètres lettre de crédit';
                field("DLT Enable Lettre Of Cr."; REC."ST Enable Lettre Of Cr.")
                {
                    ApplicationArea = all;
                }
            }

        }

    }

    actions
    {

    }

}
