query 70000 "DETAILEDVENDORLEDGERENTRY"
{
    Caption = 'DETAILEDVENDORLEDGERENTRY';


    elements
    {
        dataitem(Vendor_Ledger_Entry; "Detailed Vendor Ledg. Entry")
        {

            column(STVendor_Posting_Group; "STVendor Posting Group")
            {

            }

            column(Vendor_No; "Vendor No.")
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

            filter(EntryType; "Entry Type")
            {

            }
            filter(STDate_Filter; "STDate Filter")
            {

            }

        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
