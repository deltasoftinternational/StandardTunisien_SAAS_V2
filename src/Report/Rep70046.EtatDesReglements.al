report 70046 "Etat Des Reglements"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Etat de caisse';
    RDLCLayout = './src/report/RDLC/EtatDesReglements.rdl';

    dataset
    {



        dataitem("Payment Line"; "Payment Line")
        {
            RequestFilterFields = "Posting Date", STCoffre, "Status No.";
            DataItemTableView = where("Copied To No." = filter(''), "Created from No." = filter(''));
            column(paymentLineNo; "Account No.")
            {

            }
            column(name; "STLibellé")
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Amount; Amount)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(STOrder_No_; "STOrder No.")
            {

            }
            column(TypeReglement; "STType Règlement")
            {

            }
            column(Bank_Name; "Bank Account Name")
            {

            }
            column(paymentLine; "Due Date")
            {

            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column("Créer_par"; paymentheader."STCréer par")
            {

            }
            column(Status_Name; "Status Name")
            {

            }
            column(Posted; Posted)
            {

            }
            column(paymentClass_Type_ED; STType_ED)
            {

            }
            column(recCompanyInfo; recCompanyInfo.Picture)
            {

            }
            column(RecGCompanyInfoCity; recCompanyInfo.City)
            {
            }
            column(Phone; recCompanyInfo."Phone No.")
            {

            }
            column(Fax; recCompanyInfo."Fax No.")
            {

            }
            column(MatriculeFiscal; recCompanyInfo."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            column(recUserSetup; recUserSetup.STCoffre)
            {

            }
            column(Payment_Class; "Payment Class")
            {

            }
            column(Copied_To_No; "Copied To No.")
            {

            }
            column(filtreDate; filtreDate)
            {

            }

            trigger OnAfterGetRecord()
            var
                PaytStep: Record "Payment Step";
            begin
                paymentheader.Reset();
                recUserSetup.Reset();
                recUserSetup.Get(UserId);
                paymentheader.SetRange("No.", "No.");
                if paymentheader.FindFirst() then;

                PaytStep.Reset();
                PaytStep.SetRange(PaytStep."Payment Class", paymentheader."Payment Class");
                PaytStep.SetRange(PaytStep."Next Status", paymentheader."Status No.");
                IF PaytStep.FindFirst() THEN
                    if PaytStep.STOption = PaytStep.STOption::Cancel then
                        CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                recCompanyInfo.Get();
                recCompanyInfo.CalcFields(Picture);
                TXTADRESSE := recCompanyInfo.Address + ' ' + recCompanyInfo.City + ' ' + recCompanyInfo."Post Code";
                filtreDate := "Payment Line".GetFilters();

                IF banque <> '' THEN
                    SETFILTER("Banque Societe", '%1', banque);

                IF StatusNo <> 0 THEN
                    SETFILTER("Status No.", '%1', StatusNo);
            end;
        }

    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(banque; banque)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Bank',
                                       FRA = 'Caisse';
                        TableRelation = "Bank Account";
                    }
                    field(StatusNo; StatusNo)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Status No.',
                                       FRA = 'Status No.';

                    }

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

        paymentheader: Record "Payment Header";
        recUserSetup: Record "User Setup";
        recCompanyInfo: Record "Company Information";
        TXTADRESSE: Text;
        filtreDate: Text;
        banque: Code[20];
        StatusNo: Integer;

}