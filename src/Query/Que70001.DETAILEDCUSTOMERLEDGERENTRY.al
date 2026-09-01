query 71001 "DETAILEDCUSTOMERLEDGERENTRY"
{
    Caption = 'DETAILEDVENDORLEDGERENTRY';


    elements
    {
        dataitem(Cust_Ledger_Entry; "Detailed Cust. Ledg. Entry")
        {

            column(STCuster_Posting_Group; "STCustomer Posting Group")
            {

            }

            column(CustomerNo; "Customer No.")
            {
            }
            column(Debit_Amount__LCY_; "Debit Amount (LCY)")
            {
                Method = Sum;
            }
            column(Credit_Amount__LCY_; "Credit Amount (LCY)")
            {
                Method = sum;
            }
            column(year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Posting_Date; "Posting Date")
            {

            }
            filter(STDate_Filter; "STDate Filter")
            {

            }

            filter(EntryType; "Entry Type")
            {

            }


        }

    }

    trigger OnBeforeOpen()
    begin

    end;


}
