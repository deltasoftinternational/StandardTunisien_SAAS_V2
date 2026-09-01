tableextension 71017 "STNo. Series LineTabExt" extends "No. Series Line" //309
{
    fields
    {
        field(71000; "STCoffre"; Code[20])
        {
            Caption = 'Coffre';
            DataClassification = ToBeClassified;
            TableRelation = "ST Coffre";
        }
    }

}