report 70061 "BactchDueDate"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Permissions = tabledata "Detailed Cust. Ledg. Entry" = RIMD;
    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            trigger OnAfterGetRecord()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
            begin
                CustLedgerEntry.Reset();
                CustLedgerEntry.Get("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.");
                "Initial Entry Due Date" := CustLedgerEntry."Due Date";
                Modify();

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}