tableextension 71011 "STVendorTabEXT" extends Vendor //23
{
    fields
    {
        // Add changes to table fields here
        field(71000; STCIN; Boolean)
        {
            Caption = 'CIN';
            DataClassification = CustomerContent;

        }

        field(71001; "STCode Retenue a la Source"; Code[10])
        {
            Caption = 'Code retenue à la source';
            TableRelation = "ST Groupe retenue".STCode;
            DataClassification = CustomerContent;

        }
        field(71002; "STExonoré de la R.S"; Boolean)
        {
            Caption = 'Exonoré de la R.S';
            DataClassification = CustomerContent;

        }
        field(71003; "Execute FNP"; Boolean)
        {
            Caption = 'Exécuter FNP';
            DataClassification = CustomerContent;
        }
    }


}