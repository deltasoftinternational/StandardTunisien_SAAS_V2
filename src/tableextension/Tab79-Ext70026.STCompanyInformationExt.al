tableextension 70026 "ST CompanyInformationExt" extends "Company Information" //79
{
    fields
    {
        field(70000; "STInvoice Header Picture"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "STInvoice Footer Picture"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "STNombre cheque"; Integer)
        {
            Caption = 'Nombre chèque';
            DataClassification = ToBeClassified;
        }
        field(70003; "STNombre traite"; Integer)
        {
            Caption = 'Nombre traite';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}