report 70057 "Shipment Not Invoiced"
{
    // 
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Shipment Not Invoiced.rdl';

    Caption = 'Expéditions ventes non facturées';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Shipment Line"; 111)
        {
            DataItemTableView = WHERE(
                                      Correction = FILTER(false),
                                      Type = FILTER(<> ''),
                                                            "Qty. Shipped Not Invoiced" = FILTER(> 0));
            PrintOnlyIfDetail = false;
            column(picture; CompanyInfo.Picture)
            {
                IncludeCaption = true;
            }
            column(DocumentNo_SalesShipmentLine; "Sales Shipment Line"."Document No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate_SalesShipmentLine; "Sales Shipment Line"."Posting Date")
            {
                IncludeCaption = true;
            }
            column(ShipmentDate_SalesShipmentLine; "Sales Shipment Line"."Shipment Date")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerNo_SalesShipmentLine; "Sales Shipment Line"."Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(No_SalesShipmentLine; "Sales Shipment Line"."No.")
            {
                IncludeCaption = true;
            }
            column(Description_SalesShipmentLine; "Sales Shipment Line".Description)
            {
                IncludeCaption = true;
            }
            column(UnitofMeasure_SalesShipmentLine; "Sales Shipment Line"."Unit of Measure Code")
            {
                IncludeCaption = true;
            }
            column(QtyShippedNotInvoiced_SalesShipmentLine; "Sales Shipment Line"."Qty. Shipped Not Invoiced")
            {
                IncludeCaption = true;
            }
            column(MontantDS; MontantDS)
            {
            }
            /*column(ShipmentNotToInvoice_SalesShipmentLine;"Sales Shipment Line"."Shipment Not To Invoice")
            {
                IncludeCaption = true;
            }*/
            column(UnitPrice; UnitPrice)
            {
                CaptionML = ENU = 'Unit Cost ', FRA = 'Coût Unitaire ';
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(LineDiscount_SalesShipmentLine; "Sales Shipment Line"."Line Discount %")
            {
                IncludeCaption = true;
            }
            column(Amount; Amount)
            {
            }
            /*column(NotToInvoicReasonCode_SalesShipmentLine;"Sales Shipment Line"."Not To Invoice Reason Code")
            {
                IncludeCaption = true;
            }*/
            column(Titre; Titre)
            {
            }
            column(CustomerNoun; CustomerNoun)
            {
            }
            column(DesignationCodeMotif; DesignationCodeMotif)
            {
            }
            /*column(InvoicingTerm;Customer."Invoicing Term")
            {
                
                CaptionML = ENU=' ,Per Customer Order,Per Shipment,Monthly,Daily,All',
                                  FRA=' ,Par commande client,Par expÚdition,Mensuel,Journalier,Tous';
                OptionMembers = " ","Per Customer Order","Per Shipment",Monthly,Daily,All;
            }*/
            /* column(CustomerType;Customer."Customer Type")
             {
             }*/

            trigger OnAfterGetRecord();
            var
                LSalesHeader: Record "Sales Header";
            begin
                SalesLine.RESET();
                UnitPrice := 0;
                Amount := 0;
                MontantDS := 0;
                CurrencyCode := '';
                SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE("Document No.", "Sales Shipment Line"."Order No.");
                SalesLine.SETRANGE("Line No.", "Sales Shipment Line"."Order Line No.");
                IF SalesLine.FINDSET() THEN BEGIN
                    UnitPrice := SalesLine."Unit Price";
                    CurrencyCode := SalesLine."Currency Code";
                    Amount := ("Sales Shipment Line"."Qty. Shipped Not Invoiced" * UnitPrice) * (1 - ("Sales Shipment Line"."Line Discount %" / 100));
                END;
                IF CurrencyCode <> '' THEN BEGIN
                    LSalesHeader.SETRANGE("Document Type", LSalesHeader."Document Type"::Order);
                    LSalesHeader.SETRANGE("No.", "Sales Shipment Line"."Order No.");
                    IF LSalesHeader.FINDFIRST() THEN
                        MontantDS := Amount * LSalesHeader."Currency Factor";
                END
                ELSE
                    MontantDS := Amount;

                Customer.RESET();
                CustomerNoun := '';
                Customer.SETRANGE("No.", "Sales Shipment Line"."Sell-to Customer No.");
                IF Customer.FINDSET() THEN
                    CustomerNoun := Customer.Name;

                SalesShipmentHeader.RESET();
                /*DesignationCodeMotif:='';
                SalesShipmentHeader.SETRANGE("No.", "Sales Shipment Line"."Document No.");
                IF SalesShipmentHeader.FINDSET THEN BEGIN
                  SalesShipmentHeader.CALCFIELDS("Reason Code Description");
                  DesignationCodeMotif:= SalesShipmentHeader."Reason Code Description";
                END;*/
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(option1)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(Desc_Amount; ENU = 'Amount', FRA = 'Montant')
        label(Desc_AmountLCY; ENU = 'Amount LCY',
                             FRA = 'Montant DS')
        label(Desc_UnitPrice; ENU = 'Unit Price',
                             FRA = 'Prix unitaire')
        label(Desc_CurrencyCode; ENU = 'Currency Code',
                                FRA = 'Code devise')
        label(Desc_CustomerNoun; ENU = 'Customer Name',
                                FRA = 'Nom client')
        label(Desc_DesignationCodeMotif; ENU = 'Reason Description',
                                        FRA = 'DÚsignation motif')
        label(Desc_InvoicngTerm; ENU = 'Invoicing Term',
                                FRA = 'Regroupement de facture')
        label(Desc_CustomerType; ENU = 'Customer Type',
                                FRA = 'Type client')
    }

    trigger OnPreReport();
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        SalesLine: Record "Sales Line";
        UnitPrice: Decimal;
        CurrencyCode: Code[10];
        Amount: Decimal;
        MontantDS: Decimal;
        Titre: Label 'Expéditions vente non facturés'/*,FRA='ExpÚditions ventes non facturÚes'*/;
        CustomerNoun: Text;
        Customer: Record Customer;
        SalesShipmentHeader: Record "Sales Shipment Header";
        DesignationCodeMotif: Text;
}

