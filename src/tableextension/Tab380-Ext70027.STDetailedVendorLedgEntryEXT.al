tableextension 71027 "ST DetailedVendorLedgEntryEXT" extends "Detailed Vendor Ledg. Entry" //380
{
    fields
    {
        field(71000; "STDate Filter"; Date)
        {
            CaptionML = ENU = 'Filtre Date',
                        FRA = 'Date Filtre';
            Description = 'DELTA MM 13-07-18';
            FieldClass = FlowFilter;
        }
        field(71001; "STVendor Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Customer Posting Group',
                        FRA = 'Groupe compta. fournisseur';
            Description = 'DELTA MM 13-07-18';
            Editable = false;
            TableRelation = "Vendor Posting Group";
        }
        field(71002; "STOrder No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N° commande';

        }
        field(71006; "STPayment Method Code"; Code[10])
        {
            Caption = 'Mode de règlement';
            TableRelation = "Payment Method".Code;
            Editable = false;
        }
        field(71008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }
    }

    var
        myInt: Integer;
}