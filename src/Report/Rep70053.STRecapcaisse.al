report 70053 "ST Recap caisse"
{

    // DELTA 01 AZ (04-12-18) : Fix Wrong Invoice No.
    // Meg01.00 RZ (06-08-18): Existing Layout Modification.(ALPTY-000040)
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Recapcaisse.rdl';
    Caption = 'Récap caisse';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Payment Line"; "Payment Line")
        {
            RequestFilterFields = "Payment Class", "Status No.", "Posting Date", "Due Date", "Copied To No.";
            RequestFilterHeading = 'Payment lines';
            column(CompanyInfo3Picture; CompanyInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(USERID; USERID)
            {
            }
            column(Payment_Line__No__; "No.")
            {
            }
            column(Payment_Line__No___Control1120011; "No.")
            {
            }
            column(Payment_Line_Amount; Amount)
            {
            }
            column(Payment_Line__Account_Type_; "Account Type")
            {
            }
            column(Payment_Line__Account_No__; "Account No.")
            {
            }
            column(Payment_Line__Posting_Group_; "Posting Group")
            {
            }
            column(Payment_Line__Due_Date_; "Due Date")
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Payments_LinesCaption; Payments_LinesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payment_Line__No___Control1120011Caption; FIELDCAPTION("No."))
            {
            }
            column(Payment_Line_AmountCaption; FIELDCAPTION(Amount))
            {
            }
            column(Payment_Line__Account_Type_Caption; FIELDCAPTION("Account Type"))
            {
            }
            column(Payment_Line__Account_No__Caption; FIELDCAPTION("Account No."))
            {
            }
            column(Payment_Line__Posting_Group_Caption; FIELDCAPTION("Posting Group"))
            {
            }
            column(Payment_Line__Due_Date_Caption; Payment_Line__Due_Date_CaptionLbl)
            {
            }
            column(Payment_Line__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Libelle; "Payment Line".STCommentaires)
            {
            }
            column(No; Paymentheader."Account No.")
            {
            }
            column(NameBank; namebank)
            {
            }
            column(PostingDate; "Payment Line"."Posting Date")
            {
            }
            column(Ext; "Payment Line"."External Document No.")
            {
            }
            column(Devise; "Payment Line"."Currency Code")
            {
            }
            column(MontantDS; "Payment Line"."Amount (LCY)")
            {
            }
            column(Filtre; Filtre)
            {
            }
            column(Tribanque; Tribanque)
            {
            }
            column(Payment_LineStatusName; "Payment Line"."Status Name")
            {
            }
            column(Code_Compte_BanK; "Payment Line"."Bank Account Code")
            {
            }
            column(DraweeReference_PaymentLine; "Payment Line"."Drawee Reference")
            {
            }
            column(DetailedCustLedgEntry_DocumentNo; DetailedCustLedgEntry."Document No.")
            {
            }
            column(DetailedCustLedgEntry_DocumentNo_Caption; DetailedCustLedgEntry.FIELDCAPTION("Document No."))
            {
            }
            column(USERFILTER; USERFILTER)
            {
            }
            column(PaymentClass_PaymentLine; "Payment Line"."Payment Class")
            {
            }
            column(PaymentClass_Name; PaymentClass.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //<< DELTA RB
                PaymentClass.GET("Payment Line"."Payment Class");
                PaymentStatus.GET("Payment Line"."Payment Class", "Payment Line"."Status No.");
                IF PaymentStatus."ST Status" = PaymentStatus."ST Status"::"In Progress " THEN
                    CurrReport.SKIP();
                IF DocumentDate <> 0D THEN BEGIN
                    Paymentheader.RESET();
                    Paymentheader.GET("Payment Line"."No.");
                    IF Paymentheader."Document Date" <> DocumentDate THEN
                        CurrReport.SKIP();
                END;
                //>> DELTA RB
                IF Paymentheader.GET("Payment Line"."No.") THEN BEGIN
                    IF BankAccount.GET(Paymentheader."Account No.") THEN
                        namebank := BankAccount.Name;
                    USER := Paymentheader."STCréer par";
                END;

                IF USERFILTER <> '' THEN
                    IF USER <> USERFILTER THEN
                        CurrReport.SKIP();
                //>>DELTA 01
                //BEFORE DetailedCustLedgEntry.RESET;
                CLEAR(DetailedCustLedgEntry);
                //<<DELTA 01
                DetailedCustLedgEntry.SETRANGE("Document Type", DetailedCustLedgEntry."Document Type"::Invoice);
                DetailedCustLedgEntry.SETRANGE("Document No.", "Payment Line"."Document No.");
                //<<DELTA
                DetailedCustLedgEntry.SETRANGE("Customer No.", "Payment Line"."Account No.");
                //>>DELTA
                IF DetailedCustLedgEntry.FINDFIRST() THEN;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Tri par banque"; Tribanque)
                {
                    ApplicationArea = All;
                }
                field(USERFILTER; USERFILTER)
                {
                    Caption = 'Code utilisateur';
                    TableRelation = "User Setup"."User ID";
                    ApplicationArea = All;
                }
                field(DocumentDate; DocumentDate)
                {
                    Caption = 'Date document';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //Meg01.00+
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
        //Meg01.00-
        USERFILTER := USERID;
        "Payment Line".SETFILTER("Posting Date", FORMAT(WORKDATE()));
    end;

    trigger OnPreReport()
    begin
        Filtre := "Payment Line".GETFILTERS;
    end;

    var
        LastFieldNo: Integer;
        Payments_LinesCaptionLbl: Label 'Journal de caisse';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Payment_Line__Due_Date_CaptionLbl: Label 'Due Date';
        Paymentheader: Record "Payment Header";
        BankAccount: Record "Bank Account";
        namebank: Text[100];
        s: Text[30];
        Filtre: Text[250];
        Tribanque: Boolean;
        CompanyInfo: Record "Company Information";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        USER: Code[50];
        USERFILTER: Code[50];
        PaymentClass: Record "Payment Class";
        PaymentStatus: Record "Payment Status";
        DocumentDate: Date;
}

