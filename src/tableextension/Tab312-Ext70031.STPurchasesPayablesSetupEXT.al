tableextension 70031 "ST PurchasesPayablesSetup EXT" extends "Purchases & Payables Setup" //312
{
    fields
    {


        field(50003; "Fodec Apply for Vendor Posting"; Boolean)
        {
            CaptionML = ENU = 'Fodec Apply for Vendor Posting',
                        FRA = 'Appliquer Fodec Par Groupe Fr.';

        }
        field(50004; "Fodec Charge Item"; Code[20])
        {
            Caption = 'Frais annexe Fodec';
        }
        field(50016; "Activer Fodec"; Boolean)
        {

        }
        field(50017; "Taux Fodec"; Decimal)
        {

        }
        field(51004; "ST Enable Lettre Of Cr."; Boolean)//Lettre Credit
        {
            CaptionML = ENU = 'Enable Lettre Of Cr.', FRA = 'Activer flux lettre de crédit';
        }
        field(51005; "ST Auto-Run Bill Not Received"; Boolean)
        {
            CaptionML = ENU = 'Auto-Launch Bill Not Received', FRA = 'Lancer Automatiquement FNP';
            DataClassification = CustomerContent;
        }
        field(51006; "Vendor Cur. Factor Adj"; Code[20])
        {
            Caption = 'Fournisseur ajustement taux de change';
            TableRelation = Vendor;
        }
        field(51007; "Item Charge Cur. Factor Adj"; Code[20])
        {
            Caption = 'Frais annexe ajustement taux de change';
            TableRelation = "Item Charge";
        }
    }

    var
        myInt: Integer;
}