table 71002 "ST Mandatory Dimension"
{
    DataPerCompany = false;
    Caption = 'Axe analytique obligatoire';
    LookupPageID = "ST Mandatory Dimension";
    DrillDownPageID = "ST Mandatory Dimension";

    FIELDS
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Id Table';
            TableRelation = AllObj."Object ID" where("Object Type" = CONST(Table));
            trigger OnLookup()
            begin
                ConfigValidateMgt.LookupTable("Table Id");
                if "Table Id" <> 0 then
                    Validate("Table Id");
                CalcFields("Table Name")
            end;

            trigger OnValidate()
            begin
                if ConfigMgt.IsSystemTable("Table Id") then
                    Error('Table système', "Table Id");
                CalcFields("Table Name");
            end;
        }

        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Code axe';
            TableRelation = Dimension;
        }

        field(3; "Table Name"; Text[50])
        {
            Caption = 'Nom Table';

            Editable = false;
        }
    }




    keys
    {
        key(Key1;
        "Table ID", "Dimension Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure CheckDimension(TableId: Integer; "No.": Code[20])
    var
        lMandatoryDimension: record "ST Mandatory Dimension";
        lDefaultDimension: record "Default Dimension";
        Text001: Label 'Veuillez selectionner l''axe analytique %1 avant de valider la fiche';
        Text002: Label 'Axe analytique %1 manquant';
    BEGIN
        lMandatoryDimension.RESET();
        lMandatoryDimension.SETRANGE("Table ID", TableId);
        IF lMandatoryDimension.FINDSET() THEN
            REPEAT
                IF NOT lDefaultDimension.GET(TableId, "No.", lMandatoryDimension."Dimension Code") THEN
                    ERROR(Text001, lMandatoryDimension."Dimension Code")
                ELSE
                    IF lDefaultDimension."Dimension Value Code" = '' THEN
                        ERROR(Text002, lMandatoryDimension."Dimension Code");
            UNTIL lMandatoryDimension.NEXT() = 0;
    END;


    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";

}