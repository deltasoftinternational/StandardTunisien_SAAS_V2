report 71052 "Bulletin de Dépense Espèce"
{
    // version ENCAISSEMENT-DECAISSEMENT
    caption = 'Bulletin de Dépense';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Bulletin de Dépense.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            RequestFilterFields = "No.";


            dataitem("Payment Line"; 10866)
            {
                DataItemLink = "No." = FIELD("No.");
                RequestFilterFields = "No.";
                column(NoPayment; "Payment Line"."No.")
                {
                }
                column(NoCheque; "Payment Line"."External Document No.")
                {
                }
                column(Banque; Bank)
                {
                }
                column(Montant; "Payment Line".Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Motif; "Payment Line".STCommentaires)
                {
                }
                column(ModeReglement; Reglment)
                {
                }
                column(bnef; pLibelle)
                {
                }
                column(MntTTLettre; TexteLettre)
                {
                }
                column(Amount; CumulMntLCY)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Caption000; Caption000)
                {
                }
                column(Caption001; Caption001)
                {
                }
                column(Caption100; Caption100)
                {
                }
                column(Caption101; Caption101)
                {
                }
                column(Logo; companyInfo.Picture)
                {

                }
                trigger OnAfterGetRecord();
                begin
                    //IF SalesHeader.GET(SalesHeader."Document Type"::Order,"Commande No.") THEN
                    //BEGIN
                    // pBillToCustomerNo := SalesHeader."Bill-to Customer No.";
                    // pBillToCustomerName := SalesHeader."Bill-to Name";
                    // pSellToCustomerNo := SalesHeader."Sell-to Customer No.";
                    // pSellToCustomerName := SalesHeader."Sell-to Customer Name";
                    // IF pBillToCustomerNo = pSellToCustomerNo THEN
                    //   pLibelle := pBillToCustomerNo +' - ' +pBillToCustomerName
                    // ELSE
                    //  pLibelle := pBillToCustomerNo +' - ' +pBillToCustomerName + ' P/C '+pSellToCustomerName;
                    //END
                    //ELSE
                    pLibelle := "Payment Line"."Account No." + ' - ' + "Payment Line".STLibellé;

                    CumulMntLCY += ABS("Amount (LCY)");
                    IF RecGBanque.GET("Account No.") THEN;
                    CLEAR(RecCoffre);
                    IF RecCoffre.GET(RecGPaymentHeader.STCoffre) THEN;

                    currency.Reset();
                    currency.SetRange(Code, "Currency Code");
                    if currency.FindFirst() then
                        dev := currency."ISO Code";
                    IF RecGPaymentHeader.GET("No.") THEN;


                    // Get Bank
                    CLEAR(RecBankAccount);
                    RecBankAccount.SETFILTER(RecBankAccount.Code, '%1', "Bank Account Code");
                    RecBankAccount.SETRANGE("Customer No.", "Payment Line"."Account No.");
                    IF RecBankAccount.FINDFIRST() THEN;
                    ;



                    // DELTA 01
                    TexteLettre := '';
                    PaymentHeader.GET("No.");
                    Reglment := PaymentHeader."STType Règlement";
                    Bank := PaymentHeader."Bank Name";

                    if (dev = '') or (dev = 'TND') then begin
                        CU_MntLettre."Montant en texte"(TexteLettre, ABS(CumulMntLCY));
                        CU_MntLettre."Montant en texte"(TexteLettre, ABS(PaymentHeader.Amount));
                    end
                    else begin
                        CU_MntLettre."Montant en texteDevise"(TexteLettre, ABS(CumulMntLCY), dev);
                        CU_MntLettre."Montant en texteDevise"(TexteLettre, ABS(PaymentHeader.Amount), dev);
                    end;
                end;

                trigger OnPreDataItem()

                begin
                    companyInfo.get();
                    companyInfo.CalcFields(Picture);
                end;
            }
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
        RecGBanque: Record Vendor;
        RecGPaymentHeader: Record "Payment Header";
        RecCoffre: Record "ST Coffre";
        RecBankAccount: Record "Customer Bank Account";
        CU_MntLettre: Codeunit "ST MontantTouteLettre";
        TexteLettre: Text;
        Command: Record "Sales Header";
        BNEF: Text;
        PaymentHeader: Record "Payment Header";
        Reglment: Text;
        Montant: Decimal;
        CumulMntLCY: Decimal;
        SalesHeader: Record "Sales Header";
        pBillToCustomerNo: Code[10];
        pBillToCustomerName: Text;
        pSellToCustomerNo: Code[10];
        pSellToCustomerName: Text;
        pLibelle: Text;
        Bank: Text;
        Caption000: Label 'BULLETIN DE DEPENSES';
        Caption001: Label 'BULLETIN DE DEPENSES';
        Caption100: Label 'N° de chèque';
        Caption101: Label 'N° d''effet';
        currency: Record Currency;
        dev: Text[10];
        companyInfo: Record "Company Information";
}

