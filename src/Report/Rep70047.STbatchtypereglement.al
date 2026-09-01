report 70047 "STbatch type reglement"
{


    Permissions = TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Detailed Vendor Ledg. Entry" = rimd;
    ApplicationArea = All;
    dataset
    {


        dataitem("Payment Header"; "Payment Header")
        {
            dataitem("Detailed Cust. Ledg. Entry"; 379)
            {


                trigger OnAfterGetRecord();
                begin
                    customer.Reset();
                    customer.SetRange("No.", "Customer No.");
                    if customer.FindFirst() then begin
                        "Detailed Cust. Ledg. Entry"."STCustomer Posting Group" := customer."Customer Posting Group";
                        "Detailed Cust. Ledg. Entry".MODIFY();
                    end;
                end;

            }
            dataitem("Detailed Vendor Ledg. Entry"; 380)
            {
                DataItemLinkReference = "Payment Header";
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord();
                begin
                    vendor.Reset();
                    vendor.SetRange("No.", "Vendor No.");
                    if vendor.FindFirst() then begin
                        "Detailed Vendor Ledg. Entry"."STVendor Posting Group" := vendor."Vendor Posting Group";
                        "Detailed Vendor Ledg. Entry".MODIFY();
                    end;
                end;

            }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLinkReference = "Payment Header";
                DataItemLink = "No." = field("No.");
                trigger OnAfterGetRecord()
                begin
                    paymentH.Reset();
                    cust.Reset();
                    vend.Reset();
                    cust.SetRange("No.", "Account No.");
                    vend.SetRange("No.", "Account No.");
                    if cust.FindFirst() then
                        "Payment Line"."STLibellé" := cust.Name
                    else
                        if vend.FindFirst() then
                            "Payment Line"."STLibellé" := vend.Name;
                    paymentH.SetRange("No.", "No.");
                    if paymentH.FindFirst() then
                        "Payment Line".STType_ED := paymentH.Type_ED;
                    "Payment Line"."STType Règlement" := paymentH."STType Règlement";
                    "Payment Line"."STCréer par" := paymentH."STCréer par";
                    "Payment Line".MODIFY();

                end;
            }
            trigger OnAfterGetRecord();
            begin

                PaymentClass.Reset();
                PaymentClass.SetRange(code, "Payment Class");
                if PaymentClass.FindFirst() then begin
                    "Payment Header"."STType Règlement" := format(PaymentClass.STType_Reg);
                    "Payment Header".type_ED := PaymentClass.STType_ED;
                    "Payment Header"."STCréer par" := UserId;
                    "Payment Header".MODIFY();

                end;
            end;


        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var

        PaymentClass: Record "Payment Class";
        vendor: Record Vendor;
        customer: Record customer;
        paymentH: Record "Payment Header";
        cust: Record Customer;
        vend: Record Vendor;


}

