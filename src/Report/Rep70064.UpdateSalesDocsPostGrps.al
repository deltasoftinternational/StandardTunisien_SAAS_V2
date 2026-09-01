report 71064 "Update Sales Docs Post. Grps."
{
    Caption = 'Modifier groupe compta document vente';
    ProcessingOnly = true;
    Permissions = TableData "Sales Header" = rimd,
                TableData "Sales Line" = rimd,
                TableData "Sales Shipment Header" = rimd,
                TableData "Sales Shipment Line" = rimd;
    ApplicationArea = All;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending);

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending);
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.") order(ascending);
                    DataItemLink = "Order No." = field("Document No."), "Order Line No." = field("Line No.");
                    trigger OnAfterGetRecord()
                    begin
                        "Sales Shipment Line"."VAT Bus. Posting Group" := RecVatBusPostingGroup.Code;
                        "Sales Shipment Line"."VAT %" := "Sales Line"."VAT %";
                        "Sales Shipment Line".Modify();
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    "Sales Line".SuspendStatusCheck(true);
                    "Sales Line".Validate("VAT Bus. Posting Group", RecVatBusPostingGroup.Code);
                    "Sales Line".Modify();
                end;
            }
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = sorting("No.") order(ascending);
                DataItemLink = "Order No." = field("No.");
                trigger OnAfterGetRecord()
                begin
                    "Sales Shipment Header"."VAT Bus. Posting Group" := RecVatBusPostingGroup.Code;
                    "Sales Shipment Header".Modify();
                end;
            }
            trigger OnPreDataItem()
            var
                lSalesLine: Record "Sales Line";
            begin
                if SalesHeader.GetFilter(SalesHeader."No.") = '' then
                    SalesHeader.TestField("No.");
                RecVatBusPostingGroup.get(pVatBusPostingGroup);
                lSalesLine.Reset();
                lSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", SalesHeader."No.");
                lSalesLine.SetFilter("Qty. Invoiced (Base)", '<>%1', 0);
                if lSalesLine.FindFirst() then
                    Error(Txt002);
            end;

            trigger OnAfterGetRecord()
            begin
                if not Confirm(StrSubstNo(Txt001, SalesHeader."No."))
                 then
                    CurrReport.Skip();
                SalesHeader."VAT Bus. Posting Group" := RecVatBusPostingGroup.Code;
                SalesHeader.Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(pVatBusPostingGroup; pVatBusPostingGroup)
                    {
                        Caption = 'Groupe compta. marché TVA';
                        TableRelation = "VAT Business Posting Group".Code;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        pVatBusPostingGroup: Code[20];
        RecVatBusPostingGroup: Record "VAT Business Posting Group";
        Txt001: Label 'Confirmez-vous la mise à jour de la commande %1';
        Txt002: Label 'La commande est déjà facturé';
}
