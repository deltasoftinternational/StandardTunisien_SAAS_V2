report 70056 "Not Invoiced Receipt"
{
    ApplicationArea = All;
    Caption = 'Réceptions non facturées';
    RDLCLayout = './src/report/RDLC/Not Invoiced Receipt.rdl';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(PurchRcptHeader; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("Pay-to Vendor No.");
            RequestFilterFields = "Posting Date", "Pay-to Vendor No.", "Order No.";
            PrintOnlyIfDetail = true;
            column(CaptionVATAmount; CaptionVATAmount)
            { }
            column(DisplayVATAmount; DisplayVATAmount)
            { }
            column(AfficheDetails; AfficheDetails)
            { }
            column(CaptionCout; CaptionCout)
            { }
            column(Titre; Titre)
            { }
            column(NameCompany; company.Name)
            { }
            column(Picture; company.Picture)
            { }
            column(NoDoc; PurchRcptHeader."No.")
            { }
            column(PostingDate; PurchRcptHeader."Posting Date")
            { }
            column(CommandNo; PurchRcptHeader."Order No.")
            { }
            column(VendorNo; PurchRcptHeader."Pay-to Vendor No.")
            { }
            column(VendorName; PurchRcptHeader."Pay-to Name")
            { }
            column(NoDocCaption; FieldCaption(PurchRcptHeader."No."))
            { }
            column(postingDateCaption; CaptionDate)
            { }
            column(CommandNoCaption; FieldCaption(PurchRcptHeader."Order No."))
            { }
            column(VendorNoCaption; FieldCaption(PurchRcptHeader."Pay-to Vendor No."))
            { }
            column(VendorNameCaption; FieldCaption(PurchRcptHeader."Pay-to Name"))
            { }
            dataitem(PurchRcptLine; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Correction = filter(false), "Qty. Rcd. Not Invoiced" = filter(<> 0), "No." = filter(<> ''));

                column(VATAmount; VATAmount)
                { }
                column(NoArticle; PurchRcptLine."No.")
                { }
                column(Description; PurchRcptLine.Description)
                { }
                column(Qty; PurchRcptLine.Quantity)
                { }
                column(UnitCost; PurchRcptLine."Unit Cost (LCY)")
                { }
                column(DecGCoutTot; DecGCoutTot)
                { }
                column(NoArticleCaption; FieldCaption(PurchRcptLine."No."))
                { }
                column(DescriptionCaption; FieldCaption(PurchRcptLine.Description))
                { }
                column(QtyCaption; FieldCaption(PurchRcptLine.Quantity))
                { }
                column(UnitCostCaption; CaptionCU)
                { }

                trigger OnAfterGetRecord()
                begin
                    DecGCoutTot := PurchRcptLine."Qty. Rcd. Not Invoiced" * PurchRcptLine."Unit Cost (LCY)";
                    AmountHT := PurchRcptLine."Unit Cost" * PurchRcptLine.Quantity;
                    DiscountAmount := (AmountHT * PurchRcptLine."Line Discount %") / 100;
                    VATAmount := ((AmountHT - DiscountAmount) * PurchRcptLine."VAT %") / 100;
                end;

            }
        }


    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(option)
                {
                    Caption = 'Options';
                    field(DisplayVATAmount; DisplayVATAmount)
                    {
                        Caption = 'Afficher montant TVA';
                        ApplicationArea = all;
                    }
                    field(AfficheDetails; AfficheDetails)
                    {
                        Caption = 'Afficher  Details';
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        company.Get();
        company.CalcFields(Picture);
    end;

    var
        company: Record "Company Information";
        RecgRcptHeader: Record "Purch. Rcpt. Header";
        IntCount: Integer;
        DecGPrixTot: Decimal;
        DecGCoutTot: Decimal;
        UserMngt: Codeunit "User Setup Management";
        RecLpurchaseHeader: Record "Purchase Header";
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        Print: Boolean;
        AfficheDetails: Boolean;
        DisplayVATAmount: Boolean;
        VATAmount: Decimal;
        DiscountAmount: Decimal;
        AmountHT: Decimal;
        Titre: Label 'Lignes réceptions non facturées';
        CaptionFRS: Label 'Code Fournisseur';
        CaptionFRSNAME: Label 'Nom Fournisseur';
        CaptionReception: Label 'N° reception';
        CaptionPostingDate: Label 'Date de comptabilisation';
        CaptionOrderNo: Label 'N° commande';
        CaptionItemNo: Label 'N° Article';
        CaptionDesignation: Label 'Désignation';
        CaptionQty: Label 'Quantité';
        CaptionCoutU: Label 'Prix Unitaire';
        CaptionMontant: Label 'Montant';
        CaptionCout: Label 'Cout total';
        CaptionDate: Label 'Date';
        CaptionCU: Label 'Coût Unit';
        CaptionVATAmount: Label 'Montant TVA';
}
