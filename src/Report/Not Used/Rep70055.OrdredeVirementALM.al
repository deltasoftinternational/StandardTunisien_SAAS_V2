report 70055 "Ordre de Virement ALM"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/Ordre de Virement ALM.rdl';
    Caption = 'Ordre de Virement ALM';
    //Not Used UsageCategory = ReportsAndAnalysis;
    //Not Used ApplicationArea = All;

    dataset
    {
        dataitem("Payment Line"; 10866)
        {
            // column(FooterTxt; FooterTxt)
            // {
            // }
            column(NoCaption_Line; NoCaptionG)
            {
            }
            column(NameCaption_Line; NameCaptionG)
            {
            }
            column(AccountName_Line; "Drawee Reference")
            {
            }
            column(PaymentHeaderG_CurrCode; PaymentHeaderG."Currency Code")
            {
            }
            column(SWIFTCode_PaymentLine; "Payment Line"."SWIFT Code")
            {
            }
            column(IBAN_PaymentLine; "Payment Line".IBAN)
            {
            }
            column(BankBranchNo_Header; HeaderBankAccG."Bank Branch No.")
            {
            }
            column(TransitNo_Header; HeaderBankAccG."Transit No.")
            {
            }
            column(AgencyCode_Header; HeaderBankAccG."Agency Code")
            {
            }
            column(BankAccountNo_Header; HeaderBankAccG."Bank Account No.")
            {
            }
            column(RIBKey_Header; HeaderBankAccG."RIB Key")
            {
            }
            column(localCurrency; RecGPaymentHeader."Currency Code")
            {
            }
            column(CumulMnt; CumulMnt)
            {
            }
            column(CheckNo; CheckNo)
            {
            }
            column(AmountDS; "Payment Line"."Amount (LCY)")
            {
            }

            column(numFournisseur; GVendor."No.")
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(NotePaiementSuffixe; NotePaiementSuffixe)
            {
            }
            column(NotePaiementPrefixe; NotePaiementPrefixe)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(NomUtilisateur; RecUser."Full Name")
            {
            }
            column(Logo; Rec_Company.Picture)
            {
            }
            column(CompanyName; Rec_Company.Name)
            {
            }
            column(CompanyAddress; Rec_Company.Address)
            {
            }
            column(City; Rec_Company.City)
            {
            }
            column(RibKey; RecGPaymentHeader."Bank Branch No." + RecGPaymentHeader."Agency Code" + RecGPaymentHeader."Bank Account No." + FORMAT(RecGPaymentHeader."RIB Key"))
            {
            }
            column(BankName; RecGPaymentHeader."Bank Name")
            {
            }
            column(PostingDate; RecGPaymentHeader."Posting Date")
            {
            }
            column(FooterDate; RecGPaymentHeader."Posting Date")
            {
            }
            column("TypeRèglement_PaymentHeader"; RecGPaymentHeader."Payment Class")
            {
            }
            // column(CreatedBy; RecGPaymentHeader."Created By")
            // {
            // }
            column(LCYAmount; RecGPaymentHeader."Amount (LCY)")
            {
            }
            column(Typepaiement_PaymentHeader; RecGPaymentHeader."Payment Class")
            {
            }
            column(BankBranchNo; RecGPaymentHeader."Bank Branch No.")
            {
            }
            column(AgencyCode; RecGPaymentHeader."Agency Code")
            {
            }
            column(BankAccountNo; RecGPaymentHeader."Bank Account No.")
            {
            }
            column(Type_Reglement; RecGPaymentHeader."Payment Class")
            {
            }
            column(PaymentTitel; RecGPaymentHeader."Payment Class Name")
            {
            }
            column(RIB; IntToTextLeadingZeros("Payment Line"."RIB Key", 2))
            {
            }
            column(codeAgence; "Payment Line"."Agency Code")
            {
            }
            column(codeVille; TransitNoG)
            {
            }
            column(codeEtab; "Payment Line"."Bank Branch No.")
            {
            }
            column(No_PaymentLine; "Payment Line"."No.")
            {
            }
            column("Numéro"; "Payment Line"."No.")
            {
            }
            column(ExternelDoc; "Payment Line"."External Document No.")
            {
            }
            column(DraweeRef; "Payment Line"."Drawee Reference")
            {
            }
            column(BankAccountName; "Payment Line"."Bank Account Name")
            {
            }
            column(BankCity; "Payment Line"."Bank City")
            {
            }
            column(DueDate_PaymentLine; "Payment Line"."Due Date")
            {
            }
            column(Montant; "Payment Line".Amount)
            {
            }
            column(BankAccountNo_PaymentLine; "Payment Line"."Bank Account No.")
            {
            }
            column(BankAccountCode_PaymentLine; "Payment Line"."Bank Account Code")
            {
            }
            column(ExternelDocNo; "Payment Line"."Bank City")
            {
            }
            column(AccountNo_PaymentLine; "Payment Line"."Account No.")
            {
            }
            column(AmountLCY; ABS("Payment Line"."Amount (LCY)"))
            {
            }
            // column(DeductionAmountLCY_PaymentLine; (Evaluate(taux,"Payment Line"."STCode Retenue à la Source") * ("Payment Line"."STAssiette RS"))
            // {
            // }
            column(NameBanque; FORMAT("Payment Line"."Account No."))
            {
            }
            column(RecBankAccountEntete_Name; RecBankAccountEntete.Name)
            {
            }
            column(RecGVendor_Name; RecGVendor.Name)
            {
            }
            column(CityBanque; RecGVendor.City)
            {
            }
            column(NomDeLaBanque; RecBankAccount.Name)
            {
            }
            column(NomeBank; RecBankAccount.Name)
            {
            }
            column(LCYCode; GeneralLedgerSetup."LCY Code")
            {
            }
            column(IsLettrageFound; IsLettrageFound)
            {
            }
            column(Increment; Increment)
            {
            }
            column(P2; Partition2)
            {
            }

            column(TxtReportTitle; TxtReportTitle)
            {
            }
            column(TxtCompanyName; TxtCompanyname)
            {
            }
            column(DeductionLettre; DeductionLettre)
            {
            }
            column(DocLettrer; DocLettrer)
            {
            }
            column(TotalLettre; TotalLettre)
            {
            }
            column(CompteBK; CompteBK)
            {
            }
            column(Bank; Bank)
            {
            }
            column(RIBBK; RIBBK)
            {
            }
            column(NomBk; NomBk)
            {
            }
            column(AddressBk; AddressBk)
            {
            }
            column(ListFactLettr; ListFactLettr)
            {
            }
            column(Vendor_Name; GVendor.Name)
            {
            }
            column(HeaderBankCity; HeaderBankCity)
            {
            }
            column(PaymentPiece; PaymentPiece)
            {
            }
            column(Picture; Rec_Company.Picture)
            {
            }
            column(RecGCompanyInfoCity; Rec_Company.City)
            {
            }
            column(Phone; Rec_Company."Phone No.")
            {

            }
            column(Fax; Rec_Company."Fax No.")
            {

            }
            column(MatriculeFiscal; Rec_Company."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            trigger OnAfterGetRecord();
            begin
                //Meg01.00+
                CLEAR(NoCaptionG);
                CLEAR(NameCaptionG);
                CLEAR(TransitNoG);


                IF PaymentHeaderG.GET("No.") THEN
                    IF PaymentHeaderG."Account Type" = PaymentHeaderG."Account Type"::"Bank Account" THEN
                        IF HeaderBankAccG.GET(PaymentHeaderG."Account No.") THEN;
                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    IF VendorBankAccG.GET("Account No.", "Bank Account Code") THEN
                        TransitNoG := VendorBankAccG."Transit No.";
                END ELSE
                    IF "Account Type" = "Account Type"::Customer THEN
                        IF CustBankAccG.GET("Account No.", "Bank Account Code") THEN
                            TransitNoG := CustBankAccG."Transit No.";

                IF "Account Type" = "Account Type"::Vendor THEN BEGIN
                    NoCaptionG := VendorNoCaption;
                    NameCaptionG := VendorNameCaption;
                END ELSE
                    IF "Account Type" = "Account Type"::Customer THEN BEGIN
                        NoCaptionG := CustNoCaption;
                        NameCaptionG := CustNameCaption;
                    END;

                //Meg01.00-

                IF NOT GVendor.GET("Account No.") THEN
                    CLEAR(GVendor);
                GeneralLedgerSetup.GET();

                RecVendorLedgerEntry.RESET();
                RecVendorLedgerEntry.SETRANGE("Vendor No.", "Payment Line"."Account No.");
                RecVendorLedgerEntry.SETRANGE("Applies-to ID", STRSUBSTNO('%1/%2', "Payment Line"."No.", FORMAT("Payment Line"."Line No.")));
                IsLettrageFound := RecVendorLedgerEntry.FINDFIRST();

                CumulMntLCY += ABS("Amount (LCY)");
                CumulMnt += ABS(Amount); //delta MHF
                Increment += 1;
                RIBBK := '';
                IF RecGVendor.GET("Account No.") THEN;
                IF NOT RecGPaymentHeader.GET("No.") THEN
                    CLEAR(RecGPaymentHeader);

                RecGPaymentHeader.CALCFIELDS("Payment Class Name");

                RecGPaymentHeader.CALCFIELDS(RecGPaymentHeader."Amount (LCY)");
                GPaymentClass.GET(RecGPaymentHeader."Payment Class");
                PaymentTitel := STRSUBSTNO(TxtTitre, GPaymentClass."Payment Method Code");
                //deltasoft MHF
                PaymentMethod.GET(GPaymentClass."Payment Method Code");
                //MESSAGE('%1',PaymentMethod.Description);
                //deltasoft MHF
                PaymentPiece := '';
                CASE GPaymentClass."Payment Type" OF
                    GPaymentClass."Payment Type"::Check:
                        PaymentPiece := CheckNo;
                    GPaymentClass."Payment Type"::Bill:
                        PaymentPiece := TraiteNo;
                    GPaymentClass."Payment Type"::Cash:
                        PaymentPiece := PieceNo;
                    GPaymentClass."Payment Type"::Transfer:
                        PaymentPiece := BankAccountNo;
                END;



                IF RecGPaymentHeader."Account Type" = RecGPaymentHeader."Account Type"::"Bank Account" THEN BEGIN
                    RecBankAccountEntete.SETFILTER(RecBankAccountEntete."No.", '%1', RecGPaymentHeader."Account No.");
                    IF RecBankAccountEntete.FINDFIRST() THEN;
                    BEGIN
                        RIBBK := RecBankAccountEntete."Bank Branch No." + RecBankAccountEntete."Bank Account No.";
                        NomBk := RecBankAccountEntete.Name;
                        AddressBk := RecBankAccountEntete.Address;
                        HeaderBankCity := RecBankAccountEntete.City;
                    END;
                END ELSE
                //
                BEGIN
                    GPaymentClass.RESET();
                    GPaymentClass.GET(RecGPaymentHeader."Payment Class");
                    IF GPaymentClass."Default Bank Account" <> '' THEN BEGIN
                        RecBankAccountEntete.RESET();
                        RecBankAccountEntete.GET(GPaymentClass."Default Bank Account");
                        RIBBK := RecBankAccountEntete."Bank Branch No." + RecBankAccountEntete."Bank Account No.";
                        NomBk := RecBankAccountEntete.Name;
                    END
                END;
                //

                TexteLettre := '';
                // dh    CU_MntLettre.SetGCurrencyCode("Currency Code");
                IF RecGPaymentHeader."Currency Code" = '' THEN
                    CU_MntLettre."Montant en texte"(TexteLettre, ABS(CumulMntLCY))
                ELSE
                    CU_MntLettre."Montant en texte"(TexteLettre, ABS(CumulMnt));
                //>> DELTA AK
                CLEAR(CU_MntLettre);
                DeductionLettre := '';
                // dh    CU_MntLettre."Montant en texte"(DeductionLettre, ABS("Payment Line"."Deduction Amount (LCY)"));

                CLEAR(CU_MntLettre);
                TotalLettre := '';
                // dh     CU_MntLettre."Montant en texte"(TotalLettre, ABS(CumulMntLCY) + ABS("Payment Line"."Deduction Amount (LCY)"));
                //<< DELTA AK
                //CLEAR(RecCoffre);
                //IF RecCoffre.GET(RecGPaymentHeader.Coffre) THEN;

                /// Get User Id
                CLEAR(RecUser);
                RecUser.SETRANGE(RecUser."User Name", USERID);
                IF RecUser.FINDFIRST() THEN;

                // Get Bank
                CompteBK := '';
                Bank := '';
                CLEAR(RecBankAccount);
                RecBankAccount.SETFILTER(RecBankAccount.Code, '%1', "Bank Account Code");
                RecBankAccount.SETRANGE("Customer No.", "Payment Line"."Account No.");
                IF RecBankAccount.FINDFIRST() THEN;
                ;
                IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::"Bank Account" THEN BEGIN
                    CLEAR(RecBankAccount1);
                    RecBankAccount1.SETRANGE(RecBankAccount1."No.", "Account No.");
                    IF RecBankAccount1.FINDFIRST() THEN
                        CompteBK := RecBankAccount1."Bank Account No.";
                    Bank := RecBankAccount1.Name;

                END;

                IF "Payment Line"."Account Type" = "Payment Line"."Account Type"::Vendor THEN BEGIN
                    CLEAR(VendorBankAccount);
                    VendorBankAccount.SETRANGE(VendorBankAccount."Vendor No.", "Account No.");
                    VendorBankAccount.SETRANGE(Code, "Payment Line"."Bank Account Code");
                    IF VendorBankAccount.FINDFIRST() THEN
                        //<<DELTA 02
                        //CompteBK :=  VendorBankAccount."Agency Code" + VendorBankAccount."Bank Account No." + FORMAT(VendorBankAccount."RIB Key") ;
                        CompteBK := VendorBankAccount."Agency Code" + VendorBankAccount."Bank Account No." + IntToTextLeadingZeros(VendorBankAccount."RIB Key", 2);
                    //>>DELTA 02
                    Bank := VendorBankAccount.Name;


                END;


                // DELTA 01
                IF PaymentHeader.GET("Payment Line"."No.") THEN;
                ListFactLettr := '';
                IDLettrage_ := '';
                IDLettrage_ := "Payment Line"."No." + '/' + FORMAT("Payment Line"."Line No.");
                VendLedgerEntry.SETRANGE("Applies-to ID", IDLettrage_);
                IF VendLedgerEntry.FINDSET() THEN
                    REPEAT
                        ListFactLettr += VendLedgerEntry."Document No." + ',';
                    UNTIL VendLedgerEntry.NEXT() = 0;
            end;

            trigger OnPostDataItem();
            begin
                IF RecGPaymentHeader."Currency Code" = '' THEN
                    Label0001 := STRSUBSTNO(Text001, ABS(CumulMntLCY), GeneralLedgerSetup."LCY Code", TexteLettre)
                ELSE
                    Label0001 := STRSUBSTNO(Text001, ABS(CumulMnt), RecGPaymentHeader."Currency Code", TexteLettre)
            end;

            trigger OnPreDataItem();
            begin
                Increment := 1;
                IF NOT Rec_Company.GET() THEN
                    CLEAR(Rec_Company);

                Rec_Company.CALCFIELDS(Picture);
                TxtCompanyname := Rec_Company.Name;

                //FooterTxt := Rec_Company."Company Name" + ' ' + Rec_Company."Description Line 2" + ' ' + Rec_Company."Description Line 3";
                //DELTA 01
                //TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' '+ Rec_Company."Post Code";
                TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company."Address 2" + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
                //DELTA 01
                CumulMntLCY := 0;
                CumulMnt := 0;//delta MHF

            end;
        }
        dataitem(Integer; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = CONST(1));
            column(CumulMntLCY; CumulMntLCY)
            {
            }
            column(MontantLettrer; MontantLettrer)
            {
            }
            column(MntLettre; TexteLettre)
            {
            }
            column(Label01; Label0001)
            {
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
        label(RefLBL; ENU = 'Our Reference', FRA = 'Notre référence')
        label(EmtLBL; ENU = 'Created By', FRA = 'Emetteur')
        label(BenLBL; ENU = 'Beneficiary', FRA = 'Bénéficiare')
        label(BankLBL; ENU = 'Banque', FRA = 'Bank')
        label(CheckLBL; ENU = 'Check payable to ', FRA = 'Chèque à l''ordre de :')
        label(CheckNoLBL; ENU = 'No. Check', FRA = 'Chèque n° :')
        label(Sig1LBL; ENU = 'Signature of the treasurer', FRA = 'Signature du trésorier')
        label(Sig2LBL; ENU = 'Visa de contrôle & Validation ', FRA = 'Visa de contrôle & Validation ')
        label(Sig3LBL; ENU = 'Passed for payment', FRA = 'Bon A Payer')
        label(Sig4LBL; ENU = '1st signature (DGA)', FRA = '1 ére signature (DGA)')
        label(Sig5LBL; ENU = '2st signature', FRA = '2 éme signature')
        label(Sig6LBL; ENU = 'The...............', FRA = 'Le .................')
        label(Adresse; ENU = 'Address', FRA = 'Adresse')
        label(MatrFisc; ENU = 'Tax Regestration Number ', FRA = 'Matricule Fiscale')
        label(Banquderemise; ENU = 'Bank', FRA = 'Banque')
        label(Montantcap; ENU = 'Amount ', FRA = 'Montant ')
        label(Dateboderau; ENU = 'Date ', FRA = 'Bordereau')
        label(Donneudordre; ENU = 'Payable From', FRA = 'Donneur d''ordre')
        label(Sig; ENU = 'Signature', FRA = 'Signature')
        label(TotalenLettre; ENU = 'Amount in words', FRA = 'Total en toute letter')
        label(codeetablissementcap; ENU = 'Branch Code', FRA = 'Code Etablissement')
        label(codevillecap; ENU = 'City Code', FRA = 'Code ville ')
        label(codeagencecap; ENU = 'Agency code', FRA = 'Code Agence')
        label(RIBCap; ENU = 'RIB Key', FRA = 'Clé RIB')
        label(CompteBancaire; ENU = 'Bank Account', FRA = 'Compte Bancaire')
        label(Totalmontant; ENU = 'Total amount', FRA = 'Total Montant')
        label(Createdby2; ENU = 'Created by', FRA = 'Crée par')
        label(Aprrovedby; ENU = 'Approved By', FRA = 'Approuvé par')
        label(numbank; ENU = 'Bank Account N°', FRA = 'N° Compte')
    }

    var
        PaymentMethod: Record "Payment Method";
        RecGVendor: Record Vendor;
        RecGPaymentHeader: Record "Payment Header";
        Rec_Company: Record "Company Information";
        RecUser: Record User;
        RecBankAccount: Record "Customer Bank Account";
        "Cust. Ledger Entry": Record "Cust. Ledger Entry";
        RecBankAccount1: Record "Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        RecBankAccountEntete: Record "Bank Account";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PaymentHeader: Record "Payment Header";
        GVendor: Record Vendor;
        GeneralLedgerSetup: Record "General Ledger Setup";
        GPaymentClass: Record "Payment Class";
        CU_MntLettre: Codeunit "ST MontantTouteLettre";
        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
        IsLettrageFound: Boolean;
        TxtCompanyname: Code[50];
        Increment: Integer;
        TexteLettre: Text[1024];
        DeductionLettre: Text[1024];
        TotalLettre: Text[1024];
        CumulMnt: Decimal;
        CumulMntLCY: Decimal;
        test: Decimal;
        Partition: array[20] of Decimal;
        Partition2: Decimal;
        NombreLigne: Decimal;
        Pagination: array[100] of Decimal;
        TxtTitre: TextConst ENU = 'Payment With %1', FRA = 'Paiement Par %1';
        TxtReportTitle: Text[250];
        MontantLettrer: Decimal;
        TXTADRESSE: Text;
        IdLettrage: Text[50];
        SlachPos: Integer;
        DocLettrer: Text;
        CompteBK: Text;
        Bank: Text;
        RIBBK: Text;
        NomBk: Text;
        AddressBk: Text;
        ListFactLettr: Text[1024];
        IDLettrage_: Code[50];
        HeaderBankCity: Text;
        PaymentTitel: Text[250];
        PaymentPiece: Text;
        CheckNo: TextConst ENU = 'Check No.', FRA = 'N° chèque';
        TraiteNo: TextConst ENU = 'Traite No.', FRA = 'N° Traite';
        PieceNo: TextConst ENU = 'Traite No.', FRA = 'N° de piéce de paiement';
        BankAccountNo: TextConst ENU = 'Bank account no.', FRA = 'N° compte bancaire';
        ReportTitle: TextConst ENU = 'Payment Proposal', FRA = 'Ordre de Virement';
        NotePaiementPrefixe: TextConst ENU = 'Thank you for accepting payment By', FRA = 'Merci d''accepter le paiement par';
        NotePaiementSuffixe: TextConst ENU = 'in counterpart of the following invoices:', FRA = 'en contrepatie des factures suivantes:';
        VendorBankAccG: Record "Vendor Bank Account";
        HeaderBankAccG: Record "Bank Account";
        PaymentHeaderG: Record "Payment Header";
        VendorNoCaption: TextConst ENU = 'Vendor No.', FRA = 'N° Fournisseur';
        VendorNameCaption: TextConst ENU = 'Vendor Name', FRA = 'Nom Fournisseur';
        CustNoCaption: TextConst ENU = 'Customer No.', FRA = 'N° Client';
        CustNameCaption: TextConst ENU = 'Customer Name', FRA = 'Nom Client';
        NoCaptionG: Text[50];
        NameCaptionG: Text[50];
        CustBankAccG: Record "Customer Bank Account";
        TransitNoG: Text[50];
        Text001: TextConst ENU = 'By the debit of our account quoted in the margin we kindly ask you to transfer the sum of %1 %2 (%3)of the benefit of the suppliers quoted below :', FRA = 'Par le débit de notre compte cité en marge, nous vous prions de bien vouloir virer la somme de %1 %2 (%3) au profit des fournissuers cité ci-dessous :';
        Label0001: Text;
        FooterTxt: Text;
        FooterDate: Text;
        FooterLocation: Label '" LE %1"';
        taux: Decimal;

    local procedure IntToTextLeadingZeros(MyInteger: Integer; MyTextLenght: Integer): Text;
    begin
        IF STRLEN(FORMAT(MyInteger)) < 2 THEN
            EXIT(PADSTR('', MyTextLenght - STRLEN(FORMAT(MyInteger)), '0') + FORMAT(MyInteger))
        ELSE
            EXIT(FORMAT(MyInteger));
    end;
}

