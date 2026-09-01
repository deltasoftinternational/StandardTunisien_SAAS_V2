tableextension 71026 "ST CompanyInformationExt" extends "Company Information" //79
{
    fields
    {
        field(71000; "STInvoice Header Picture"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(71001; "STInvoice Footer Picture"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(71002; "STNombre cheque"; Integer)
        {
            Caption = 'Nombre chèque';
            DataClassification = ToBeClassified;
        }
        field(71003; "STNombre traite"; Integer)
        {
            Caption = 'Nombre traite';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}