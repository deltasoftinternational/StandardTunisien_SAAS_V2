tableextension 70018 STGLAccountTabExt extends "G/L Account"
{
    fields
    {
        field(70011; "Net Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Debit Amount" where("G/L Account No." = field("No."),
                                                                "G/L Account No." = field(filter(Totaling)),
                                                                "Business Unit Code" = field("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                "Posting Date" = field(FILTER("Date Filter"))));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70010; "Net Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                 "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                 "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                 "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                 "Posting Date" = field(FILTER("Date Filter")),
                                                                 "Dimension Set ID" = FIELD("Dimension Set ID Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70012; "Due Date Mandatory Gen Journal"; Boolean)
        {
            Caption = 'Date d''échéance obligatoire feuille comptable';

        }
        field(70013; "Net Balance (LCY)"; Decimal)
        {

            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        //"Posting Date"=field(upperlimit("Date Filter")),
                                                        "Posting Date" = field("Date Filter")
                                                       // "Vehicle Serial No." = field("Vehicle Serial No. Filter"),
                                                       // "Vehicle Accounting Cycle No." = field("Vehicle Acc. Cycle No. Filter"),
                                                       //  "Source Type" = field("Source Type Filter"),
                                                       // "Source No." = field("Source No. Filter")
                                                       ));
            Caption = 'Solde période DS';
            Editable = false;
            FieldClass = FlowField;

        }

    }
}
