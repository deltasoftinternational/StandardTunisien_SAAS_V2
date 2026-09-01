tableextension 70046 "Vendor Ledger Entry" extends "Vendor Ledger Entry"//25
{
    fields
    {
        field(70000; "STOrder No."; Code[20])
        {
            Caption = 'N° commande';
            DataClassification = ToBeClassified;
        }
        field(70001; "STPayment Method Code"; Code[10])
        {
            Caption = 'Mode de règlement';
            TableRelation = "Payment Method".Code;
            Editable = false;
        }
        field(70002; "STPayment terms Code"; Code[10])
        {
            Caption = 'Payment Terms code';
            TableRelation = "Payment Terms";
            Editable = false;
        }
        field(70008; STOption; enum "ST Option step")
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Option';
        }
    }
}
