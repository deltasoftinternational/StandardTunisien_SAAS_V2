page 71007 "ST chèque"
{
    Caption = 'Chèque';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "ST chéque";
    SourceTableView = sorting("ST Check No");

    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No"; Rec."ST Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Banque Code"; Rec."ST Banque Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Réference chéque"; Rec."ST Réference chéque")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Check No"; Rec."ST Check No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec."ST Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payment Slip No."; Rec."ST Payment Slip No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Payment Slip No"; Rec."ST Line Payment Slip No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payment Slip Status"; Rec."ST Payment Slip Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status No"; Rec."ST Status No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status Modifiable"; Rec."ST Status Modifiable")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."ST Account Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account No"; Rec."ST Account No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."ST Account Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount line"; Rec."ST Amount line")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Bloquer Chéque")
            {
                Caption = 'Block Check';
                Image = Close;

                trigger OnAction()
                var
                    Text001: Label 'Bordereau annulé';
                    lChecks: Record "ST chéque";
                begin
                    lChecks.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(lChecks);
                    IF lChecks.FINDSET() THEN
                        REPEAT
                            IF (lChecks."ST Payment Slip No." <> '') AND (lChecks."ST Line Payment Slip No" <> 0) THEN
                                ERROR(Error001, lChecks."ST Banque Code", lChecks."ST Réference chéque", lChecks."ST Check No");
                            lChecks."ST Status" := Rec."ST Status"::Bloqued;
                            lChecks."ST Payment Slip No." := Text001;
                            lChecks.MODIFY();
                        UNTIL lChecks.NEXT() = 0;
                end;
            }
            action("Chèque manuel")
            {
                Caption = 'Manual Check';
                Image = Post;

                trigger OnAction()
                var
                    Text002: Label 'Manual Check';
                    lChecks: Record "ST chéque";
                begin
                    lChecks.COPY(Rec);
                    CurrPage.SETSELECTIONFILTER(lChecks);
                    IF lChecks.FINDSET() THEN
                        REPEAT
                            IF (lChecks."ST Payment Slip No." <> '') AND (lChecks."ST Line Payment Slip No" <> 0) THEN
                                ERROR(Error001, lChecks."ST Banque Code", lChecks."ST Réference chéque", lChecks."ST Check No");
                            lChecks."ST Status" := Rec."ST Status"::ledger;
                            lChecks."ST Payment Slip No." := Text002;
                            lChecks.MODIFY();
                        UNTIL lChecks.NEXT() = 0;
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        PaymentHeader.RESET();

        IF PaymentHeader.GET(Rec."ST Payment Slip No.") THEN BEGIN
            PaymentHeader.CALCFIELDS("Status Name");
            Rec."ST Payment Slip Status" := PaymentHeader."Status Name";
            PaymentStatus.Reset();
            PaymentStatus.SetRange(Name, PaymentHeader."Status Name");
            if PaymentStatus.FindFirst() then
                rec."ST Status" := PaymentStatus."ST Status";
        END;
        PaymentLine.RESET();
        IF PaymentLine.GET(Rec."ST Payment Slip No.", Rec."ST Line Payment Slip No") THEN
            Rec."ST Account Name" := RetrieveName();


    end;


    var
        PaymentHeader: Record "Payment Header FR";
        PaymentStatus: Record "Payment Status FR";
        PaymentLine: Record "Payment Line FR";
        Error001: Label 'You can not do this action This check%1 %2 %3  is assigned to payment Slip.';


    procedure RetrieveName(): Text[50]
    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
    begin

        IF Rec."ST Account Type" = 'G/L Account' THEN BEGIN
            GLAccount.RESET();
            GLAccount.SETRANGE("No.", Rec."ST Account No");
            IF GLAccount.FINDFIRST() THEN
                EXIT(GLAccount.Name);
        END;
        IF Rec."ST Account Type" = 'CLIENT' THEN BEGIN
            Customer.RESET();
            Customer.SETRANGE("No.", Rec."ST Account No");
            IF Customer.FINDFIRST() THEN
                EXIT(Customer.Name);
        END;
        IF Rec."ST Account Type" = 'FOURNISSEUR' THEN BEGIN
            Vendor.RESET();
            Vendor.SETRANGE("No.", Rec."ST Account No");
            IF Vendor.FINDFIRST() THEN
                EXIT(Vendor.Name);
        END;
        IF Rec."ST Account Type" = 'BANQUE' THEN BEGIN
            Bank.RESET();
            Bank.SETRANGE("No.", Rec."ST Account No");
            IF Bank.FINDSET() THEN
                EXIT(Bank.Name);
        END;
        IF Rec."ST Account Type" = 'IMMOBILISATION' THEN BEGIN
            FixedAsset.RESET();
            FixedAsset.SETRANGE("No.", Rec."ST Account No");
            IF FixedAsset.FINDSET() THEN
                EXIT(FixedAsset.Description);
        END;
    end;
}

