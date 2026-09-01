tableextension 71020 "ST DetCustLedgEntryTabEXT" extends "Detailed Cust. Ledg. Entry" //379
{
    fields
    {
        // Add changes to table fields here
        field(70000; "STOrder No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'N° commande';

        }

        field(70001; STOuvert; Boolean)
        {
            Caption = 'Ouvert';
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry".Open where("Entry No." = field("Cust. Ledger Entry No.")));
            Editable = false;

        }
        field(70003; "STDate Filter"; Date)
        {
            Description = 'DELTA SN 08-02-18';
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(70004; "STCustomer Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Customer Posting Group',
                        FRA = 'Groupe compta. client';
            Description = 'DELTA SN 05-12-17';
            Editable = false;
            FieldClass = Normal;
            TableRelation = "Customer Posting Group";
        }
        field(70005; DGB; Boolean)
        {
            Description = 'DELTA AK';
        }
        field(70006; "STPayment Method Code"; Code[10])
        {
            Caption = 'Mode de règlement';
            TableRelation = "Payment Method".Code;
            Editable = false;
        }
        field(70008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }

    }


}