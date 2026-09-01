pageextension 71014 "Payment Slip FR" extends "Payment Slip FR" //10843
{
    layout
    {
        moveafter("Posting Date"; "Account No.", "Account Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")
        modify("Partner Type")
        {
            Visible = false;
        }



        modify("Payment Journal Errors")
        {
            Visible = false;
        }

        addafter("Amount (LCY)")
        {
            field("stAmount"; Rec."Amount")
            {
                ApplicationArea = Basic, Suite;
                Importance = Promoted;
                ToolTip = 'Specifies the sum of the amounts in the Amount fields on the associated lines.';
            }

            field("ST LC shipping date"; REC."ST LC shipping date")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST LC validity date"; REC."ST LC validity date")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Opninig Deadline"; REC."ST Opninig Deadline")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Import Title Reference"; REC."ST Import Title Reference")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Import Title Date"; REC."ST Import Title Date")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Opninig Fees"; REC."ST Opninig Fees")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Change Fees"; REC."ST Change Fees")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Realization Fees"; REC."ST Realization Fees")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
            field("ST Deffered Payment Fees"; REC."ST Deffered Payment Fees")
            {
                ApplicationArea = all;
                Visible = EnableLC;
            }
        }

        addafter("Posting Date")
        {

            field(Agence; Rec.STAgence)
            {
                ApplicationArea = All;
                Visible = FALSE;
            }

            field(Coffre; Rec.STCoffre)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("STbank slip"; Rec."STbank slip")
            {
                Visible = PayBankVisible;
                ApplicationArea = All;
            }
            field("STreason code"; Rec."STreason code")
            {
                Visible = ReasonVisible;
                ApplicationArea = All;
            }


        }

    }
    actions
    {
        modify(Header)
        {
            Promoted = true;
            PromotedCategory = Process;
            PromotedIsBig = true;
            Caption = 'Naviguer En-téte';
        }
        modify(GenerateFile)
        {
            Visible = false;
            Enabled = false;

        }
        addafter(GenerateFile)
        {
            action(GenaratingFile)
            {
                ApplicationArea = All;
                Image = CreateDocument;
                Caption = 'Générer fichier';
                trigger OnAction()
                var
                    Steps: record "Payment Step FR";
                begin
                    Steps.SETRANGE("Payment Class", Rec."Payment Class");
                    Steps.SETRANGE("Previous Status", Rec."Status No.");
                    Steps.SETRANGE("Action Type", Steps."Action Type"::File);
                    ValidatePayment();
                end;
            }
        }
        modify(Post)
        {
            Visible = false;
            Enabled = false;

        }
        addafter(Post)
        {
            action("&Post")
            {
                Caption = 'Valider';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PaymentStatus_gr: record "Payment Status FR";
                    PaymentLine_gr: record "Payment Line FR";
                    LigneBordereau: record "Payment Line FR";
                    Status: record "Payment Status FR";
                    Steps: record "Payment Step FR";
                    RecUser: Record "User Setup";
                    RecEntetePayement: record "Payment Header FR";
                    Text010: Label 'Veuillez saisir le N° Chèque dans la ligne %1';
                    Text013: Label 'N° chèque est Annulé ou Bloqué';
                    Text011: Label 'N° chèque %1 est utlisé plus qu''une fois';
                    Text012: Label 'Validation impossible, ligne traitée sur un autre bordereaux!';

                begin
                    // VarReport := FALSE;
                    // CurrPage.UPDATE(TRUE);
                    // Steps.SETRANGE("Payment Class", "Payment Class");
                    // Steps.SETRANGE("Previous Status", "Status No.");
                    // Steps.SETFILTER("Action Type", '<>%1&<>%2&<>%3', Steps."Action Type"::Report, Steps."Action Type"::File, Steps."Action Type"::
                    //   "Create New Document");
                    // ValidatePayment;
                    // IF "Status No." <> 0 THEN
                    //     BooGLineEditable := FALSE;

                    //<< DELTA HH 1010/2021
                    IF Status.GET(Rec."Payment Class", Rec."Status No.") THEN BEGIN
                        LigneBordereau.SETRANGE("No.", Rec."No.");
                        IF LigneBordereau.FINDFIRST() THEN
                            REPEAT
                                IF LigneBordereau."Copied To No." <> '' THEN
                                    ERROR(Text012);
                            UNTIL LigneBordereau.NEXT() = 0;
                    END;
                    //>> DELTA HH 1010/2021
                    PaymentStep.SetFilter("Action Type", '%1|%2|%3', PaymentStep."Action Type"::None, PaymentStep."Action Type"::Ledger, PaymentStep."Action Type"::"Cancel File");
                    PaymentMgt.ProcessPaymentSteps(Rec, PaymentStep);
                end;
            }


        }
        modify(Print)
        {
            Visible = false;
            Enabled = false;

        }
        addafter("&Post")
        {
            action("&Print")
            {
                Caption = 'Imprimer';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Steps: record "Payment Step FR";
                begin
                    // // VarReport := TRUE;
                    // // Steps.SETRANGE("Payment Class", "Payment Class");
                    // // Steps.SETRANGE("Previous Status", "Status No.");
                    // // Steps.SETRANGE("Action Type", Steps."Action Type"::Report);
                    // // // CurrPage.Lines.PAGE.MarkLines(TRUE); TODO:
                    // // ValidatePayment;
                    // // // CurrPage.Lines.PAGE.MarkLines(FALSE);
                    // // VarReport := FALSE;
                    CurrPage.Lines.PAGE.STMarkLines(true);
                    PaymentStep.SetRange("Action Type", PaymentStep."Action Type"::Report);
                    PaymentMgt.ProcessPaymentSteps(Rec, PaymentStep);
                    CurrPage.Lines.PAGE.STMarkLines(false);

                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        //<< DELTA 01 RAD 09/12/2014 Gestion de Coffre par Site
        IF UserSetup.GET(UPPERCASE(USERID)) THEN
            IF UserSetup.STCoffre <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETRANGE(STCoffre, UserSetup.STCoffre);
                Rec.FILTERGROUP(0);
            END;
        //>> DELTA 01
        // CurrPage.UPDATE;
        VisibleField();
    end;

    trigger OnAfterGetRecord()
    var
        //Statement: Record payment 
        PaymentStatus: record "Payment Status FR";
        PayementHeader: record "Payment Header FR";

    begin
        //<<DELTA 01



        CLEAR(PaymentClass);
        IF PaymentClass.GET(Rec."Payment Class") THEN
            CurrPage.Lines.PAGE.EnablePetiteDépense(PaymentClass."STPetite dépense");
        //>> DELTA 01
        VisibleField();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        //Statement: Record payment 
        PaymentStatus: record "Payment Status FR";
        PayementHeader: record "Payment Header FR";
    begin
        //<<DELTA 01
        IF PaymentClass.GET(Rec."Payment Class") THEN
            CurrPage.Lines.PAGE.EnablePetiteDépense(PaymentClass."STPetite dépense");

        //<< DELTA Hdali
        // if PayementHeader.Get(Rec."No.") then
        //     if PaymentClass.GET(PayementHeader."Payment Class") then
        //         CurrPage.Lines.PAGE.ModifAccountType(PaymentClass.Suggestions);
        // CurrPage.Lines.Page.Update(true);
        // >> DELTA Hdali

        // CurrPage.UPDATE;
        //>>DELTA 01

    end;
    // // // trigger OnOpenPage()
    // // // var
    // // //     RecUser: Record "User Setup";
    // // //     BooModifAgence: Boolean;
    // // //     recParamCompta: Record "General Ledger Setup";
    // // // begin
    // // //     RecUser.GET(USERID);
    // // //     BooModifAgence := RecUser."Modif Agence";


    // // //     recParamCompta.GET();
    // // //     IF (recParamCompta."Date debut Visualisation" <> 0D) AND (recParamCompta."Date fin Visualisation" <> 0D) THEN
    // // //         SETFILTER("Posting Date", '%1..%2', recParamCompta."Date debut Visualisation", recParamCompta."Date fin Visualisation")
    // // //     ELSE
    // // //         RESET;
    // // // end;

    // // // trigger OnAfterGetRecord()
    // // // var
    // // //     BooGLineEditable: Boolean;
    // // //     recParamCompta: Record "General Ledger Setup";
    // // // begin
    // // //     //hejer 30/12/2011
    // // //     recParamCompta.GET();
    // // //     IF (recParamCompta."Date debut Visualisation" <> 0D) AND (recParamCompta."Date fin Visualisation" <> 0D) THEN
    // // //         SETFILTER("Posting Date", '%1..%2', recParamCompta."Date debut Visualisation", recParamCompta."Date fin Visualisation");
    // // //     //hejer 30/12/2011
    // // //     //<<SDK MIG V01
    // // //     IF "Status No." = 0 THEN
    // // //         BooGLineEditable := TRUE
    // // //     ELSE
    // // //         BooGLineEditable := FALSE;
    // // // end;

    // // // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // // // var
    // // //     RecUser: Record "User Setup";
    // // // begin
    // // //     IF RecUser.GET(USERID) THEN BEGIN
    // // //         Agence := RecUser.Agence;
    // // //         "Shortcut Dimension 1 Code" := Agence;

    // // //     END;
    // // //     Utilisateur := USERID;
    // // // end;

    local procedure ValidatePayment()
    var
        Steps: record "Payment Step FR";
        PostingStatement: Codeunit "ST Payment Management";
        Options: Text[800];
        Choice: Integer;
        I: Integer;
        Ok: Boolean;
    begin

        I := Steps.COUNT;
        Ok := FALSE;
        IF I = 1 THEN BEGIN
            Steps.FIND('-');
            Ok := CONFIRM(Steps.Name, TRUE);
        END ELSE
            IF I > 1 THEN BEGIN
                Steps.SETFILTER("Payment Class", '%1', Rec."Payment Class");
                Steps.SETFILTER("Previous Status", '%1', Rec."Status No.");
                Steps.SETFILTER("Action Type", '<>%1', Steps."Action Type"::"Create New Document");
                if VarReport THEN
                    Steps.SETRANGE("Action Type", Steps."Action Type"::Report) ELSE
                    Steps.SetFilter("Action Type", '<>%1', Steps."Action Type"::Report);
                IF Steps.FINDSET() THEN BEGIN
                    REPEAT
                        IF Options = '' THEN
                            Options := Steps.Name
                        ELSE
                            Options := Options + ',' + Steps.Name;
                    UNTIL Steps.NEXT() = 0;

                    Choice := STRMENU(Options, 1);

                    I := 1;
                    IF Choice > 0 THEN BEGIN
                        Ok := TRUE;
                        Steps.FIND('-');
                        WHILE Choice > I DO BEGIN
                            I += 1;
                            Steps.NEXT();
                        END;
                    END;
                END;
            END;

        IF Ok THEN
            PostingStatement.ProcessPaymentSteps(Rec, Steps)
    end;

    procedure VisibleField()
    var
        lGeneralLedgerSetup: Record "General Ledger Setup";
        lpurchasesetup: Record "Purchases & Payables Setup";
        lpaymentClass: record "Payment Class FR";
    begin
        PayBankVisible := false;
        ReasonVisible := false;
        lGeneralLedgerSetup.get('');
        if lGeneralLedgerSetup."ST Enable Bank Slip" then
            PayBankVisible := true;
        if lGeneralLedgerSetup."ST Enable reasoncode slip pay." then
            ReasonVisible := true;
        lpurchasesetup.Get();
        if not lpurchasesetup."ST Enable Lettre Of Cr." then
            EnableLC := false
        else begin
            EnableLC := true;
            if lpaymentClass.get(rec."Payment Class") then
                if not (lpaymentClass.STType_Reg = lpaymentClass.STType_Reg::LettreC) then
                    EnableLC := false
        end;
    end;

    var
        UserSetup: Record "User Setup";
        Text004: Label 'Vous n''êtes pas autorisé à faire des propositions de paiement chèques sur un bordereau validé.';
        PaymentClass: record "Payment Class FR";
        BooGLineEditable: Boolean;
        VarReport: Boolean;
        PaymentStep: record "Payment Step FR";
        PaymentMgt: Codeunit "ST Payment Management";
        IsChechVisible: Boolean;

        PayBankVisible: Boolean;
        ReasonVisible: Boolean;
        EnableLC: Boolean;
}