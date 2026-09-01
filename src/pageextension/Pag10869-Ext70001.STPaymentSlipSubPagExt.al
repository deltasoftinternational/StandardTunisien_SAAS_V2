pageextension 71001 "ST PaymentSlipSubPagExt" extends "Payment Slip Subform" //10869
{
    layout
    {


        addafter(Amount)
        {
            field("ST Amount"; rec.Amount)
            {
                ApplicationArea = all;
                Visible = true;
                AutoFormatExpression = Rec."Currency Code";
                AutoFormatType = 1;
            }
        }
        modify(Amount)
        {
            Visible = false;
        }

        modify("Posting Group")
        {
            Visible = True;
            Editable = true;


        }
        modify("External Document No.") { Visible = true; }

        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
            begin
                RecHeader.Reset();
                RecStatus.reset();
                IF RecHeader.GET(Rec."No.") THEN
                    IF Status.GET(RecHeader."Payment Class", RecHeader."Status No.") THEN BEGIN
                        DebitAmountVisible := Status.Debit;
                        CreditAmountVisible := Status.Credit;
                        IsChechVisible := Status."ST Référence chèque";
                        CurrPage.UPDATE()
                    END

            end;
        }

        modify("Drawee Reference")
        {
            Visible = false;
        }

        addafter("Bank Account Code")
        {


        }



        addafter("RIB Checked")
        {
            field("Created from No."; Rec."Created from No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Copied To No."; Rec."Copied To No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Code Retenue à la Source"; Rec."STCode Retenue à la Source")
            {
                ApplicationArea = All;
            }


            field("Montant Retenue Validé"; Rec."STMontant Retenue Validé")
            {
                ApplicationArea = All;
            }
            field("Mnt Déduction"; Rec."STMnt Déduction")
            {
                ApplicationArea = All;
            }
            field("Assiette RS"; Rec."STAssiette RS")
            {
                ApplicationArea = All;
            }
            field("Montant Retenue"; Rec."STMontant Retenue")
            {
                ApplicationArea = All;
            }

            field("Libellé"; Rec."STLibellé")
            {
                ApplicationArea = All;
                Editable = isEditable;
            }

            field("Commentaires"; Rec.STCommentaires)
            {
                ApplicationArea = All;
            }
            field("Drawee Reference1"; Rec."STDrawee Reference1")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    if Rec."STDrawee Reference1" <> '' then
                        Rec."STLibellé" := Rec."STDrawee Reference1";

                end;
            }


            field("En Banque"; Rec."STEn Banque")
            {
                ApplicationArea = All;
            }


            field("stMontant Interret"; Rec."STMontant Interret")
            {
                ApplicationArea = all;
                Style = Favorable;
                StyleExpr = TRUE;
                Editable = IseditComm;
            }

            field("stMontant Commission"; Rec."STMontant Commission")
            {
                ApplicationArea = all;
                Style = Favorable;
                StyleExpr = TRUE;
                Editable = IseditComm;
            }
            field("STMontant TVA Commission"; Rec."STMontant TVA Commission")
            {
                ApplicationArea = all;
                Style = Favorable;
                StyleExpr = TRUE;
                Editable = IseditComm;
            }

            field("Invoice No."; Rec."STInvoice No.")
            {
                ApplicationArea = All;
            }

            field("Avance ouvert"; Rec."STAvance ouvert")
            {
                ApplicationArea = All;
            }

            field("Job No."; Rec."STJob No.")
            {
                ApplicationArea = All;
            }


            field("Rib_Entête"; Rec."STRib_Entête")
            {
                ApplicationArea = All;
            }

            field("Montant Frais a Déduire"; Rec."STMontant Frais a Déduire")
            {
                ApplicationArea = All;
            }

            field("Code Mode Règlement"; Rec."STCode_Mode_Règlement")
            {
                ApplicationArea = All;
            }
            field("Code Motif"; Rec.STCode_Motif)
            {
                ApplicationArea = All;
            }
            field(Coffre; Rec.STCoffre)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Coffre Origine"; Rec."STCoffre Origine")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Banque Societe"; Rec."Banque Societe")
            {
                Editable = false;
                ApplicationArea = All;
            }






        }

        addafter("Due Date")
        {

            field("STOrder Type"; Rec."STOrder Type")
            {
                ToolTip = 'Specifies the value of the Order Type field';
                ApplicationArea = All;
            }
            field("STOrder No."; Rec."STOrder No.")
            {
                ToolTip = 'Specifies the value of the N° commande field';
                ApplicationArea = All;
            }

        }
        addafter("External Document No.")
        {
            field(STCertifAval; Rec.STCertifAval)
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD();
                    CurrPage.UPDATE();
                end;
            }
            field("Applies-to Invoices Nos."; Rec."Applies-to Invoices Nos.")
            {
                ApplicationArea = All;
            }

            field("Check No"; rec."ST Check No")
            {
                Caption = 'Numéro chéque';
                Visible = IsChechVisible;
                ApplicationArea = All;
                //Visible = false;
            }
            field("Reference Check"; rec."ST Réference chéque")
            {
                Caption = 'Réference chéque';
                Visible = IsChechVisible;
                //Visible = false;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.SAVERECORD();
                    CurrPage.UPDATE();
                end;
            }
            field("Groupe Comptabilisation"; Rec."STGroupe Comptabilisation")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addlast(Control1)
        {
            field("Numéro CIN"; Rec."Numéro CIN")

            {
                Caption = 'Numéro CIN';
                ApplicationArea = All;

            }
            field("Date CIN"; Rec."Date CIN")
            {
                Caption = 'Date CIN';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // addafter("F&unctions")
        // {
        //     group("&Validation")
        //     {
        //         action(Imprimer)
        //         {
        //             Image = Print;
        //             trigger OnAction()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 MarkLines(TRUE);
        //                 PrintPayments;
        //                 MarkLines(FALSE);
        //             end;
        //         }
        //     }
        // }
        addafter(Modify)
        {
            action(STModifyDueDate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Modifier la date d''échéance et Référence';
                Image = EditFilter;
                trigger OnAction()
                var

                    PaymentStatus: record "Payment Status";
                    PaymentModification: page "ST Modify Payment Line";
                    Text001Txt: label 'Il n''ya pas de ligne à modifier';
                begin
                    PaymentStatus.get(rec."Payment Class", rec."Status No.");
                    PaymentStatus.TestField("ST Autorise Modify Due Date");
                    if rec."Line No." = 0 then
                        Message(Text001Txt)
                    else begin
                        PaymentModification.LookupMode := true;
                        PaymentModification.SetRecord(rec);
                        PaymentModification.RunModal();
                        //page.RunModal(page::"Int Modify Payment Line", Rec);
                    end;
                end;
            }
        }
        addafter(Insert)
        {
            action("Calculer retenu à la source")
            {
                ApplicationArea = All;
                Image = CalculateSalesTax;
                trigger OnAction()
                begin
                    CalculerRetenu();
                end;
            }
            action("Imprimer ordre paiement")
            {
                ApplicationArea = All;
                Image = Print;
                Visible = false;
                trigger OnAction()
                var
                    PaymentLine: Record "Payment Line";
                    PaymentHeader: Record "Payment Header";
                    PiecePaiementEtat: Report "STPièce de Paiement";
                    noFilter: Text[100];
                begin
                    PaymentLine.Reset();
                    CurrPage.SetSelectionFilter(PaymentLine);
                    noFilter := '';
                    if PaymentLine.FindSet() then
                        REPEAT
                            PaymentHeader.Get(PaymentLine."No.");
                            noFilter += Format(PaymentLine."Line No.") + '|';

                        UNTIL PaymentLine.NEXT() = 0;
                    noFilter := copystr(noFilter, 1, strlen(noFilter) - 1);
                    CLEAR(PaymentLine);
                    PaymentLine.SETFILTER("No.", PaymentHeader."No.");
                    PaymentLine.SETFILTER("Line No.", noFilter);
                    PiecePaiementEtat.SetTableView(PaymentLine);
                    PiecePaiementEtat.Run();
                    //   REPORT.RUNMODAL(70002, TRUE, FALSE, PaymentLine);

                    //     repeat
                    //         PiecePaiementEtat.SetTableView(PaymentLine);
                    //         PiecePaiementEtat.Run();
                    //     // REPORT.RUNMODAL(REPORT::"STPièce de Paiement", TRUE, FALSE, PaymentLine);
                    //     until PaymentLine.Next() = 0;
                end;
            }

        }
        addlast("&Line")
        {
            action("Fractionner ligne")
            {
                Caption = 'Fractionner ligne';
                Image = checkDuplicates;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.FractionnerLine();


                end;
            }

        }
        addfirst("&Line")
        {
            action(Application2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Lettrage';
                ShortCutKey = 'Shift+F11';
                ToolTip = 'Apply the customer or vendor payment on the selected payment slip line.';
                Image = Balance;
                trigger OnAction()
                var
                    // lcuPaymentApply: Codeunit "Payment-Apply";
                    "stPayment-Apply": Codeunit "stPayment-Apply";
                begin

                    //lcuPaymentApply.GetCurrency();
                    // lcuPaymentApply.Run(Rec);
                    OnBeforeApplication2(rec);
                    CODEUNIT.Run(CODEUNIT::"stPayment-Apply", Rec);
                end;
            }
        }
        modify(Application)
        {
            Visible = false;
        }
    }
    procedure CalculerRetenu()
    begin

    end;

    // local procedure PrintPayments()
    // var
    //     PaymentFunctions: Codeunit "ST PaymentHook";
    //     PaymentStep: Record "Payment Step";
    // begin
    //     Header.GET("No.");
    //     Header.CALCFIELDS("No. of Lines");
    //     IF Header."No. of Lines" = 0 THEN
    //         ERROR(Text004);
    //     PaymentFunctions.PrintLine(Header, PaymentStep."Action Type"::Report);

    // end;

    local procedure MarkLines(ToMark: Boolean)
    var
        LineCopy: Record "Payment Line";
        NumLines: Integer;
    begin
        IF ToMark THEN BEGIN
            CurrPage.SETSELECTIONFILTER(LineCopy);
            NumLines := LineCopy.COUNT;
            IF NumLines > 0 THEN BEGIN
                LineCopy.FIND('-');
                REPEAT
                    LineCopy.Marked := TRUE;
                    LineCopy.MODIFY();
                UNTIL LineCopy.NEXT() = 0;
            END ELSE
                LineCopy.RESET();
            LineCopy.SETRANGE("No.", Rec."No.");
            LineCopy.MODIFYALL(Marked, TRUE);
        END ELSE BEGIN
            LineCopy.SETRANGE("No.", Rec."No.");
            LineCopy.MODIFYALL(Marked, FALSE);
        END;
        COMMIT();
    end;

    Procedure EnablePetiteDépense(PetiteDépense: Boolean)
    //<<DELTA 01 
    begin
        IF PetiteDépense THEN BEGIN
            BoolPetiteDépense1 := TRUE;
            BoolPetiteDépense2 := FALSE;
        END
        ELSE BEGIN
            BoolPetiteDépense2 := TRUE;
            BoolPetiteDépense1 := FALSE;
        END;
    end;
    //>>End DELTA 01


    //<<Hdali

    procedure ModifAccountType(PSuggestion: Enum "ST Suggestions ENUM")
    var
        LineCopy: Record "Payment Line";
        NumLines: Integer;
    begin
        CASE PSuggestion OF
            1:
                Rec."Account Type" := Rec."Account Type"::Customer;
            2:
                Rec."Account Type" := Rec."Account Type"::Vendor;

        END;
    End;



    trigger OnOpenPage()
    begin
        IsChechVisible := true;
        // CalcFields("Banque Societe");
        EditCommission();
    end;


    trigger OnAfterGetRecord()
    var
        PaymentHeaderV: record "Payment Header";
        PaymentStatusV: Record "Payment Status";
    begin
        PaymentHeaderV.Reset();
        PaymentStatusV.Reset();
        IF PaymentHeaderV.GET(Rec."No.") THEN BEGIN
            PaymentStatusV.GET(PaymentHeaderV."Payment Class", PaymentHeaderV."Status No.");
            IsChechVisible := PaymentStatusV."ST Référence chèque";



        END;
        PaymentHeader.get(rec."No.");

        PaymentHeader.CalcFields("Status Name");
        PaymentStatus_gr.Reset();
        PaymentStatus_gr.SetRange("Payment Class", PaymentHeader."Payment Class");
        PaymentStatus_gr.SetRange(Name, PaymentHeader."Status Name");
        if PaymentStatus_gr.FindFirst() then
            if PaymentStatus_gr."STLibelle modifiable" then
                isEditable := false
            else
                isEditable := true;
        EditCommission();
    end;
    //<<Hdali

    procedure EditCommission()
    var
        lusersetup: Record "user setup";
    begin
        lusersetup.Get(UserId);
        IseditComm := lusersetup."ST modify commission";
    end;


    procedure STMarkLines(ToMark: Boolean)
    var
        LineCopy: Record "Payment Line";
        NumLines: Integer;
    begin
        if ToMark then begin
            CurrPage.SetSelectionFilter(LineCopy);
            NumLines := LineCopy.Count();
            if NumLines > 0 then begin
                LineCopy.Find('-');
                repeat
                    LineCopy.Marked := true;
                    LineCopy.Modify();
                until LineCopy.Next() = 0;
            end else
                LineCopy.Reset();
            LineCopy.SetRange("No.", Rec."No.");
            LineCopy.ModifyAll(Marked, true);
        end else begin
            LineCopy.SetRange("No.", Rec."No.");
            LineCopy.ModifyAll(Marked, false);
        end;
        Commit();
    end;


    [IntegrationEvent(false, false)]
    local procedure OnBeforeApplication2(Paymentline: Record "Payment Line")
    begin
    end;


    var
        Header: Record "Payment Header";
        Status: Record "Payment Status";
        RecHeader: Record "Payment Header";
        RecStatus: Record "Payment Status";
        Text004: Label 'Il n''existe aucune ligne à imprimer.';
        BoolPetiteDépense1: Boolean;
        BoolPetiteDépense2: Boolean;
        isEditable: Boolean;
        PaymentStatus_gr: Record "Payment Status";
        PaymentHeader: Record "Payment Header";
        PaymentStep: Record "Payment Step";
        IsChechVisible: Boolean;
        IseditComm: Boolean;
        DebitAmountVisible: Boolean;
        CreditAmountVisible: Boolean;





}