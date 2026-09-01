codeunit 71001 "ST Payment Management"
{

    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  Tabledata "Detailed Vendor Ledg. Entry" = RIMD,
                  Tabledata "Detailed Cust. Ledg. Entry" = RIMD,
                  Tabledata "G/L Entry" = RIMD;

    trigger OnRun()
    begin
        STCreatePaymentHeaders();
    end;

    var
        ERR001: label 'Le Bordereau ne peut pas être annulé, veuillez l''annuler du Bordereau  N° %1';
        Text001: Label 'Le numéro %1 ne peut pas être étendu à plus de 20 caractères.';
        Text002: Label 'La valeur d''un ou plusieurs codes acceptation est Non';
        Text003: Label 'Une ou plusieurs lignes indiquent un code RIB incorrect';
        Text004: Label 'Il n''y a pas de bordereau à créer.';
        Text005: Label 'Validation en comptabilité';
        Text006: Label 'Une ou plusieurs dates d''échéance ne sont pas spécifiées.';
        Text007: Label 'L''action a été annulée.';
        Text008: Label 'Le RIB de l''en-tête est incorrect.';
        Text009: Label 'La combinaison d''axes analytiques utilisée dans le bordereau %1 est bloquée. %2.. %2.', Comment = '%1 - payment header no, %2 - dimension error';
        Text010: Label 'La combinaison d''axes analytiques utilisée dans le bordereau %1, ligne n° %2, est bloquée. %3.', Comment = '%1 - payment header no, %2 - payment line no, %3 - dimension error';
        InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary;
        CustomerPostingGroup: Record "Customer Posting Group";
        VendorPostingGroup: Record "Vendor Posting Group";
        Customer: Record Customer;
        Vendor: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GenJnlLine: Record "Gen. Journal Line";
        PaymentLine: Record "Payment Line";
        OldPaymentLine: Record "Payment Line";
        StepLedger: Record "Payment Step Ledger";
        Step: Record "Payment Step";
        PaymentHeader: Record "Payment Header";
        PaymentClass: Record "Payment Class";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        DimMgt: Codeunit DimensionManagement;
        N: Integer;
        Suffix: Text;
        EntryTypeDebit: Option;
        EntryNoAccountDebit: Code[20];
        EntryPostGroupDebit: Code[20];
        EntryTypeCredit: Option;
        EntryNoAccountCredit: Code[20];
        EntryPostGroupCredit: Code[20];
        GLEntryNoTmp: Integer;
        Text011: Label 'XX';
        Text012: Label 'Le groupe compta. client %1 n''existe pas..';
        Text014: Label 'Vous devez entrer un compte général pour le groupe compta. client %1.';
        Text016: Label 'Une ligne validée ne peut pas être supprimée.';
        Text017: Label 'Le code source %1 n''existe pas..';
        HeaderAccountUsedGlobally: Boolean;
        Text018: Label 'Vous devez spécifier un numéro de compte de débit à l''étape %1 du type de règlement %2.';
        Text019: Label 'Vous devez spécifier un numéro de compte de crédit à l''étape %1 du type de règlement %2.';
        Text020: Label 'Vous devez spécifier un n° de compte dans le bordereau.';
        Text021: Label 'Le code %1 ne contient pas de nombre.';
        Text022: Label 'Le statut du document %1 n''autorise pas l''archivage.';
        CheckDimVauePostingLineErr: Label 'La dimension utilisé dans %1 %2 %3 a provoqué une erreur. %4', Comment = '%1=Payment Header No., %2=tablecaption, %3=Payment Line No., %4=Error text';
        CheckDimVauePostingHeaderErr: Label 'La dimension utilisé dans %1 a provoqué une erreur. %2', Comment = '%1=Payment Header No., %2=Error text';
        Text100: Label 'Arrondi sur %1';
        NoSeriesMgt: Codeunit "No. Series";
        StepLedgerTmp: Record "Payment Step Ledger";
        Text024: Label 'Vous n''avez pas l''autorisation de valider cette étape.';


    procedure ProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    var
        PaymentStatus: Record "Payment Status";
        Window: Dialog;
        ActionValidated: Boolean;
        PaymentStatus_gr: Record "Payment Status";
        PaymentStatus_bk: Record "Payment Status";
        Authorization: Record "ST Autorisation Etapes";
        PaytStep: Record "Payment Step";
        lPaymentHeader: Record "Payment Header";
        lPaymentStatus: Record "Payment Status";
        RecPaymenline: Record "Payment Line";
        RecpaymentStatus: Record "Payment Status";
        RecPaymentHeader: Record "Payment Header";
        LrecUserSetup: record "User Setup";
    begin
        lPaymentHeader.Get(PaymentHeaderNo);

        IF lPaymentStatus.GET(lPaymentHeader."Payment Class", PaymentStep."Next Status") THEN BEGIN
            IF lPaymentStatus."ST LC Ship. date mandatory" THEN
                lPaymentHeader.TestField("ST LC shipping date");

            if lPaymentStatus."ST LC valid. date mandatory" then
                lPaymentHeader.TestField("ST LC validity date");
        end;
        OnBeforeProcessPaymentStep(PaymentHeaderNo, PaymentStep);
        PaymentHeader.Get(PaymentHeaderNo);
        Actualiserstat(PaymentHeader);


        PaymentHeader.Get(PaymentHeaderNo);
        PaymentHeader.SetRange("No.", PaymentHeader."No.");

        if PaymentStep."Verify Header RIB" and not PaymentHeader."RIB Checked" then
            Error(Text008);
        if lrecusersetup.get(UserID) then;
        if lrecusersetup."ST Admin Payment Slip" = false then
            IF NOT Authorization.GET(PaymentStep."Payment Class", PaymentStep.Line, USERID) THEN
                ERROR(Text024);
        PaymentLine.SetRange("No.", PaymentHeader."No.");
        PaymentLine.SetRange("Copied To No.", '');

        if PaymentStep."Acceptation Code<>No" then begin
            PaymentLine.SetRange("Acceptation Code", PaymentLine."Acceptation Code"::No);
            if PaymentLine.Find('-') then
                Error(Text002);
            PaymentLine.SetRange("Acceptation Code");
        end;

        if PaymentStep."Verify Lines RIB" then begin
            PaymentLine.SetRange("RIB Checked", false);
            if PaymentLine.Find('-') then
                Error(Text003);
            PaymentLine.SetRange("RIB Checked");
        end;

        if PaymentStep."Verify Due Date" then begin
            PaymentLine.SetRange("Due Date", 0D);
            if PaymentLine.Find('-') then
                Error(Text006);
            PaymentLine.SetRange("Due Date");
        end;
        //Controles
        IF PaymentStatus_gr.GET(PaymentHeader."Payment Class", PaymentStep."Next Status") THEN BEGIN
            IF PaymentStatus_gr."STObligatoire Cheque/Traite" THEN BEGIN
                PaymentLine.SETRANGE("No.", PaymentHeader."No.");
                IF PaymentLine.FIND('-') THEN
                    PaymentLine.TESTFIELD("External Document No.");
            END;
            if PaymentStatus_gr."STObligatoire Commentaire" then begin
                PaymentLine.SETRANGE("No.", PaymentHeader."No.");
                IF PaymentLine.FIND('-') THEN
                    PaymentLine.TestField(STCommentaires);
            end;



            if PaymentStatus_gr."STDue Date Obligatoire" then begin
                PaymentLine.SETRANGE("No.", PaymentHeader."No.");
                IF PaymentLine.FIND('-') THEN
                    PaymentLine.TestField("Due Date");
            end;



        END;
        IF PaymentStep.STCode_Motif_Obligatoir THEN begin
            PaymentLine.SETRANGE("No.", PaymentHeader."No.");
            IF PaymentLine.FIND('-') THEN
                PaymentLine.TESTFIELD(PaymentLine.STCode_Motif);
        end;
        IF PaymentStatus_bk.GET(PaymentHeader."Payment Class") THEN
            if PaymentStatus_bk."STObligatoire Code Banque" then begin
                PaymentLine.SETRANGE("No.", PaymentHeader."No.");
                IF PaymentLine.FIND('-') THEN
                    PaymentLine.TestField("Bank Account Code");
            end;

        PaytStep.Reset();
        PaytStep.SetFilter(PaytStep."Payment Class", PaymentHeader."Payment Class");
        PaytStep.SetRange(PaytStep."Previous Status", PaymentHeader."Status No.");
        IF PaytStep.FindFirst() THEN BEGIN
            if PaytStep."STBanque Entête Obligatoire" then
                IF PaymentHeader.FIND('-') THEN
                    PaymentHeader.TestField("Account No.");
            if PaytStep."STTiré Oblig." then
                IF PaymentLine.FIND('-') THEN
                    PaymentLine.TestField("STDrawee Reference1");
        end;

        OnafterCheckProcessPaymentStep(PaymentHeaderNo, PaymentStep);

        //Controlles
        Step.Get(PaymentStep."Payment Class", PaymentStep.Line);

        PaymentStatus.GET(PaymentHeader."Payment Class", Step."Next Status");
        IF PaymentStatus."ST Status" <> PaymentStatus."ST Status"::Printed THEN BEGIN
            PaymentLine.SETFILTER("Copied To No.", '<>%1', '');
            IF PaymentLine.FINDSET() THEN
                ERROR(Err001, PaymentLine."Copied To No.");
            PaymentLine.SETRANGE("Copied To No.");
        END;

        case Step."Action Type" of
            Step."Action Type"::None:
                ActionValidated := true;
            Step."Action Type"::"Cancel File":
                begin
                    PaymentHeader."File Export Completed" := false;
                    PaymentHeader.Modify();
                    ActionValidated := true;
                end;
            Step."Action Type"::File:
                begin
                    PaymentHeader."File Export Completed" := false;
                    PaymentHeader.Modify();
                    Commit();

                    case Step."Export Type" of
                        Step."Export Type"::Report:
                            REPORT.RunModal(Step."Export No.", true, false, PaymentHeader);
                        Step."Export Type"::XMLport:
                            RunXmlPortExport(Step."Export No.", PaymentHeader);
                    end;

                    PaymentHeader.Find();
                    ActionValidated := PaymentHeader."File Export Completed";
                end;
            Step."Action Type"::Report:
                begin
                    REPORT.RunModal(Step."Report No.", true, true, PaymentHeader);
                    ActionValidated := true;
                end;
            Step."Action Type"::Ledger:
                begin
                    InvPostingBuffer[1].DeleteAll();
                    CheckDim();
                    Window.Open(
                      '#1#################################\\' +
                      Text005);
                    if PaymentLine.Find('-') then
                        repeat
                            Window.Update(1, Text005 + ' ' + PaymentLine."No." + ' ' + Format(PaymentLine."Line No."));
                            OldPaymentLine := PaymentLine;
                            HeaderAccountUsedGlobally := false;
                            GenerInvPostingBuffer();
                            PaymentLine."Acc. Type Last Entry Debit" := EntryTypeDebit;
                            PaymentLine."Acc. No. Last Entry Debit" := EntryNoAccountDebit;
                            PaymentLine."P. Group Last Entry Debit" := EntryPostGroupDebit;
                            PaymentLine."Acc. Type Last Entry Credit" := EntryTypeCredit;
                            PaymentLine."Acc. No. Last Entry Credit" := EntryNoAccountCredit;
                            PaymentLine."P. Group Last Entry Credit" := EntryPostGroupCredit;
                            PaymentLine.Validate("Status No.", Step."Next Status");
                            onbeforemodifyledgerpayline(PaymentLine, Step);
                            PaymentLine.Posted := true;

                            PaymentLine.Modify();


                        until PaymentLine.Next() = 0;
                    Window.Close();
                    GenerEntries();
                    ActionValidated := true;
                end;
        end;

        if ActionValidated then begin
            IF Step."STCode Coffre" <> '' THEN
                PaymentHeader.STCoffre := Step."STCode Coffre";
            PaymentHeader.Validate("Status No.", Step."Next Status");
            PaymentHeader.Modify();
            PaymentLine.SetRange("No.", PaymentHeader."No.");
            PaymentLine.ModifyAll("Status No.", Step."Next Status");
            IF Step."STCode Coffre" <> '' THEN
                PaymentLine.MODIFYALL(PaymentLine.STCoffre, Step."STCode Coffre");
            PaymentStatus.Get(PaymentHeader."Payment Class", Step."Next Status");
            PaymentLine.ModifyAll("Payment in Progress", PaymentStatus."Payment in Progress");
        end else
            Message(Text007);
        OnAfterProcessPaymentStep(PaymentHeaderNo, PaymentStep);
        RecPaymentHeader.get(PaymentHeaderNo);
        RecpaymentStatus.get(RecPaymentHeader."Payment Class", RecPaymentHeader."Status No.");
        RecPaymentHeader.validate(STCodeSituationPaiement, RecpaymentStatus.STCodeSituationPaiement);
        RecPaymentHeader.Modify();
    end;


    procedure UpdtBuffer()
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        InvPostingBuffer[2] := InvPostingBuffer[1];
        if InvPostingBuffer[2].Find() then begin
            InvPostingBuffer[2].Validate(Amount, InvPostingBuffer[2].Amount + InvPostingBuffer[1].Amount);
            InvPostingBuffer[2]."Amount (LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(PaymentHeader."Posting Date",
                  PaymentHeader."Currency Code", InvPostingBuffer[2].Amount, PaymentHeader."Currency Factor"));
            InvPostingBuffer[2]."VAT Amount" :=
              InvPostingBuffer[2]."VAT Amount" + InvPostingBuffer[1]."VAT Amount";
            InvPostingBuffer[2]."Line Discount Amount" :=
              InvPostingBuffer[2]."Line Discount Amount" + InvPostingBuffer[1]."Line Discount Amount";
            if InvPostingBuffer[1]."Line Discount Account" <> '' then
                InvPostingBuffer[2]."Line Discount Account" := InvPostingBuffer[1]."Line Discount Account";
            InvPostingBuffer[2]."Inv. Discount Amount" :=
              InvPostingBuffer[2]."Inv. Discount Amount" + InvPostingBuffer[1]."Inv. Discount Amount";
            if InvPostingBuffer[1]."Inv. Discount Account" <> '' then
                InvPostingBuffer[2]."Inv. Discount Account" := InvPostingBuffer[1]."Inv. Discount Account";
            InvPostingBuffer[2]."VAT Base Amount" :=
              InvPostingBuffer[2]."VAT Base Amount" + InvPostingBuffer[1]."VAT Base Amount";
            InvPostingBuffer[2]."Amount (ACY)" :=
              InvPostingBuffer[2]."Amount (ACY)" + InvPostingBuffer[1]."Amount (ACY)";
            InvPostingBuffer[2]."VAT Amount (ACY)" :=
              InvPostingBuffer[2]."VAT Amount (ACY)" + InvPostingBuffer[1]."VAT Amount (ACY)";
            InvPostingBuffer[2]."VAT Difference" :=
              InvPostingBuffer[2]."VAT Difference" + InvPostingBuffer[1]."VAT Difference";
            InvPostingBuffer[2]."Line Discount Amt. (ACY)" :=
              InvPostingBuffer[2]."Line Discount Amt. (ACY)" +
              InvPostingBuffer[1]."Line Discount Amt. (ACY)";
            InvPostingBuffer[2]."Inv. Discount Amt. (ACY)" :=
              InvPostingBuffer[2]."Inv. Discount Amt. (ACY)" +
              InvPostingBuffer[1]."Inv. Discount Amt. (ACY)";
            InvPostingBuffer[2]."VAT Base Amount (ACY)" :=
              InvPostingBuffer[2]."VAT Base Amount (ACY)" +
              InvPostingBuffer[1]."VAT Base Amount (ACY)";
            InvPostingBuffer[2].Quantity :=
              InvPostingBuffer[2].Quantity + InvPostingBuffer[1].Quantity;
            if not InvPostingBuffer[1]."System-Created Entry" then
                InvPostingBuffer[2]."System-Created Entry" := false;
            InvPostingBuffer[2].Modify();
        end else begin
            GLEntryNoTmp += 1;
            InvPostingBuffer[1]."GL Entry No." := GLEntryNoTmp;
            InvPostingBuffer[1].Insert();
        end;
    end;


    procedure CopyLigBor(var FromPaymentLine: Record "Payment Line"; NewStep: Integer; var PayNum: Code[20])
    var
        ToBord: Record "Payment Header";
        ToPaymentLine: Record "Payment Line";
        Step: Record "Payment Step";
        Process: Record "Payment Class";
        PaymentStatus: Record "Payment Status";
        NoSeriesMgt: Codeunit "No. Series";
        i: Integer;
        payheader: Record "Payment Header";
        bque, bque1 : Code[20];
    begin
        if FromPaymentLine.Find('-') then begin
            Step.Get(FromPaymentLine."Payment Class", NewStep);
            Process.Get(FromPaymentLine."Payment Class");
            if PayNum = '' then begin
                i := 10000;
                ToBord."No. Series" := Step."Header Nos. Series";
                ToBord."No." := NoSeriesMgt.GetNextNo(ToBord."No. Series");
                ToBord."Payment Class" := FromPaymentLine."Payment Class";
                ToBord."Status No." := Step."Next Status";
                PaymentStatus.Get(ToBord."Payment Class", ToBord."Status No.");
                ToBord."Archiving Authorized" := PaymentStatus."Archiving Authorized";
                ToBord."Currency Code" := FromPaymentLine."Currency Code";
                ToBord."Currency Factor" := FromPaymentLine."Currency Factor";
                //InitHeader;
                ToBord.STInitHeader();
                ToBord.Insert();
            end else begin
                ToBord.Get(PayNum);
                ToPaymentLine.SetRange("No.", PayNum);
                if ToPaymentLine.FindLast() then
                    i := ToPaymentLine."Line No." + 10000
                else
                    i := 10000;
            end;

            //<< ---------------
            payheader.RESET();
            payheader.GET(FromPaymentLine."No.");
            BEGIN
                ToBord.VALIDATE("Account No.", payheader."Account No.");
                ToBord.VALIDATE(STCoffre, payheader.STCoffre);
                ToBord."STType Règlement" := payheader."STType Règlement";
                ToBord.MODIFY();
            END;
            FromPaymentLine.CalcFields("Banque Societe");
            bque := FromPaymentLine."Banque Societe";
            //>>----------------

            repeat
                //<< ---------------
                FromPaymentLine.CalcFields("Banque Societe");
                bque1 := FromPaymentLine."Banque Societe";
                IF bque1 <> bque THEN
                    Error('Vous avez inséré des banques différentes');
                IF FromPaymentLine."Copied To No." <> '' THEN
                    ERROR('Cette ligne a été traitée dans un autre bordereau!');
                //>> ----------------
                ToPaymentLine.Copy(FromPaymentLine);
                ToPaymentLine."No." := ToBord."No.";
                ToPaymentLine."Line No." := i;
                ToPaymentLine.IsCopy := true;
                ToPaymentLine."Status No." := Step."Next Status";
                ToPaymentLine."Copied To No." := '';
                ToPaymentLine."Copied To Line" := 0;
                ToPaymentLine.Posted := false;
                ToPaymentLine."Created from No." := FromPaymentLine."No.";
                ToPaymentLine."Dimension Set ID" := FromPaymentLine."Dimension Set ID";

                if FromPaymentLine."STSlip Origin No." <> '' then begin
                    ToPaymentLine."STSlip Origin No." := FromPaymentLine."STSlip Origin No.";
                    ToPaymentLine."STSlip Origin line No." := FromPaymentLine."STSlip Origin line No.";
                end else begin
                    ToPaymentLine."STSlip Origin No." := FromPaymentLine."No.";
                    topaymentline."STSlip Origin line No." := FromPaymentLine."Line No.";
                end;

                ToPaymentLine.Insert(true);
                //<<---------
                ToPaymentLine."STMontant Retenue" := FromPaymentLine."STMontant Retenue";
                ToPaymentLine."STMontant Retenue Validé" := FromPaymentLine."STMontant Retenue Validé";
                ToPaymentLine."STMontant Retenue DS" := FromPaymentLine."STMontant Retenue DS";
                ToPaymentLine."STMontant Retenue Validé DS" := FromPaymentLine."STMontant Retenue Validé DS";
                ToPaymentLine."STCoffre Origine" := FromPaymentLine."STCoffre Origine";
                ToPaymentLine."STType Règlement" := ToBord."STType Règlement";
                ToPaymentLine."Status No." := ToBord."Status No.";
                ToPaymentLine.MODIFY();
                //>> ------------
                FromPaymentLine."Copied To No." := ToPaymentLine."No.";
                FromPaymentLine."Copied To Line" := ToPaymentLine."Line No.";
                FromPaymentLine.Modify();
                i += 10000;
            until FromPaymentLine.Next() = 0;
            PayNum := ToBord."No.";
        end;
    end;


    procedure DeleteLigBorCopy(var FromPaymentLine: Record "Payment Line")
    var
        ToPaymentLine: Record "Payment Line";
    begin
        ToPaymentLine.SetCurrentKey("Copied To No.", "Copied To Line");

        if FromPaymentLine.Find('-') then
            if FromPaymentLine.Posted then
                Message(Text016)
            else
                repeat
                    ToPaymentLine.SetRange("Copied To No.", FromPaymentLine."No.");
                    ToPaymentLine.SetRange("Copied To Line", FromPaymentLine."Line No.");
                    ToPaymentLine.FindFirst();
                    ToPaymentLine."Copied To No." := '';
                    ToPaymentLine."Copied To Line" := 0;
                    ToPaymentLine.Modify();
                    FromPaymentLine.Delete(true);
                until FromPaymentLine.Next() = 0;
    end;


    procedure GenerInvPostingBuffer()
    var
        PaymentClass: Record "Payment Class";
        NoSeriesMgt: Codeunit "No. Series";
        Description: Text;
        Text023: Label 'Veuillez saisir le compte enête';
        DimensionSetEntry: Record "Dimension Set Entry";
        RecGeneralLedgerSetup: Record "General Ledger Setup";
        NoSeriesbatch: Codeunit "No. Series - Batch";
    begin
        StepLedger.SetRange("Payment Class", Step."Payment Class");
        StepLedger.SetRange(Line, Step.Line);

        if StepLedger.Find('-') then begin
            repeat
                Clear(InvPostingBuffer[1]);
                SetPostingGroup();
                SetAccountNo();
                InvPostingBuffer[1]."System-Created Entry" := true;
                // // // if StepLedger.Sign = StepLedger.Sign::Debit then begin
                // // //     InvPostingBuffer[1].Validate(Amount, Abs(PaymentLine.Amount));
                // // //     InvPostingBuffer[1].Validate("Amount (LCY)", Abs(PaymentLine."Amount (LCY)"));
                // // // end else begin
                // // //     InvPostingBuffer[1].Validate(Amount, Abs(PaymentLine.Amount) * -1);
                // // //     InvPostingBuffer[1].Validate("Amount (LCY)", Abs(PaymentLine."Amount (LCY)") * -1);
                // // // end;

                //Controles
                IF StepLedger."STBlocage Frs Solde Debit" = TRUE THEN
                    IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN BEGIN
                        Vendor.RESET();
                        Vendor.GET(PaymentLine."Account No.");
                        Vendor.CALCFIELDS("Balance (LCY)");
                        IF Vendor."Balance (LCY)" < 0 THEN
                            ERROR(Text023, PaymentLine."Account No.");
                    END;
                //Controles
                StepLedgerTmp.Reset();
                Clear(StepLedgerTmp);
                RecGeneralLedgerSetup.Get();
                IF StepLedger.Sign = StepLedger.Sign::Debit THEN BEGIN
                    IF StepLedgerTmp.GET(Step."Payment Class", Step.Line, StepLedger.Sign::Credit) THEN;
                    IF (StepLedgerTmp."STCompta. Retenue à la source") THEN BEGIN
                        InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount - PaymentLine."STMontant Retenue"));
                        InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."STMontant Retenue DS"));
                    END
                    ELSE
                        if StepLedgerTmp."STAnnuler Compta Retn. à la Sour" THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount - PaymentLine."STMontant Retenue Validé"));
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."STMontant Retenue Validé DS"));
                        END
                        else begin
                            InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount));
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)"));
                        end;
                    IF (PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor) THEN BEGIN
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Commission DS"));
                        END;
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte TVA/Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant TVA Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant TVA Commission DS"));
                        END;

                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."StCompte Int" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Interret");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Interret DS"));
                        END;
                    END;

                    IF StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Header Payment Account" THEN BEGIN
                        IF (PaymentLine."Account Type" = PaymentLine."Account Type"::Customer) THEN BEGIN
                            IF (StepLedger."stInclure Commission") AND (StepLedger."stCompte Commission" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Commission");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Commission DS"));
                            END;
                            IF (StepLedger."stInclure Commission") AND (StepLedger."stCompte TVA/Commission" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant TVA Commission");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant TVA Commission DS"));
                            END;
                            IF (StepLedger."stInclure Commission") AND (StepLedger."StCompte Int" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Interret");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Interret DS"));
                            END;
                        END;
                    END ELSE
                        IF (PaymentLine."Account Type" = PaymentLine."Account Type"::Customer) THEN BEGIN
                            IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte Commission" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant Commission");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant Commission DS"));
                            END;
                            IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte TVA/Commission" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant TVA Commission");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant TVA Commission DS"));
                            END;
                            IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte Int" <> '') THEN BEGIN
                                InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant Interret");
                                InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant Interret DS"));
                            END;
                        END;
                    InvPostingBuffer[1].VALIDATE(Amount, ABS(InvPostingBuffer[1].Amount));
                    InvPostingBuffer[1].VALIDATE("Amount (LCY)", ABS(InvPostingBuffer[1]."Amount (LCY)"));
                    // //Controles
                    // IF StepLedger."Blocage Frs Solde Debit" = TRUE THEN BEGIN
                    //     IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN BEGIN
                    //         Vendor.RESET;
                    //         Vendor.GET(PaymentLine."Account No.");
                    //         Vendor.CALCFIELDS("Balance (LCY)");
                    //         IF Vendor."Balance (LCY)" < 0 THEN
                    //             ERROR(Text023, PaymentLine."Account No.");
                    //     END;
                    // END;
                    // //Controles
                END ELSE BEGIN
                    IF StepLedgerTmp.GET(Step."Payment Class", Step.Line, StepLedger.Sign::Debit) THEN;
                    IF (StepLedgerTmp."STCompta. Retenue à la source") THEN BEGIN
                        InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount - PaymentLine."STMontant Retenue") * -1);
                        InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."STMontant Retenue DS") * -1);
                    END ELSE
                        IF StepLedgerTmp."STAnnuler Compta Retn. à la Sour" THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount - PaymentLine."STMontant Retenue Validé") * -1);
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)" - PaymentLine."STMontant Retenue Validé DS") * -1);
                        end
                        else begin
                            InvPostingBuffer[1].VALIDATE(Amount, (PaymentLine.Amount) * -1);
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (PaymentLine."Amount (LCY)") * -1);
                        end;

                    IF (PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor) THEN BEGIN
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant Commission DS"));
                        END;
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte TVA/Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant TVA Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant TVA Commission DS"));
                        END;
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."StCompte Int" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount - PaymentLine."stMontant Interret");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" - PaymentLine."stMontant Interret DS"));
                        END;
                    END;

                    IF (PaymentLine."Account Type" = PaymentLine."Account Type"::Customer) AND
                    (StepLedgerTmp."Accounting Type" <> StepLedgerTmp."Accounting Type"::"Header Payment Account") THEN BEGIN
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Commission DS"));
                        END;
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."stCompte TVA/Commission" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant TVA Commission");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant TVA Commission DS"));
                        END;
                        IF (StepLedgerTmp."stInclure Commission") AND (StepLedgerTmp."StCompte Int" <> '') THEN BEGIN
                            InvPostingBuffer[1].VALIDATE(Amount, InvPostingBuffer[1].Amount + PaymentLine."stMontant Interret");
                            InvPostingBuffer[1].VALIDATE("Amount (LCY)", (InvPostingBuffer[1]."Amount (LCY)" + PaymentLine."stMontant Interret DS"));
                        END;

                    END;

                    // //Controles
                    // IF StepLedger."Blocage Frs Solde Debit" = TRUE THEN BEGIN
                    //     IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN BEGIN
                    //         Vendor.RESET;
                    //         Vendor.GET(PaymentLine."Account No.");
                    //         Vendor.CALCFIELDS("Balance (LCY)");
                    //         IF Vendor."Balance (LCY)" < 0 THEN
                    //             ERROR(Text023, PaymentLine."Account No.");
                    //     END;
                    // END;
                    // //Controles
                    InvPostingBuffer[1].VALIDATE(Amount, -ABS(InvPostingBuffer[1].Amount));
                    InvPostingBuffer[1].VALIDATE("Amount (LCY)", -ABS(InvPostingBuffer[1]."Amount (LCY)"));

                end;
                if PaymentLine.STCommentaires <> '' then
                    InvPostingBuffer[1].STCommentaires := PaymentLine.STCommentaires;

                InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
                InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
                InvPostingBuffer[1].Correction := PaymentLine.Correction xor Step.Correction;
                InvPostingBuffer[1].STOption := Step.STOption;
                if StepLedger."Detail Level" = StepLedger."Detail Level"::Line then
                    InvPostingBuffer[1]."Payment Line No." := PaymentLine."Line No."
                else
                    if StepLedger."Detail Level" = StepLedger."Detail Level"::"Due Date" then
                        InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date";

                InvPostingBuffer[1]."Document Type" := StepLedger."Document Type";
                if StepLedger."Document No." = StepLedger."Document No."::"Header No." then
                    InvPostingBuffer[1]."Document No." := PaymentHeader."No."
                else begin
                    if (InvPostingBuffer[1].Sign = InvPostingBuffer[1].Sign::Positive) and
                       (PaymentLine."Entry No. Debit" = 0) and (PaymentLine."Entry No. Credit" = 0)
                    then begin
                        PaymentClass.Get(PaymentHeader."Payment Class");
                        if PaymentClass."Line No. Series" = '' then
                            PaymentLine.TestField("Document No.", NoSeriesMgt.GetNextNo(PaymentHeader."No. Series", PaymentLine."Posting Date", false))
                        else
                            PaymentLine.TestField("Document No.", NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", PaymentLine."Posting Date",
                                false));
                    end;
                    InvPostingBuffer[1]."Document No." := PaymentLine."Document No.";
                end;
                InvPostingBuffer[1]."Header Document No." := PaymentHeader."No.";
                if StepLedger.Sign = StepLedger.Sign::Debit then begin
                    EntryTypeDebit := InvPostingBuffer[1]."Account Type";
                    EntryNoAccountDebit := InvPostingBuffer[1]."Account No.";
                    EntryPostGroupDebit := InvPostingBuffer[1]."Posting Group";
                end else begin
                    EntryTypeCredit := InvPostingBuffer[1]."Account Type";
                    EntryNoAccountCredit := InvPostingBuffer[1]."Account No.";
                    EntryPostGroupCredit := InvPostingBuffer[1]."Posting Group";
                end;
                InvPostingBuffer[1]."System-Created Entry" := true;
                Application();
                PaymentClass.Get(PaymentHeader."Payment Class");
                if (PaymentClass."Unrealized VAT Reversal" = PaymentClass."Unrealized VAT Reversal"::Delayed) and
                   Step."Realize VAT"
                then begin
                    InvPostingBuffer[1]."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                    InvPostingBuffer[1]."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                    if InvPostingBuffer[1]."Applies-to ID" = '' then
                        InvPostingBuffer[1]."Applies-to ID" := PaymentLine."Applies-to ID";
                    InvPostingBuffer[1]."Created from No." := PaymentLine."Created from No.";
                end;
                if Vendor.GET(PaymentLine."Account No.") then;
                Description :=
                  StrSubstNo(StepLedger.Description, PaymentLine."Due Date", PaymentLine."Account No.", PaymentLine."Document No.", PaymentLine."Applies-to Invoices Nos.", Vendor.Name, PaymentLine."External Document No.", PaymentLine.STCommentaires);
                InvPostingBuffer[1].Description := CopyStr(Description, 1, 50);
                InvPostingBuffer[1]."Source Type" := PaymentLine."Account Type";
                InvPostingBuffer[1]."Source No." := PaymentLine."Account No.";
                InvPostingBuffer[1]."External Document No." := PaymentLine."External Document No.";
                InvPostingBuffer[1]."Dimension Set ID" := PaymentLine."Dimension Set ID";
                if DimensionSetEntry.Get(PaymentHeader."Dimension Set ID", RecGeneralLedgerSetup."Global Dimension 1 Code") then
                    InvPostingBuffer[1]."Global Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                DimensionSetEntry.Reset();
                if DimensionSetEntry.Get(PaymentLine."Dimension Set ID", RecGeneralLedgerSetup."Global Dimension 2 Code") then
                    InvPostingBuffer[1]."Global Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                InvPostingBuffer[1]."STOrder No." := PaymentLine."STOrder No."; //
                InvPostingBuffer[1]."STPayment Method Code" := GetPaymentMethodFromPaymentHeader(Step."Payment Class");
                InvPostingBuffer[1].STCoffre := PaymentLine.STCoffre;
                InvPostingBuffer[1]."STSlip Origin No." := PaymentLine."STSlip Origin No.";
                InvPostingBuffer[1]."STSlip Origin line No." := PaymentLine."STSlip Origin line No.";
                OnGenerInvPostingBufferOnBeforeUpdtBuffer(InvPostingBuffer, PaymentLine, StepLedger);
                OnGenerInvPostingBufferOnBeforeUpdtBuffer2(InvPostingBuffer, PaymentLine, StepLedger, PaymentHeader);
                UpdtBuffer();
                GenererInv();

                // OnGenerInvPostingBufferOnAfterUpdtBuffer(InvPostingBuffer, PaymentLine, StepLedger, Step);

                if (InvPostingBuffer[1].Amount >= 0) xor InvPostingBuffer[1].Correction then
                    PaymentLine."Entry No. Debit" := InvPostingBuffer[1]."GL Entry No."
                else
                    PaymentLine."Entry No. Credit" := InvPostingBuffer[1]."GL Entry No.";
            until StepLedger.Next() = 0;
            NoSeriesBatch.SaveState();
        end;
    end;



    procedure SetPostingGroup()
    var
        PostingGroup: Code[20];
    begin
        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
            if ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Payment Line Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Associated G/L Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Header Payment Account") or
                ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Setup Account") and
                 (StepLedger."Account Type" = StepLedger."Account Type"::Customer)))
            then begin
                if StepLedger."Customer Posting Group" <> '' then
                    PostingGroup := StepLedger."Customer Posting Group"
                else
                    if PaymentLine."Posting Group" <> '' then
                        PostingGroup := PaymentLine."Posting Group"
                    else begin
                        Customer.Get(PaymentLine."Account No.");
                        PostingGroup := Customer."Customer Posting Group";
                    end;
                if not CustomerPostingGroup.Get(PostingGroup) then
                    Error(Text012, PostingGroup);
                if CustomerPostingGroup."Receivables Account" = '' then
                    Error(Text014, PostingGroup);
            end;

        if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
            if ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Payment Line Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Associated G/L Account") or
                (StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Header Payment Account") or
                ((StepLedger."Accounting Type" = StepLedger."Accounting Type"::"Setup Account") and
                 (StepLedger."Account Type" = StepLedger."Account Type"::Vendor)))
            then begin
                if StepLedger."Vendor Posting Group" <> '' then
                    PostingGroup := StepLedger."Vendor Posting Group"
                else
                    if PaymentLine."Posting Group" <> '' then
                        PostingGroup := PaymentLine."Posting Group"
                    else begin
                        Vendor.Get(PaymentLine."Account No.");
                        PostingGroup := Vendor."Vendor Posting Group";
                    end;
                if not VendorPostingGroup.Get(PostingGroup) then
                    Error(Text012, PostingGroup);
                if VendorPostingGroup."Payables Account" = '' then
                    Error(Text014, PostingGroup);
            end;
    end;


    procedure SetAccountNo()
    var
        lBankAccount: Record "Bank Account";
    begin
        case StepLedger."Accounting Type" of
            StepLedger."Accounting Type"::"Payment Line Account":
                begin
                    InvPostingBuffer[1]."Account Type" := PaymentLine."Account Type";
                    InvPostingBuffer[1]."Account No." := PaymentLine."Account No.";
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
                        InvPostingBuffer[1]."Posting Group" := CustomerPostingGroup.Code;
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor then
                        InvPostingBuffer[1]."Posting Group" := VendorPostingGroup.Code;
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                    DimMgt.UpdateGlobalDimFromDimSetID(PaymentLine."Dimension Set ID",
                      InvPostingBuffer[1]."Global Dimension 1 Code", InvPostingBuffer[1]."Global Dimension 2 Code");
                end;
            StepLedger."Accounting Type"::"Associated G/L Account":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
                        InvPostingBuffer[1]."Account No." := CustomerPostingGroup."Receivables Account"
                    else
                        InvPostingBuffer[1]."Account No." := VendorPostingGroup."Payables Account";
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Setup Account":
                begin
                    InvPostingBuffer[1]."Account Type" := StepLedger."Account Type";
                    InvPostingBuffer[1]."Account No." := StepLedger."Account No.";
                    if StepLedger."Account No." = '' then begin
                        PaymentHeader.CalcFields("Payment Class Name");
                        if StepLedger.Sign = StepLedger.Sign::Debit then
                            Error(Text018, Step.Name, PaymentHeader."Payment Class Name");

                        Error(Text019, Step.Name, PaymentHeader."Payment Class Name");
                    end;
                    if StepLedger."Account Type" = StepLedger."Account Type"::Customer then
                        InvPostingBuffer[1]."Posting Group" := StepLedger."Customer Posting Group"
                    else
                        InvPostingBuffer[1]."Posting Group" := StepLedger."Vendor Posting Group";
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"G/L Account / Month":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    N := Date2DMY(PaymentLine."Due Date", 2);
                    if N < 10 then
                        Suffix := '0' + Format(N)
                    else
                        Suffix := Format(N);
                    InvPostingBuffer[1]."Account No." := CopyStr(StepLedger.Root + Suffix, 1, MaxStrLen(InvPostingBuffer[1]."Account No."));
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"G/L Account / Week":
                begin
                    InvPostingBuffer[1]."Account Type" := InvPostingBuffer[1]."Account Type"::"G/L Account";
                    N := Date2DWY(PaymentLine."Due Date", 2);
                    if N < 10 then
                        Suffix := '0' + Format(N)
                    else
                        Suffix := Format(N);
                    InvPostingBuffer[1]."Account No." := CopyStr(StepLedger.Root + Suffix, 1, MaxStrLen(InvPostingBuffer[1]."Account No."));
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Bal. Account Previous Entry":
                begin
                    if (StepLedger.Sign = StepLedger.Sign::Debit) and not (PaymentLine.Correction xor Step.Correction) then begin
                        InvPostingBuffer[1]."Account Type" := PaymentLine."Acc. Type Last Entry Credit";
                        InvPostingBuffer[1]."Account No." := PaymentLine."Acc. No. Last Entry Credit";
                        InvPostingBuffer[1]."Posting Group" := PaymentLine."P. Group Last Entry Credit";
                    end else begin
                        InvPostingBuffer[1]."Account Type" := PaymentLine."Acc. Type Last Entry Debit";
                        InvPostingBuffer[1]."Account No." := PaymentLine."Acc. No. Last Entry Debit";
                        InvPostingBuffer[1]."Posting Group" := PaymentLine."P. Group Last Entry Debit";
                    end;
                    InvPostingBuffer[1]."Line No." := PaymentLine."Line No.";
                end;
            StepLedger."Accounting Type"::"Header Payment Account":
                begin
                    InvPostingBuffer[1]."Account Type" := PaymentHeader."Account Type";
                    InvPostingBuffer[1]."Account No." := PaymentHeader."Account No.";
                    if PaymentHeader."Account No." = '' then
                        Error(Text020);
                    if StepLedger."Detail Level" = StepLedger."Detail Level"::Account then
                        HeaderAccountUsedGlobally := true;
                    InvPostingBuffer[1]."Line No." := 0;
                    DimMgt.UpdateGlobalDimFromDimSetID(PaymentHeader."Dimension Set ID",
                      InvPostingBuffer[1]."Global Dimension 1 Code", InvPostingBuffer[1]."Global Dimension 2 Code");
                end;
        end;
        OnaftersetaccountNo(PaymentHeader, PaymentLine, StepLedger, InvPostingBuffer);
        if (StepLedger."Accounting Type" <> StepLedger."Accounting Type"::"Header Payment Account") then
            exit;
        if not (StepLedger."ST Account vendor LC") then
            exit;
        PaymentHeader.TestField("Account Type", PaymentHeader."Account Type"::"Bank Account");
        PaymentHeader.TestField("Account No.");
        lBankAccount.get(PaymentHeader."Account No.");
        lBankAccount.TestField("ST Vendor LC");
        InvPostingBuffer[1]."Account Type" := StepLedger."Account Type"::Vendor;
        InvPostingBuffer[1]."Account No." := "lBankAccount"."ST Vendor LC";
    end;


    procedure Application()
    begin
        if StepLedger.Application <> StepLedger.Application::None then
            if StepLedger.Application = StepLedger.Application::"Applied Entry" then begin
                InvPostingBuffer[1]."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type";
                InvPostingBuffer[1]."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
                InvPostingBuffer[1]."Applies-to ID" := PaymentLine."Applies-to ID";
            end else
                if StepLedger.Application = StepLedger.Application::"Entry Previous Step" then begin
                    InvPostingBuffer[1]."Applies-to ID" := PaymentLine."No." + '/' + Format(PaymentLine."Line No.") + Text011;
                    if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer then begin
                        if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                            CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit")
                        else
                            CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit");
                        if CustLedgerEntry.FindFirst() then begin
                            CustLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                            CustLedgerEntry.CalcFields("Remaining Amount");
                            CustLedgerEntry.Validate("Amount to Apply", CustLedgerEntry."Remaining Amount");
                            CustLedgerEntry.Modify();
                        end;
                    end else
                        if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor then begin
                            if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit")
                            else
                                VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit");
                            if VendorLedgerEntry.FindFirst() then begin
                                VendorLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                VendorLedgerEntry.CalcFields("Remaining Amount");
                                VendorLedgerEntry.Validate("Amount to Apply", VendorLedgerEntry."Remaining Amount");
                                VendorLedgerEntry.Modify();
                            end;
                        end;
                end else
                    if StepLedger.Application = StepLedger.Application::"Memorized Entry" then begin
                        InvPostingBuffer[1]."Applies-to ID" := PaymentLine."No." + '/' + Format(PaymentLine."Line No.") + Text011;
                        if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer then begin
                            CustLedgerEntry.Reset();
                            if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit Memo")
                            else
                                CustLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit Memo");
                            if CustLedgerEntry.FindFirst() then begin
                                CustLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                CustLedgerEntry.CalcFields("Remaining Amount");
                                CustLedgerEntry.Validate("Amount to Apply", CustLedgerEntry."Remaining Amount");
                                CustLedgerEntry.Modify();
                            end;
                        end else
                            if InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor then begin
                                if (InvPostingBuffer[1].Amount < 0) xor InvPostingBuffer[1].Correction then
                                    VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Debit Memo")
                                else
                                    VendorLedgerEntry.SetRange("Entry No.", OldPaymentLine."Entry No. Credit Memo");
                                if VendorLedgerEntry.FindFirst() then begin
                                    VendorLedgerEntry."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
                                    VendorLedgerEntry.CalcFields("Remaining Amount");
                                    VendorLedgerEntry.Validate("Amount to Apply", VendorLedgerEntry."Remaining Amount");
                                    VendorLedgerEntry.Modify();
                                end;
                            end;
                    end;
        if StepLedger."Detail Level" = StepLedger."Detail Level"::Account then begin
            if (InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Vendor) or
               (InvPostingBuffer[1]."Account Type" = InvPostingBuffer[1]."Account Type"::Customer)
            then
                InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date" // FR Payment due date
        end else
            InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date"; // FR Payment due date
    end;


    procedure GenerEntries()
    var
        Currency: Record Currency;
        Difference: Decimal;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        LastGLEntryNo: Integer;
    begin
        if InvPostingBuffer[1].Find('+') then
            repeat
                LastGLEntryNo := PostInvPostingBuffer();
                PaymentLine.Reset();
                PaymentLine.SetRange("No.", PaymentHeader."No.");
                PaymentLine.SetRange("Line No.");
                if GenJnlLine.Amount >= 0 then begin
                    TotalDebit := TotalDebit + GenJnlLine."Amount (LCY)";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Debit);
                    PaymentLine.SetRange("Entry No. Debit", InvPostingBuffer[1]."GL Entry No.");
                    if StepLedger."Memorize Entry" then
                        PaymentLine.ModifyAll(PaymentLine."Entry No. Debit Memo", LastGLEntryNo);
                    PaymentLine.ModifyAll("Entry No. Debit", LastGLEntryNo);
                    PaymentLine.SetRange("Entry No. Debit");
                end else begin
                    TotalCredit := TotalCredit + Abs(GenJnlLine."Amount (LCY)");
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Credit);
                    PaymentLine.SetRange("Entry No. Credit", InvPostingBuffer[1]."GL Entry No.");
                    if StepLedger."Memorize Entry" then
                        PaymentLine.ModifyAll(PaymentLine."Entry No. Credit Memo", LastGLEntryNo);
                    PaymentLine.ModifyAll("Entry No. Credit", LastGLEntryNo);
                    PaymentLine.SetRange("Entry No. Credit");
                end;

            until InvPostingBuffer[1].Next(-1) = 0;

        if HeaderAccountUsedGlobally then begin
            Difference := TotalDebit - TotalCredit;
            if Difference <> 0 then begin
                GenJnlLine.Init();
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                Currency.Get(PaymentHeader."Currency Code");
                if Difference < 0 then begin
                    GenJnlLine."Account No." := Currency."Unrealized Losses Acc.";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Debit);
                    GenJnlLine.Validate("Debit Amount", -Difference);
                end else begin
                    GenJnlLine."Account No." := Currency."Unrealized Gains Acc.";
                    StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Credit);
                    GenJnlLine.Validate("Credit Amount", Difference);
                end;
                GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
                GenJnlLine."Document No." := PaymentHeader."No.";
                GenJnlLine.Description := StrSubstNo(
                  Text100, StrSubstNo(StepLedger.Description, PaymentHeader."Document Date", '', PaymentHeader."No."));
                GenJnlLine."Shortcut Dimension 1 Code" := PaymentHeader."Shortcut Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := PaymentHeader."Dimension Set ID";
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
                GenJnlLine."Reason Code" := Step."Reason Code";
                GenJnlLine."Document Date" := PaymentHeader."Document Date";
                OnGenerEntriesOnBeforeGenJnlPostLineRunWithCheck(GenJnlLine, PaymentHeader, StepLedger);
                GenJnlPostLine.RunWithCheck(GenJnlLine);
            end;
        end;

        InvPostingBuffer[1].DeleteAll();
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        if No <> '' then begin
            i := StrLen(No);
            repeat
                IsDigit := No[i] in ['0' .. '9'];
                if IsDigit then begin
                    if EndPos = 0 then
                        EndPos := i;
                    StartPos := i;
                end;
                i := i - 1;
            until (i = 0) or (StartPos <> 0) and not IsDigit;
        end;
        if (StartPos = 0) and (EndPos = 0) then
            Error(Text021, No);
    end;


    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        Evaluate(DecimalNo, CopyStr(No, StartPos, EndPos - StartPos + 1));
        NewNo := Format(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    end;

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[30]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        if StartPos > 1 then
            StartNo := CopyStr(No, 1, StartPos - 1);
        if EndPos < StrLen(No) then
            EndNo := CopyStr(No, EndPos + 1);
        NewLength := StrLen(NewNo);
        OldLength := EndPos - StartPos + 1;
        if FixedLength > OldLength then
            OldLength := FixedLength;
        if OldLength > NewLength then
            ZeroNo := PadStr('', OldLength - NewLength, '0');
        if StrLen(StartNo) + StrLen(ZeroNo) + StrLen(NewNo) + StrLen(EndNo) > 20 then
            Error(Text001, No);

        No := CopyStr(StartNo + ZeroNo + NewNo + EndNo, 1, MaxStrLen(No));
    end;


    procedure STCreatePaymentHeaders()
    begin
        Step.SetRange("Action Type", Step."Action Type"::"Create New Document");

        if StepSelect('', -1, Step, true) then
            ExecuteCreatePaymtHead(Step);
    end;


    procedure ExecuteCreatePaymtHead(PaymtStep: Record "Payment Step"): Code[20]
    var
        Bor: Record "Payment Header";
        StatementForm: Page "Payment Slip";
        InserForm: Page "STPayment Lines List";
        PayNum: Code[20];
        UserSetup: Record "User Setup";
    begin
        IF UserSetup.GET(UPPERCASE(USERID)) THEN
            IF UserSetup.STCoffre <> '' THEN BEGIN
                PaymentLine.FILTERGROUP(2);
                PaymentLine.SETRANGE(STCoffre, UserSetup.STCoffre);
                PaymentLine.FILTERGROUP(0);
            END;

        PaymentLine.SetRange("Payment Class", PaymtStep."Payment Class");
        PaymentLine.SetRange("Status No.", PaymtStep."Previous Status");
        PaymentLine.SetRange("Copied To No.", '');
        PaymentLine.FilterGroup(2);
        InserForm.SetSteps(PaymtStep.Line);
        InserForm.SetTableView(PaymentLine);
        InserForm.LookupMode(true);
        InserForm.RunModal();
        PayNum := InserForm.GetNumBor();
        if Bor.Get(PayNum) then begin

            StatementForm.SetRecord(Bor);
            StatementForm.Run();
        end else
            Error(Text004);
        exit(PayNum);
    end;


    procedure LinesInsert(HeaderNumber: Code[20])
    var
        Header: Record "Payment Header";
        PaymentLine: Record "Payment Line";
        Step: Record "Payment Step";
        InserForm: Page "Payment Lines List";
    begin
        Header.Get(HeaderNumber);
        if StepSelect(Header."Payment Class", Header."Status No.", Step, false) then begin
            PaymentLine.SetRange("Payment Class", Header."Payment Class");
            PaymentLine.SetRange("Copied To No.", '');
            PaymentLine.SetFilter("Status No.", Format(Step."Previous Status"));
            PaymentLine.SetRange("Currency Code", Header."Currency Code");
            PaymentLine.FilterGroup(2);
            InserForm.SetSteps(Step.Line);
            InserForm.SetNumBor(Header."No.");
            InserForm.SetTableView(PaymentLine);
            InserForm.LookupMode(true);
            InserForm.RunModal();
        end;
    end;


    procedure StepSelect(Process: Text[30]; NextStatus: Integer; var Step: Record "Payment Step"; CreateDocumentFilter: Boolean) OK: Boolean
    var
        PaymentClass: Record "Payment Class";
        Options: Text[1000];
        Choice: Integer;
        i: Integer;
        LrecUserSetup: record "User Setup";
    begin
        OK := false;
        i := 0;
        if Process = '' then begin
            PaymentClass.SetRange(Enable, true);
            if CreateDocumentFilter then
                PaymentClass.SetRange("Is Create Document", true);
            if LrecUserSetup.get(USERID) then;
            if lrecusersetup."ST Admin Payment Slip" = false then begin
                PaymentClass.SETRANGE("ST User Filter", USERID);
                PaymentClass.SETRANGE("ST Visible", TRUE);
            END;
            if PaymentClass.Find('-') then
                repeat
                    i += 1;
                    if Options = '' then
                        Options := PaymentClass.Code
                    else
                        Options := Options + ',' + PaymentClass.Code;
                until PaymentClass.Next() = 0;
            if i > 0 then
                Choice := StrMenu(Options, 1);
            i := 1;
            if Choice > 0 then begin
                PaymentClass.Find('-');
                while Choice > i do begin
                    i += 1;
                    PaymentClass.Next();
                end;
            end;
        end else begin
            PaymentClass.Get(Process);
            Choice := 1;
        end;
        if Choice > 0 then begin
            Options := '';
            Step.SetRange("Payment Class", PaymentClass.Code);
            Step.SetRange("Action Type", Step."Action Type"::"Create New Document");
            if NextStatus > -1 then
                Step.SetRange("Next Status", NextStatus);
            i := 0;
            if Step.Find('-') then begin
                i += 1;
                repeat
                    if Options = '' then
                        Options := Step.Name
                    else
                        Options := Options + ',' + Step.Name;
                until Step.Next() = 0;
                if i > 0 then begin
                    Choice := StrMenu(Options, 1);
                    i := 1;
                    if Choice > 0 then begin
                        Step.Find('-');
                        while Choice > i do begin
                            i += 1;
                            Step.Next();
                        end;
                        OK := true;
                    end;
                end;
            end;
        end;
    end;

    local procedure CheckDimCombAndValue(PaymentLine2: Record "Payment Line")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        if PaymentLine."Line No." = 0 then begin
            if not DimMgt.CheckDimIDComb(PaymentHeader."Dimension Set ID") then
                Error(
                  Text009,
                  PaymentHeader."No.", DimMgt.GetDimCombErr());
            TableID[1] := DATABASE::"Payment Header";
            No[1] := PaymentHeader."No.";
            if not DimMgt.CheckDimValuePosting(TableID, No, PaymentHeader."Dimension Set ID") then
                ThrowPmtPostError(PaymentLine2, CheckDimVauePostingHeaderErr, DimMgt.GetDimValuePostingErr());
        end;

        if PaymentLine."Line No." <> 0 then begin
            if not DimMgt.CheckDimIDComb(PaymentLine2."Dimension Set ID") then
                Error(
                  Text010,
                  PaymentHeader."No.", PaymentLine2."Line No.", DimMgt.GetDimCombErr());
            TableID[1] := TypeToTableID(PaymentLine2."Account Type");
            No[1] := PaymentLine2."Account No.";
            if not DimMgt.CheckDimValuePosting(TableID, No, PaymentLine2."Dimension Set ID") then
                ThrowPmtPostError(PaymentLine2, CheckDimVauePostingLineErr, DimMgt.GetDimValuePostingErr());
        end;
    end;

    local procedure CheckDim()
    begin
        PaymentLine."Line No." := 0;
        CheckDimCombAndValue(PaymentLine);

        PaymentLine.SetRange("No.", PaymentHeader."No.");
        if PaymentLine.FindSet() then
            repeat
                CheckDimCombAndValue(PaymentLine);
            until PaymentLine.Next() = 0;
    end;

    local procedure TypeToTableID(Type: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"): Integer
    begin
        case Type of
            Type::"G/L Account":
                exit(DATABASE::"G/L Account");
            Type::Customer:
                exit(DATABASE::Customer);
            Type::Vendor:
                exit(DATABASE::Vendor);
            Type::"Bank Account":
                exit(DATABASE::"Bank Account");
            Type::"Fixed Asset":
                exit(DATABASE::"Fixed Asset");
        end;
    end;

    local procedure ThrowPmtPostError(ReceivedPaymentLine: Record "Payment Line"; ErrorTemplate: Text; ErrorText: Text)
    begin
        if ReceivedPaymentLine."Line No." <> 0 then
            Error(
              ErrorTemplate, PaymentHeader."No.", ReceivedPaymentLine.TableCaption, ReceivedPaymentLine."Line No.", ErrorText);
        Error(ErrorTemplate, PaymentHeader."No.", ErrorText);
    end;


    procedure TestSourceCode("Code": Code[10])
    var
        SourceCode: Record "Source Code";
    begin
        if not SourceCode.Get(Code) then
            Error(Text017, Code);
    end;


    procedure PaymentAddr(var AddrArray: array[8] of Text[100]; PaymentAddress: Record "Payment Address")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
  AddrArray, PaymentAddress.Name, PaymentAddress."Name 2", PaymentAddress.Contact, PaymentAddress.Address, PaymentAddress."Address 2",
  PaymentAddress.City, PaymentAddress."Post Code", PaymentAddress.County, PaymentAddress."Country/Region Code");
    end;


    procedure PaymentBankAcc(var AddrArray: array[8] of Text[100]; BankAcc: Record "Payment Header")
    var
        FormatAddress: Codeunit "Format Address";
    begin
        FormatAddress.FormatAddr(
  AddrArray, BankAcc."Bank Name", BankAcc."Bank Name 2", BankAcc."Bank Contact", BankAcc."Bank Address", BankAcc."Bank Address 2",
  BankAcc."Bank City", BankAcc."Bank Post Code", BankAcc."Bank County", BankAcc."Bank Country/Region Code");
    end;


    procedure ArchiveDocument(Document: Record "Payment Header")
    var
        ArchiveHeader: Record "Payment Header Archive";
        ArchiveLine: Record "Payment Line Archive";
        PaymentLine: Record "Payment Line";
    begin
        Document.CalcFields("Archiving Authorized");
        if not Document."Archiving Authorized" then
            Error(Text022, Document."No.");
        ArchiveHeader.TransferFields(Document);
        ArchiveHeader.Insert();
        Document.Delete();
        PaymentLine.SetRange("No.", Document."No.");
        if PaymentLine.Find('-') then
            repeat
                ArchiveLine.TransferFields(PaymentLine);
                ArchiveLine.Insert();
                PaymentLine.Delete();
            until PaymentLine.Next() = 0;
    end;


    procedure PickPaymentStep(PaymentHeader: Record "Payment Header"; var PaymentStep: Record "Payment Step"): Boolean
    var
        PaymentSteps: Page "Payment Steps";
    begin
        PaymentStep.FilterGroup(2);
        // Filter on "Action Type" is passed with PaymentStep
        PaymentStep.SetRange("Payment Class", PaymentHeader."Payment Class");
        PaymentStep.SetRange("Previous Status", PaymentHeader."Status No.");
        PaymentStep.FilterGroup(0);
        if PaymentStep.IsEmpty then
            exit(false);

        if PaymentStep.Count = 1 then begin
            PaymentStep.FindFirst();
            exit(Confirm(PaymentStep.Name, true));
        end;

        PaymentStep.FindSet();
        PaymentSteps.LookupMode(true);
        PaymentSteps.SetTableView(PaymentStep);
        PaymentSteps.SetRecord(PaymentStep);
        PaymentSteps.Editable(false);
        if PaymentSteps.RunModal() = ACTION::LookupOK then begin

            PaymentSteps.GetRecord(PaymentStep);

            exit(true);
        end;
        exit(false);
    end;


    procedure ProcessPaymentSteps(PaymentHeader: Record "Payment Header"; var PaymentStep: Record "Payment Step")
    begin
        PaymentHeader.STTestNbOfLines();
        if PickPaymentStep(PaymentHeader, PaymentStep) then
            ProcessPaymentStep(PaymentHeader."No.", PaymentStep);
    end;

    local procedure RunXmlPortExport(XMLPortID: Integer; var PaymentHeader: Record "Payment Header")
    begin
        PaymentClass.Get(PaymentHeader."Payment Class");
        case PaymentClass."SEPA Transfer Type" of
            PaymentClass."SEPA Transfer Type"::"Credit Transfer":
                ExportSEPACreditTransfer(XMLPortID, PaymentHeader);
            PaymentClass."SEPA Transfer Type"::"Direct Debit":
                ExportSEPADirectDebit(PaymentHeader);
            else
                XMLPORT.Run(XMLPortID, false, false, PaymentHeader);
        end;
    end;

    local procedure ExportSEPACreditTransfer(XMLPortId: Integer; var PaymentHeader: Record "Payment Header")
    var
        GenJnlLine: Record "Gen. Journal Line";
        SEPACTExportFile: Codeunit "SEPA CT-Export File";
    begin
        GenJnlLine.SetRange("Journal Template Name", '');
        GenJnlLine.SetRange("Journal Batch Name", '');
        GenJnlLine.SetRange("Document No.", PaymentHeader."No.");
        OnExportSEPACreditTransferOnAfterGenJnlLineSetFilters(GenJnlLine, XMLPortId, PaymentHeader);
        if SEPACTExportFile.Export(GenJnlLine, XMLPortId) then begin
            PaymentHeader."File Export Completed" := true;
            PaymentHeader.Modify();
        end;
    end;

    local procedure ExportSEPADirectDebit(var PaymentHeader: Record "Payment Header")
    var
        DirectDebitCollection: Record "Direct Debit Collection";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
        LastError: Text;
    begin
        PaymentHeader.TestField("Account Type", PaymentHeader."Account Type"::"Bank Account");
        //HH 21/02/2023 Change |CreateNew-->CreateRecord
        DirectDebitCollection.CreateRecord(PaymentHeader."No.", PaymentHeader."Account No.", PaymentHeader."Partner Type");
        DirectDebitCollection."Source Table ID" := DATABASE::"Payment Header";
        DirectDebitCollection.Modify();
        DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", DirectDebitCollection."No.");
        Commit();
        ClearLastError();
        if CODEUNIT.Run(CODEUNIT::"SEPA DD-Export File", DirectDebitCollectionEntry) then begin
            DeleteDirectDebitCollection(DirectDebitCollection."No.");
            PaymentHeader."File Export Completed" := true;
            PaymentHeader.Modify();
            exit;
        end;

        LastError := GetLastErrorText;
        DeleteDirectDebitCollection(DirectDebitCollection."No.");
        Commit();
        Error(LastError);
    end;

    local procedure DeleteDirectDebitCollection(DirectDebitCollectionNo: Integer)
    var
        DirectDebitCollection: Record "Direct Debit Collection";
    begin
        if DirectDebitCollection.Get(DirectDebitCollectionNo) then
            DirectDebitCollection.Delete(true);
    end;

    local procedure PostInvPostingBuffer(): Integer
    var
        GLEntry: Record "G/L Entry";
        RecBankAccount: Record "Bank Account";
        PaymentSetup: Record "Payment Step";
        GroupeBanque: Record "Bank Account Posting Group";
        "G/Account": Record "G/L Account";
        ErrMsg: Label 'Fond non disponible', Locked = true;
        RecBankAccount2: Record "Bank Account";
    begin
        GenJnlLine.Init();
        OnAfterInitGenJnlLine(GenJnlLine, InvPostingBuffer);
        GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
        GenJnlLine."Document Date" := PaymentHeader."Document Date";
        GenJnlLine.Description := InvPostingBuffer[1].Description;
        GenJnlLine."Reason Code" := Step."Reason Code";
        PaymentClass.Get(PaymentHeader."Payment Class");
        GenJnlLine."Delayed Unrealized VAT" :=
          (PaymentClass."Unrealized VAT Reversal" = PaymentClass."Unrealized VAT Reversal"::Delayed);
        GenJnlLine."Realize VAT" := Step."Realize VAT";
        GenJnlLine."Created from No." := InvPostingBuffer[1]."Created from No.";
        GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
        GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
        GenJnlLine."Account Type" := InvPostingBuffer[1]."Account Type";
        GenJnlLine."Account No." := InvPostingBuffer[1]."Account No.";
        GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
        GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
        GenJnlLine."Currency Factor" := InvPostingBuffer[1]."Currency Factor";
        GenJnlLine.Validate(Amount, InvPostingBuffer[1].Amount);
        GenJnlLine.Validate("Amount (LCY)", InvPostingBuffer[1]."Amount (LCY)");

        GenJnlLine.Correction := InvPostingBuffer[1].Correction;
        GenJnlLine.STOption := InvPostingBuffer[1].STOption;
        if PaymentHeader."Source Code" <> '' then begin
            TestSourceCode(PaymentHeader."Source Code");
            GenJnlLine."Source Code" := PaymentHeader."Source Code";
        end else begin
            Step.TestField("Source Code");
            TestSourceCode(Step."Source Code");
            GenJnlLine."Source Code" := Step."Source Code";
        end;
        //Controles
        IF NOT Step."STCode Journal Ligne" THEN BEGIN
            IF Step."Source Code" <> '' THEN
                GenJnlLine."Source Code" := Step."Source Code"
            ELSE
                GenJnlLine."Source Code" := PaymentHeader."Source Code";
        END
        ELSE BEGIN
            CLEAR(PaymentLine);
            PaymentLine.SETFILTER(PaymentLine."Payment Class", '%1', PaymentHeader."Payment Class");
            PaymentLine.SETFILTER("No.", '%1', PaymentHeader."No.");
            IF PaymentLine.FIND('-') THEN
                IF PaymentLine."Account Type" = PaymentLine."Account Type"::"Bank Account" THEN BEGIN
                    RecBankAccount.GET(PaymentLine."Account No.");
                    GenJnlLine."Source Code" := RecBankAccount."STSource Code";
                END;
        END;
        //Controles

        //<< DELTA 01 RAD 08/12/2014
        PaymentSetup.Reset();
        PaymentSetup.SETRANGE("Payment Class", PaymentHeader."Payment Class");
        PaymentSetup.SETRANGE("STControle Solde Caisse", TRUE);
        PaymentSetup.SETRANGE("Previous Status", PaymentHeader."Status No.");
        //PaymentSetup.SETFILTER(PaymentSetup."Action Type", 'Comptabilisation');
        IF PaymentSetup.FINDFIRST THEN BEGIN
            if RecBankAccount2.GET(InvPostingBuffer[1]."Account No.") then
                if RecBankAccount2."ST Negative Balance Controle" then
                    IF GroupeBanque.GET(RecBankAccount2."Bank Acc. Posting Group") THEN BEGIN
                        IF "G/Account".GET(GroupeBanque."G/L Account No.") THEN BEGIN
                            "G/Account".CALCFIELDS("G/Account".Balance);
                            IF "G/Account".Balance + InvPostingBuffer[1].Amount < 0 THEN
                                Error(ErrMsg);
                        END;
                    END;
        END;
        //>>End DELTA 01
        GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
        if GenJnlLine."Applies-to ID" = '' then begin
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
        end;
        GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
        GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
        GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
        GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
        GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
        GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := InvPostingBuffer[1]."Dimension Set ID";
        GenJnlLine."STOrder No." := InvPostingBuffer[1]."STOrder No.";
        GenJnlLine."Payment Method Code" := InvPostingBuffer[1]."STPayment Method Code";
        GenJnlLine.STCoffre := InvPostingBuffer[1].STCoffre;

        OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck(GenJnlLine, PaymentHeader, InvPostingBuffer);
        OnbeforePostChecklCVendor(GenJnlLine, PaymentHeader, StepLedger);
        GenJnlPostLine.RunWithCheck(GenJnlLine);
        MyProcedure1(); //DELTA MMOK

        GLEntry.SetRange("Document Type", GenJnlLine."Document Type");
        GLEntry.SetRange("Document No.", GenJnlLine."Document No.");
        if GLEntry.FindLast() then
            exit(GLEntry."Entry No.");
        exit(0);
    end;

    local procedure MyProcedure1()
    var
        GLsetup: Record "General Ledger Setup";
        GroupeRetenu: Record "ST Groupe retenue";
        Desc: Text[50];
        RecReasonCode: Record "Reason Code";
        PaymentLine: Record "Payment Line";
        StepLedger: Record "Payment Step Ledger";
    begin
        StepLedger.Get(Step."Payment Class", Step.Line, StepLedger.Sign::Credit);
        PaymentLine.RESET();
        PaymentLine.SETRANGE("No.", PaymentHeader."No.");
        PaymentLine.SETRANGE("Line No.");
        IF PaymentLine.FIND('-') THEN
            REPEAT
                IF (PaymentLine."STMontant Retenue" <> 0) AND
                   (StepLedger."STCompta. Retenue à la source") THEN BEGIN
                    PaymentLine."STMontant Retenue Validé" := PaymentLine."STMontant Retenue";
                    PaymentLine."STMontant Retenue Validé DS" := PaymentLine."STMontant Retenue DS";
                    PaymentLine."STMontant Retenue" := 0;
                    PaymentLine."STMontant Retenue DS" := 0;
                    PaymentLine.MODIFY();
                END;

                IF (PaymentLine."STMontant Retenue Validé" <> 0) AND
                   (StepLedger."STAnnuler Compta Retn. à la Sour") THEN BEGIN
                    PaymentLine."STMontant Retenue" := PaymentLine."STMontant Retenue Validé";
                    PaymentLine."STMontant Retenue DS" := PaymentLine."STMontant Retenue Validé DS";
                    PaymentLine."STMontant Retenue Validé" := 0;
                    PaymentLine."STMontant Retenue Validé DS" := 0;
                    PaymentLine.MODIFY();
                END;

            UNTIL PaymentLine.NEXT() = 0;

        IF (InvPostingBuffer[1]."STCompte Retenue" <> '') AND (InvPostingBuffer[1]."STAmount Retenue" <> 0) THEN BEGIN
            GenJnlLine.INIT();
            GenJnlLine."Posting Date" := PaymentHeader."Posting Date";
            GenJnlLine."Document Date" := PaymentHeader."Document Date";
            GroupeRetenu.RESET();
            Desc := '';
            IF GroupeRetenu.GET(0, PaymentLine."STCode Retenue à la Source") THEN //TODO:
                Desc := FORMAT(GroupeRetenu."STType Retenue")
            ELSE
                IF GroupeRetenu.GET(2, PaymentLine."STCode Retenue à la Source") THEN
                    Desc := FORMAT(GroupeRetenu."STType Retenue")
                ELSE
                    IF GroupeRetenu.GET(3, PaymentLine."STCode Retenue à la Source") THEN
                        Desc := FORMAT(GroupeRetenu."STType Retenue")
                    ELSE
                        IF GroupeRetenu.GET(4, PaymentLine."STCode Retenue à la Source") THEN
                            Desc := FORMAT(GroupeRetenu."STType Retenue");
            GenJnlLine.Description := Desc;
            GenJnlLine."Reason Code" := Step."Reason Code";
            //mby 02/06/2011
            RecReasonCode.RESET();
            RecReasonCode.SETRANGE(Code, GenJnlLine."Reason Code");
            IF RecReasonCode.FIND('-') THEN
                IF GenJnlLine.Description = '' THEN
                    GenJnlLine.Description := RecReasonCode.Description;
            //mby 02/06/2011
            GenJnlLine."Document Type" := InvPostingBuffer[1]."Document Type";
            GenJnlLine."Document No." := InvPostingBuffer[1]."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Account No." := InvPostingBuffer[1]."STCompte Retenue";
            GenJnlLine."System-Created Entry" := InvPostingBuffer[1]."System-Created Entry";
            GenJnlLine."Currency Code" := InvPostingBuffer[1]."Currency Code";
            GenJnlLine."Currency Factor" := InvPostingBuffer[1]."Currency Factor";
            GenJnlLine.VALIDATE(Amount, InvPostingBuffer[1]."STAmount Retenue");
            GenJnlLine.Correction := InvPostingBuffer[1].Correction;

            // // // IF PaymentHeader."Source Code" <> '' THEN BEGIN
            // // //     TestSourceCode(PaymentHeader."Source Code");
            // // //     GenJnlLine."Source Code" := PaymentHeader."Source Code";
            // // // END ELSE BEGIN
            // // //     Step.TESTFIELD("Source Code");
            // // //     TestSourceCode(Step."Source Code");
            // // //     GenJnlLine."Source Code" := Step."Source Code";
            // // // END;
            GenJnlLine."Applies-to Doc. Type" := InvPostingBuffer[1]."Applies-to Doc. Type";
            GenJnlLine."Applies-to Doc. No." := InvPostingBuffer[1]."Applies-to Doc. No.";
            IF GenJnlLine."Applies-to Doc. No." = '' THEN
                GenJnlLine."Applies-to ID" := InvPostingBuffer[1]."Applies-to ID";
            GenJnlLine."Posting Group" := InvPostingBuffer[1]."Posting Group";
            GenJnlLine."Source Type" := InvPostingBuffer[1]."Source Type";
            GenJnlLine."Source No." := InvPostingBuffer[1]."Source No.";
            GenJnlLine."External Document No." := InvPostingBuffer[1]."External Document No.";
            GenJnlLine."Due Date" := InvPostingBuffer[1]."Due Date";
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
            // // // GenJnlLine."Num Véhicule" := InvPostingBuffer."No.Véhicule";//hejer 30/10/2012


            IF (ROUND(GenJnlLine."Amount (LCY)", GLsetup."Amount Rounding Precision") <> 0) THEN  //020113
                GenJnlPostLine.RunWithCheck(GenJnlLine);  //020113
        END;


    end;

    procedure GenererInv()
    var
        GroupeRetenu: Record "ST Groupe retenue";
    begin

        IF (StepLedger."STCompta. Retenue à la source") THEN BEGIN
            CLEAR(GroupeRetenu);
            GroupeRetenu.RESET();
            InvPostingBuffer[1].INIT();
            InvPostingBuffer[1]."System-Created Entry" := TRUE;
            IF GroupeRetenu.GET(0, PaymentLine."STCode Retenue à la Source") THEN;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1].VALIDATE("Account No.", GroupeRetenu."STCompte Retenue");
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";
            InvPostingBuffer[1].Description := StepLedger.Description;
            InvPostingBuffer[1].VALIDATE(Amount, PaymentLine."STMontant Retenue");
            InvPostingBuffer[1]."STCode Retenue à la Source" := PaymentLine."STCode Retenue à la Source";

            InvPostingBuffer[1].VALIDATE("Amount (LCY)", PaymentLine."STMontant Retenue DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            IF InvPostingBuffer[1].Amount <> 0 THEN
                geninv2();

        END;
        IF StepLedger."STAnnuler Compta Retn. à la Sour" THEN BEGIN
            CLEAR(GroupeRetenu);
            GroupeRetenu.RESET();
            InvPostingBuffer[1].INIT();
            InvPostingBuffer[1]."System-Created Entry" := TRUE;
            IF GroupeRetenu.GET(0, PaymentLine."STCode Retenue à la Source") THEN;
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."Currency Code" := PaymentLine."Currency Code";
            InvPostingBuffer[1]."Currency Factor" := PaymentLine."Currency Factor";

            InvPostingBuffer[1].VALIDATE("Account No.", GroupeRetenu."STCompte Retenue");
            InvPostingBuffer[1].VALIDATE(Amount, -PaymentLine."STMontant Retenue Validé");
            InvPostingBuffer[1].VALIDATE("Amount (LCY)", -PaymentLine."STMontant Retenue Validé DS");
            InvPostingBuffer[1]."Applies-to ID" := '';
            IF InvPostingBuffer[1].Amount <> 0 THEN
                geninv2();
        END;
        IF (StepLedger."stInclure Commission") AND (StepLedger."StCompte Int" <> '') AND (PaymentLine."stMontant Interret" <> 0) THEN BEGIN
            InvPostingBuffer[1].INIT();
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := TRUE;
            InvPostingBuffer[1].VALIDATE("Account No.", StepLedger."StCompte Int");
            CLEAR(InvPostingBuffer[1]."Currency Code");
            InvPostingBuffer[1]."Currency Factor" := 1;//PaymentLine."Currency Factor";
            IF StepLedger.Sign = 0 THEN BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, ABS(PaymentLine."stMontant Interret"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", ABS(PaymentLine."stMontant Interret DS"));
            END ELSE BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, -ABS(PaymentLine."stMontant Interret"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", -ABS(PaymentLine."stMontant Interret DS"));
            END;

            InvPostingBuffer[1]."Applies-to ID" := '';

            IF InvPostingBuffer[1].Amount <> 0 THEN
                geninv2();
            InvPostingBuffer[1]."Source Type" := PaymentHeader."Account Type";
            InvPostingBuffer[1]."Source No." := PaymentHeader."Account No.";
            InvPostingBuffer[1].Modify()
        END;
        IF (StepLedger."stInclure Commission") AND (StepLedger."stCompte Commission" <> '') AND (PaymentLine."stMontant Commission" <> 0) THEN BEGIN
            InvPostingBuffer[1].INIT();
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := TRUE;
            InvPostingBuffer[1].VALIDATE("Account No.", StepLedger."stCompte Commission");
            CLEAR(InvPostingBuffer[1]."Currency Code");
            InvPostingBuffer[1]."Currency Factor" := 1;//PaymentLine."Currency Factor";
            IF StepLedger.Sign = 0 THEN BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, ABS(PaymentLine."stMontant Commission"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", ABS(PaymentLine."stMontant Commission DS"));
            END ELSE BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, -ABS(PaymentLine."stMontant Commission"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", -ABS(PaymentLine."stMontant Commission DS"));
            END;

            InvPostingBuffer[1]."Applies-to ID" := '';
            IF InvPostingBuffer[1].Amount <> 0 THEN
                geninv2();
            InvPostingBuffer[1]."Source Type" := PaymentHeader."Account Type";
            InvPostingBuffer[1]."Source No." := PaymentHeader."Account No.";
            InvPostingBuffer[1].Modify();
        END;

        IF (StepLedger."stInclure Commission") AND (StepLedger."stCompte TVA/Commission" <> '') AND (PaymentLine."stMontant TVA Commission" <> 0) THEN BEGIN
            InvPostingBuffer[1].INIT();
            InvPostingBuffer[1]."Account Type" := 0;
            InvPostingBuffer[1]."System-Created Entry" := TRUE;
            InvPostingBuffer[1].VALIDATE("Account No.", StepLedger."stCompte TVA/Commission");
            CLEAR(InvPostingBuffer[1]."Currency Code");
            InvPostingBuffer[1]."Currency Factor" := 1;//PaymentLine."Currency Factor";
            IF StepLedger.Sign = 0 THEN BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, ABS(PaymentLine."stMontant TVA Commission"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", ABS(PaymentLine."stMontant TVA Commission DS"));
            END ELSE BEGIN
                InvPostingBuffer[1].VALIDATE(Amount, -ABS(PaymentLine."stMontant TVA Commission"));
                InvPostingBuffer[1].VALIDATE("Amount (LCY)", -ABS(PaymentLine."stMontant TVA Commission DS"));
            END;

            InvPostingBuffer[1]."Applies-to ID" := '';
            IF InvPostingBuffer[1].Amount <> 0 THEN
                geninv2();
            InvPostingBuffer[1]."Source Type" := PaymentHeader."Account Type";
            InvPostingBuffer[1]."Source No." := PaymentHeader."Account No.";
            InvPostingBuffer[1].Modify();
        END;
    end;

    local procedure geninv2()
    begin
        InvPostingBuffer[1].Correction := PaymentLine.Correction XOR Step.Correction;
        //Retenue à la source détaillée Indépendement du setup
        //>>
        //IF (StepLedger."Detail Level" = StepLedger."Detail Level"::Line) THEN
        //    InvPostingBuffer[1]."Payment Line No." := PaymentLine."Line No."
        //ELSE
        //    IF (StepLedger."Detail Level" = StepLedger."Detail Level"::"Due Date") THEN
        //        InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date";

        InvPostingBuffer[1]."Payment Line No." := PaymentLine."Line No.";
        InvPostingBuffer[1]."Due Date" := PaymentLine."Due Date";
        //<<
        InvPostingBuffer[1]."Document Type" := StepLedger."Document Type";
        IF StepLedger."Document No." = StepLedger."Document No."::"Header No." THEN
            InvPostingBuffer[1]."Document No." := PaymentHeader."No."
        ELSE BEGIN
            IF (InvPostingBuffer[1].Sign = InvPostingBuffer[1].Sign::Positive) AND
               (PaymentLine."Entry No. Debit" = 0) AND (PaymentLine."Entry No. Credit" = 0) THEN BEGIN
                PaymentClass.GET(PaymentHeader."Payment Class");
                IF PaymentClass."Line No. Series" = '' THEN
                    PaymentLine.TESTFIELD("Document No.", NoSeriesMgt.GetNextNo(PaymentHeader."No. Series", PaymentLine."Posting Date", FALSE))


            END;
            InvPostingBuffer[1]."Document No." := PaymentLine."Document No.";
        END;
        InvPostingBuffer[1]."Header Document No." := PaymentHeader."No.";
        IF StepLedger.Sign = StepLedger.Sign::Debit THEN BEGIN
            EntryTypeDebit := InvPostingBuffer[1]."Account Type";
            EntryNoAccountDebit := InvPostingBuffer[1]."Account No.";
            EntryPostGroupDebit := InvPostingBuffer[1]."Posting Group";
        END ELSE BEGIN
            EntryTypeCredit := InvPostingBuffer[1]."Account Type";
            EntryNoAccountCredit := InvPostingBuffer[1]."Account No.";
            EntryPostGroupCredit := InvPostingBuffer[1]."Posting Group";
        END;
        InvPostingBuffer[1]."System-Created Entry" := TRUE;
        Application();
        InvPostingBuffer[1].Description := STRSUBSTNO(StepLedger.Description,
             PaymentLine."Due Date", PaymentLine."Account No.", PaymentLine."Document No.",
             PaymentLine."External Document No.", Vendor.Name, PaymentLine.STCommentaires);
        InvPostingBuffer[1]."Source Type" := PaymentLine."Account Type";
        InvPostingBuffer[1]."Source No." := PaymentLine."Account No.";
        InvPostingBuffer[1]."External Document No." := PaymentLine."External Document No.";
        InvPostingBuffer[1]."Global Dimension 1 Code" := PaymentHeader."Shortcut Dimension 1 Code";
        InvPostingBuffer[1]."Global Dimension 2 Code" := PaymentHeader."Shortcut Dimension 2 Code";
        InvPostingBuffer[1]."Dimension Set ID" := PaymentLine."Dimension Set ID";
        OnAftergeninv2OnBeforeUpdtBuffer(InvPostingBuffer, PaymentLine, StepLedger);
        UpdtBuffer();
    end;

    procedure Actualiserstat(var Rec: Record "Payment Header")
    var
        RecPaymentLine: Record "Payment Line";
        PayStatus: Record "Payment Status";
    begin

        CLEAR(PayStatus);
        IF PayStatus.GET(Rec."Payment Class", Rec."Status No.") AND ((PayStatus."STCalculer retenue a la source")) THEN BEGIN
            CLEAR(RecPaymentLine);
            RecPaymentLine.RESET();
            RecPaymentLine.SETFILTER("Payment Class", Rec."Payment Class");
            RecPaymentLine.SETFILTER("Status No.", '%1', Rec."Status No.");
            RecPaymentLine.SETFILTER("No.", Rec."No.");
            IF RecPaymentLine.FIND('-') THEN BEGIN
                REPEAT
                    RecPaymentLine.CalcRetenu();
                    RecPaymentLine.CalcAmount();
                    RecPaymentLine.MODIFY();
                UNTIL RecPaymentLine.NEXT() = 0;
                COMMIT();
            END;
        END;
    end;

    LOCAL PROCEDURE GetPaymentMethodFromPaymentHeader(pPaymentClass: Text[30]): Code[20]
    VAR
        lPaymentClass: Record "Payment Class";
    BEGIN
        IF PaymentClass.GET(pPaymentClass) THEN BEGIN
            PaymentClass.TESTFIELD(Enable, TRUE);
            EXIT(PaymentClass."STMode Règlement");
        END
        ELSE
            EXIT('');
    END;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterValidateEvent', 'Amount', FALSE, FALSE)]
    local procedure OnAfterValidateEventAmountPayLine(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; CurrFieldNo: Integer)
    var
        PaymentClass: Record "Payment Class";
        banqe: Record "Bank Account";
        error002: Label 'Veuillez choisir une caisse dépense';
    begin
        IF PaymentClass.GET(Rec."Payment Class") THEN
            IF (PaymentClass."STCompte ligne" = PaymentClass."STCompte ligne"::"Caisse dépense") AND (Rec."Account Type" = Rec."Account Type"::"Bank Account") THEN
                IF banqe.GET(Rec."Account No.") THEN
                    IF banqe.STCaisse <> banqe.STCaisse::Dépense THEN
                        ERROR(Error002);

        IF (Rec."STMontant Retenue" = 0) AND (Rec."STMontant Retenue Validé" = 0) AND (rec."STMontant Commission" = 0) AND (REC."stMontant TVA Commission" = 0) THEN BEGIN
            Rec."STMontant Initial" := Rec.Amount;
            Rec."STMontant Initial DS" := Rec."Amount (LCY)";
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventPaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    var
        Process: Record "Payment Class";
        usersetup: Record "User Setup";
        SingleInstancesFunctions: Codeunit STSingleInstance;

    begin
        SingleInstancesFunctions.SetSourceNoSerieByCoffre('');
        //<< DELTA 01 
        Rec.VALIDATE("Account Type", Process."STHeader Account Type");
        Rec."STType Règlement" := FORMAT(Process.STType_Reg);
        // //<<DELTA 01
        Rec.STInitHeader2();
        // //<< DELTA 01 
        Rec."STDate Création" := CURRENTDATETIME;
        Rec."STCréer par" := USERID;
        Process.Get(Rec."Payment Class");
        REC.STType_Reg := Process.STType_Reg;
        IF Process."STCaisse par défaut" = Process."STCaisse par défaut"::"Dépense" THEN BEGIN
            usersetup.GET(USERID);
            IF Rec."Account Type" = Rec."Account Type"::"Bank Account" THEN
                Rec.VALIDATE("Account No.", usersetup."STcaisse-Depense-par defaut");
        END;
        IF Process."STCaisse par défaut" = Process."STCaisse par défaut"::Recette THEN BEGIN
            usersetup.GET(USERID);
            IF Rec."Account Type" = Rec."Account Type"::"Bank Account" THEN
                Rec.VALIDATE("Account No.", usersetup."STcaisse-Recette-par defaut");
        END;
        OnafterSTInitHeader(rec);
        Rec.Modify();
        //>> End DELTA 01
        //>>Hatem 02/09/2021
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Slip Subform", 'OnNewRecordEvent', '', false, false)]
    local procedure OnNewRecordEventPaymentSlipSubform(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; BelowxRec: Boolean)
    var
        PaymentClass: Record "Payment Class";
        PaymentStatus: Record "Payment Status";
        Statement: Record "Payment Header";
        Paramcpta: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit "No. Series";
        PaymentHeader: Record "Payment Header";
    begin
        if PaymentHeader.Get(Rec."No.") then begin
            Statement.GET(Rec."No.");
            // PaymentLine."Document No." := NoSeriesMgt.GetNextNo(PaymentClass."Line No. Series", PaymentLine."Posting Date", FALSE);
            PaymentClass.GET(Statement."Payment Class");
            CASE PaymentClass.STSuggestions OF
                PaymentClass.STSuggestions::Customer:
                    Rec."Account Type" := Rec."Account Type"::Customer;
                PaymentClass.STSuggestions::Vendor:
                    Rec."Account Type" := Rec."Account Type"::Vendor;
                PaymentClass.STSuggestions::Bank:
                    Rec."Account Type" := Rec."Account Type"::"Bank Account";
            END;

            PaymentStatus.GET(Statement."Payment Class", Rec."Status No.");
            Paramcpta.GET();
            Rec."Payment in Progress" := PaymentStatus."Payment in Progress";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterValidateEvent', 'External Document No.', false, false)]
    local procedure OnAfterValidateEventExternalDocNo(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; CurrFieldNo: Integer)
    var
        paymentheader: Record "Payment Header";
        PaymentClass: Record "Payment Class";
        CompanyInformation: Record "Company Information";
        error002: Label 'Veuillez vérifier le n° du chèque : %1 caractères obligatoires';
        error001: Label 'Veuillez vérifier le n° du Traite : %1 caractères obligatoires';
    begin
        paymentheader.Reset();
        CompanyInformation.Get();
        paymentheader.SETRANGE("No.", Rec."No.");
        //paymentheader.SETRANGE(paymentheader."Payment Class", Rec."Payment Class"); 
        IF paymentheader.FINDFIRST() THEN BEGIN
            CLEAR(PaymentClass);
            PaymentClass.SETRANGE(Code, paymentheader."Payment Class");
            IF PaymentClass.FINDFIRST() THEN BEGIN
                IF PaymentClass.STType_Reg = 2 THEN BEGIN
                    CompanyInformation.TestField("STNombre traite");
                    IF STRLEN(Rec."External Document No.") <> CompanyInformation."STNombre traite" THEN
                        ERROR(Error001, CompanyInformation."STNombre traite");
                END;

                IF PaymentClass.STType_Reg = 1 THEN BEGIN
                    CompanyInformation.TestField("STNombre cheque");
                    IF STRLEN(Rec."External Document No.") <> CompanyInformation."STNombre cheque" THEN
                        ERROR(error002, CompanyInformation."STNombre cheque");

                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterValidateEvent', 'Amount', false, false)]
    local procedure OnAfterValidateEventAmount(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; CurrFieldNo: Integer)
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Paramcpta: Record "General Ledger Setup";
        Vend: Record Vendor;
    begin
        IF (Rec."STMontant Retenue" = 0) AND (Rec."STMontant Retenue Validé" = 0)
       THEN BEGIN
            Rec."STMontant Initial" := Rec.Amount;
            Rec."STAssiette RS" := Rec."STMontant Initial";
            Rec."STMontant Initial DS" := Rec."Amount (LCY)";
        END;

        IF Rec.Amount <> 0 THEN
            IF Rec."STCode Retenue à la Source" <> '' THEN
                Rec.VALIDATE("STCode Retenue à la Source", Rec."STCode Retenue à la Source")
            ELSE BEGIN
                Paramcpta.GET();
                IF Rec."Account Type" = Rec."Account Type"::Vendor THEN BEGIN
                    CLEAR(Vend);
                    Vend.GET(Rec."Account No.");
                    IF Vend."STExonoré de la R.S" = FALSE THEN;
                    //IF Amount > Paramcpta."Mnt Max. pour Ret. par Defaut"  THEN
                    // IF Vend."STCode Retenue a la Source" = '' THEN BEGIN
                    //     Paramcpta.TESTFIELD("STRetenu par def.");
                    //     VALIDATE("STCode Retenue à la Source", Paramcpta."STRetenu par def.");
                    // END;
                END;
            END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure OnAfterValidateEventccountNoPaymentLine(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; CurrFieldNo: Integer)
    var
        ltext001: Label 'Fournisseur Bloqué';
        Vendor: Record Vendor;
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        BankAccount: Record "Bank Account";
        PaymentClass: Record "Payment Class";
        banqe: Record "Bank Account";
        error002: Label 'Veuillez choisir une caisse dépense';
    begin
        Vendor.RESET();
        Customer.RESET();
        GLAccount.RESET();
        BankAccount.RESET();
        Rec."STLibellé" := '';
        IF Rec."Account No." <> '' THEN
            CASE Rec."Account Type" OF
                Rec."Account Type"::Vendor:

                    IF Vendor.GET(Rec."Account No.") THEN BEGIN
                        IF Vendor.Blocked = 1 THEN
                            ERROR(Ltext001);

                        Rec."Posting Group" := Vendor."Vendor Posting Group";//add rh 01/05/2014
                        Rec."STLibellé" := Vendor.Name;
                        Rec."STDrawee Reference1" := Vendor.Name;
                        //   VALIDATE("STCode Retenue à la Source", Vendor."STCode Retenue a la Source");
                        Rec."STCode_Mode_Règlement" := FORMAT(Vendor."Payment Method Code");
                    END;
                Rec."Account Type"::"G/L Account":

                    IF GLAccount.GET(Rec."Account No.") THEN BEGIN
                        Rec."STLibellé" := GLAccount.Name;
                        Rec."STDrawee Reference1" := GLAccount.Name;
                    END;

                Rec."Account Type"::Customer:

                    IF Customer.GET(Rec."Account No.") THEN BEGIN
                        //<< DELTA 01 RAD 05/12/2014
                        Rec."Posting Group" := Customer."Customer Posting Group";
                        Rec."STLibellé" := Customer.Name;
                        Rec."STDrawee Reference1" := Customer.Name;

                    END;
                Rec."Account Type"::"Bank Account":

                    IF BankAccount.GET(Rec."Account No.") THEN begin
                        Rec."STLibellé" := BankAccount.Name;
                        Rec."STDrawee Reference1" := BankAccount.Name;
                    END;

            END;
        IF Rec."Account Type" = Rec."Account Type"::Vendor THEN BEGIN
            Vendor.RESET();
            Vendor.SETRANGE("No.", Rec."Account No.");
            IF Vendor.FINDFIRST() THEN BEGIN
                Rec."STLibellé" := Vendor.Name;
                Rec."STDrawee Reference1" := Vendor.Name;
            END;
        END;
        IF Rec."Account Type" = Rec."Account Type"::Customer THEN BEGIN
            Customer.RESET();
            Customer.SETRANGE("No.", Rec."Account No.");
            IF Customer.FINDFIRST() THEN BEGIN
                Rec."STLibellé" := Customer.Name;
                Rec."STDrawee Reference1" := Customer.Name;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Header", 'OnAfterValidateEvent', 'Source Code', false, false)]
    local procedure OnAfterValidateEventSourceCode(var Rec: Record "Payment Header"; var xRec: Record "Payment Header"; CurrFieldNo: Integer)
    var
        PayStat: Record "Payment Status";
    begin
        IF Rec."Source Code" <> '' THEN
            IF Rec."Source Code" <> xRec."Source Code" THEN BEGIN
                CLEAR(PayStat);
                PayStat.GET(Rec."Payment Class", Rec."Status No.");
                PayStat.TESTFIELD("STAutoriser Modifcation Entête");
            END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Header", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure OnAfterValidateEventAccountNoPaymentHeader(var Rec: Record "Payment Header"; var xRec: Record "Payment Header"; CurrFieldNo: Integer)
    var
        usersetup: Record "User Setup";
        PaymentClass: Record "Payment Class";
        PaymentStatus: Record "Payment Status";
        PayStat: Record "Payment Status";
        CompanyBank: Record "Bank Account";
        PayLine: Record "Payment Line";

    begin

        IF Rec."Account No." <> '' THEN
            IF Rec."Account No." <> xRec."Account No." THEN BEGIN
                CLEAR(PayStat);
                PayStat.GET(Rec."Payment Class", Rec."Status No.");
            END;
        //<< end DELTA 01

        //<< DELTA 01 RAD 05/12/2014
        CLEAR(PaymentStatus);
        IF PaymentStatus.GET(Rec."Payment Class", Rec."Status No.") THEN;

        IF (Rec."Account Type" = Rec."Account Type"::"Bank Account") AND (Rec."Account No." <> '') THEN BEGIN
            CompanyBank.RESET();
            CompanyBank.GET(Rec."Account No.");
            Rec."Source Code" := CompanyBank."STSource Code";
            PayLine.RESET();
            PayLine.SETRANGE("No.", Rec."No.");
            IF PayLine.FINDSET() THEN
                PayLine.MODIFYALL(PayLine."STRib_Entête", Rec."Bank Account No.");
        END;

        CLEAR(PayStat);
        PayStat.GET(Rec."Payment Class", Rec."Status No.");

        IF xRec."Account No." <> '' THEN
            IF NOT PayStat."STAutoriser Modifcation Entête" THEN
                IF Rec."Account No." <> xRec."Account No." THEN
                    ERROR('Impossible de modifer la banque entête Bordereau');

        IF Rec."Account Type" = Rec."Account Type"::"Bank Account" THEN BEGIN
            usersetup.GET(USERID);
            PaymentClass.GET(Rec."Payment Class");
            IF (Rec."Account No." <> '') AND (PaymentClass."STCaisse par défaut" <> PaymentClass."STCaisse par défaut"::" ") THEN BEGIN
                IF PaymentClass."STCaisse par défaut" = PaymentClass."STCaisse par défaut"::"Dépense" THEN
                    if not (usersetup."ST modify caisse depense") then
                        IF usersetup."STcaisse-Depense-par defaut" <> '' THEN
                            IF usersetup."STcaisse-Depense-par defaut" <> Rec."Account No." THEN
                                ERROR('Caisse dépense non modifiable!');

                IF (PaymentClass."STCaisse par défaut" = PaymentClass."STCaisse par défaut"::Recette) AND NOT PayStat."STAutoriser Modifcation Entête" THEN
                    IF usersetup."STcaisse-Recette-par defaut" <> '' THEN
                        IF usersetup."STcaisse-Recette-par defaut" <> Rec."Account No." THEN
                            ERROR('Caisse recette non modifiable!');
            END;
        END;
    end;

    //dh170921
    [EventSubscriber(ObjectType::Table, Database::"Detailed Vendor Ledg. Entry", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertDetailedVendorLedgEntry(var Rec: Record "Detailed Vendor Ledg. Entry"; RunTrigger: Boolean)
    var
        recVendor: Record Vendor;
        VendorLedgerentry: Record "Vendor Ledger Entry";
    begin
        // recVendor.GET(rec."Vendor No.");
        // rec."STVendor Posting Group" := recVendor."Vendor Posting Group";
        IF VendorLedgerentry.get(rec."Vendor Ledger Entry No.") then
            rec."STVendor Posting Group" := VendorLedgerentry."Vendor Posting Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Detailed Cust. Ledg. Entry", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertDetailedCustLedgEntry(var Rec: Record "Detailed Cust. Ledg. Entry")
    var
        recCust: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        //recCust.GET(rec."Customer No.");
        //rec."STCustomer Posting Group" := recCust."Customer Posting Group";

        IF CustLedgerEntry.get(rec."Cust. Ledger Entry No.") then
            rec."STCustomer Posting Group" := CustLedgerEntry."Customer Posting Group";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventPaymentLine(var Rec: Record "Payment Line"; RunTrigger: Boolean)
    var
        RecpaymentStatus: Record "Payment Status";
    //     Statement: Record "Payment Header";
    begin
        RecpaymentStatus.get(Rec."Payment Class", Rec."Status No.");
        rec.STCodeSituationPaiement := RecpaymentStatus.STCodeSituationPaiement;
        rec.Modify()
        //     Statement.GET(Rec."No.");
        //     Rec.STCoffre := Statement.STCoffre;
        //     IF Rec."STCoffre Origine" = '' THEN
        //         Rec."STCoffre Origine" := Statement.STCoffre;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Payment Header", 'OnBeforeInsertEvent', '', false, false)]
    // local procedure OnBeforeInsertEventPaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    // begin

    // end;
    // [EventSubscriber(ObjectType::Page, Page::"Payment Lines List", 'OnClosePageEvent', '', false, false)]
    // local procedure OnQueryClosePageEventPaymentLinesList(var Rec: Record "Payment Line")
    // var
    //     SingleInstance: Codeunit STSingleInstance;
    // begin
    //     SingleInstance.SetSPaymentHeaderNo(Rec."No.");
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment Management", 'OnCopyLigBorOnBeforeInitHeader', '', false, false)]
    local procedure OnCopyLigBorOnBeforeInitHeader(var ToBord: Record "Payment Header"; var Process: Record "Payment Class"; var i: Integer)
    var
        payheader: Record "Payment Header";
        SingleInstance: Codeunit STSingleInstance;
        PaymentHeaderNo: Code[20];
    begin
        // // // payheader.RESET;
        // // // // SingleInstance.GetPaymentHeaderNo(PaymentHeaderNo);
        // // // payheader.GET(PaymentHeaderNo);
        // // // BEGIN
        // // //     ToBord.VALIDATE("Account No.", payheader."Account No.");
        // // //     ToBord."STType Règlement" := payheader."STType Règlement";
        // // //     ToBord.MODIFY;
        // // // END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment Management", 'OnCopyLigBorOnBeforeToPaymentLineInsert', '', false, false)]
    local procedure OnCopyLigBorOnBeforeToPaymentLineInsert(var ToPaymentLine: Record "Payment Line"; var Process: Record "Payment Class")
    var
        payheader: Record "Payment Header";

    begin

        // ToPaymentLine."STMontant Retenue" := FromPaymentLine."Montant Retenue";
        // ToPaymentLine."STMontant Retenue Validé" := FromPaymentLine."Montant Retenue Validé";
        // ToPaymentLine."STMontant Retenue DS" := FromPaymentLine."Montant Retenue DS";
        // ToPaymentLine."STMontant Retenue Validé DS" := FromPaymentLine."Montant Retenue Validé DS";
        // ToPaymentLine."STCoffre Origine" := FromPaymentLine."Coffre Origine";
        // ToPaymentLine."STType Règlement" := ToBord."Type Règlement";
        // ToPaymentLine."Status No." := ToBord."Status No.";
        // ToPaymentLine.MODIFY;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"No. Series", 'OnSetNoSeriesLineFilters', '', false, false)]
    local procedure OnNoSeriesOnSetNoSeriesLineFilters(var NoSeriesLine: Record "No. Series Line")
    var
        SingleInstance: Codeunit STSingleInstance;
        CoffreCode: Code[20];
        GeneralLedgerSetup: record "General Ledger Setup";
    begin
        // YB 260523 TEST 
        GeneralLedgerSetup.get();
        if Not GeneralLedgerSetup."ST Enable seriesNo Coffre" then begin
            SingleInstance.GetSourceNoSerieByCoffre(CoffreCode);
            IF CoffreCode <> '' THEN
                NoSeriesLine.SETRANGE(STCoffre, CoffreCode);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertEventPaymentHeader(var Rec: Record "Payment Header"; RunTrigger: Boolean)
    var
        SingleInstancesFunctions: Codeunit STSingleInstance;
        UserSetup: Record "User Setup";

    begin
        UserSetup.Get(UserId);
        SingleInstancesFunctions.SetSourceNoSerieByCoffre(UserSetup.STCoffre);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Line", 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyEventPaymentLine(var Rec: Record "Payment Line"; var xRec: Record "Payment Line"; RunTrigger: Boolean)
    var
        UserSetup: Record "User Setup";
        PaymentStatus: Record "Payment Status";

        Error001: Label 'Vous ne pouvez pas modifier cette ligne de paiement ';

    begin
        if RunTrigger = false then
            exit;



        UserSetup.get(UserId);


        if PaymentStatus.Get(Rec."Payment Class", Rec."Status No.") then
            if (PaymentStatus.STModifiable = false) and (Rec.Posted = false) then
                Error(Error001);

    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Class List", 'OnOpenPageEvent', '', FALSE, FALSE)]
    local procedure OnOpenPageEvent(var Rec: Record "Payment Class")
    var
        AutorisationStepPayment2: record "STAutorisationStepPayment";
        AutorisationStepPayment: record "STAutorisationStepPayment";
        PaymentClass: Record "Payment Class";
    begin

        AutorisationStepPayment2.SETRANGE(User, UPPERCASE(USERID));
        IF AutorisationStepPayment2.ISEMPTY THEN EXIT;
        IF PaymentClass.FINDFIRST() THEN
            REPEAT
                IF AutorisationStepPayment.GET(UPPERCASE(USERID), PaymentClass.Code) THEN
                    PaymentClass.MARK(TRUE);
            UNTIL PaymentClass.NEXT() = 0;
        PaymentClass.MARKEDONLY(TRUE);
        Rec.COPY(PaymentClass);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Payment-Apply", 'OnAfterApply', '', false, false)]
    local procedure OnAfterApplyPaymentApply(GenJnlLine: Record "Gen. Journal Line")
    var
        PaymentLine: Record "Payment Line";
        AppliesToInvNos: Code[1024];
        PayHeaderNo: Code[20];
        PayLineNo: Code[20];
        Pos: Integer;
        LenghtStr: Integer;
        SingleInstance: Codeunit STSingleInstance;
    begin
        AppliesToInvNos := FillInAppliesToInvoiceNos(GenJnlLine);
        SingleInstance.SetAppliesToInvNos(AppliesToInvNos);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"STPayment-Apply", 'OnAfterApply', '', false, false)]
    local procedure OnSTAfterApplyPaymentApply(GenJnlLine: Record "Gen. Journal Line")
    var
        PaymentLine: Record "Payment Line";
        AppliesToInvNos: Code[1024];
        PayHeaderNo: Code[20];
        PayLineNo: Code[20];
        Pos: Integer;
        LenghtStr: Integer;
        SingleInstance: Codeunit STSingleInstance;
    begin
        AppliesToInvNos := FillInAppliesToInvoiceNos(GenJnlLine);
        SingleInstance.SetAppliesToInvNos(AppliesToInvNos);
    end;

    local procedure FillInAppliesToInvoiceNos(GenJnlLine: Record "Gen. Journal Line"): Code[1024]
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PaymentLine: Record "Payment Line";
        Bool: Boolean;
        AppliesToInvNos: Code[1024];
    begin
        Bool := false;
        AppliesToInvNos := '';
        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then begin
            VendLedgEntry.Reset();
            VendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
            VendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
            VendLedgEntry.SetRange(Open, true);
            VendLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
            if VendLedgEntry.FindSet() then
                repeat
                    if Bool then
                        AppliesToInvNos := AppliesToInvNos + '/';
                    AppliesToInvNos += VendLedgEntry."External Document No.";
                    Bool := true;
                until VendLedgEntry.Next() = 0;
        end else
            if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then begin
                CustLedgEntry.Reset();
                CustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                CustLedgEntry.SetRange("Customer No.", GenJnlLine."Account No.");
                CustLedgEntry.SetRange(Open, true);
                CustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");
                if CustLedgEntry.FindSet() then
                    repeat
                        if Bool then
                            AppliesToInvNos := AppliesToInvNos + '/';
                        AppliesToInvNos += CustLedgEntry."Document No.";
                        Bool := true;
                    until CustLedgEntry.Next() = 0;
            end;
        exit(AppliesToInvNos);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Slip Subform", 'OnAfterActionEvent', 'Application', false, false)]
    local procedure OnAfterActionEventApplication(var Rec: Record "Payment Line")
    var
        SingleInstance: Codeunit STSingleInstance;
        AppliesToInvNos: Code[1024];
    begin
        if SingleInstance.GetAppliesToInvNos(AppliesToInvNos) then begin
            Rec."Applies-to Invoices Nos." := AppliesToInvNos;
            SingleInstance.SetAppliesToInvNos('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Slip Subform", 'OnAfterActionEvent', 'Application2', false, false)]
    local procedure OnAfterActionEventApplication2(var Rec: Record "Payment Line")
    var
        SingleInstance: Codeunit STSingleInstance;
        AppliesToInvNos: Code[1024];
    begin
        if SingleInstance.GetAppliesToInvNos(AppliesToInvNos) then begin
            Rec."Applies-to Invoices Nos." := AppliesToInvNos;
            SingleInstance.SetAppliesToInvNos('');
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCustomer(var Rec: Record Customer)
    var
        LrecRisqueClientFrs: Record STRisqueClientFRs;

    begin
        IF REC.IsTemporary THEN EXIT;
        LrecRisqueClientFrs.Init();
        LrecRisqueClientFrs.Type := LrecRisqueClientFrs.type::Customer;
        LrecRisqueClientFrs.Code := rec."No.";
        if not veriflimitedlicense(LrecRisqueClientFrs) then
            LrecRisqueClientFrs.Insert()
    end;

    [EventSubscriber(ObjectType::Table, database::Customer, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteCustomer(var Rec: Record Customer)
    var
        LrecRisqueClientFrs: Record STRisqueClientFRs;
    begin
        IF REC.IsTemporary THEN EXIT;
        if LrecRisqueClientFrs.get(LrecRisqueClientFrs.type::Customer, rec."No.") then
            if not veriflimitedlicense(LrecRisqueClientFrs) then
                LrecRisqueClientFrs.Delete();
    end;

    [EventSubscriber(ObjectType::Table, database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVendor(var Rec: Record Vendor)
    var
        LrecRisqueClientFrs: Record STRisqueClientFRs;
    begin
        IF REC.IsTemporary THEN EXIT;
        LrecRisqueClientFrs.Init();
        LrecRisqueClientFrs.Type := LrecRisqueClientFrs.type::Vendor;
        LrecRisqueClientFrs.Code := rec."No.";
        if not veriflimitedlicense(LrecRisqueClientFrs) then
            LrecRisqueClientFrs.Insert()
    end;

    [EventSubscriber(ObjectType::Table, database::Vendor, 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteVendor(var Rec: Record Vendor)
    var
        LrecRisqueClientFrs: Record STRisqueClientFRs;
    begin
        IF REC.IsTemporary THEN EXIT;
        if LrecRisqueClientFrs.get(LrecRisqueClientFrs.type::Vendor, rec."No.") then
            if not veriflimitedlicense(LrecRisqueClientFrs) then
                LrecRisqueClientFrs.Delete();
    end;

    procedure veriflimitedlicense(PrecRisqueClientFrs: Record STRisqueClientFRs): Boolean
    var
        ActiveSession: Record "Active Session";
        user: Record User;
        SessionID: Integer;
    begin
        if not User.Get(UserSecurityId()) then
            exit(false);
        if not (User."License Type" = User."License Type"::"Limited User") then
            exit(false);
        StartSession(SessionID, Codeunit::"ST DateFilter-Calc Delta", CompanyName, PrecRisqueClientFrs);
        while ActiveSession.Get(ServiceInstanceId(), SessionID) do
            Sleep(100);
        StopSession(SessionID);
        exit(true);

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterManualReleasePurchaseDoc', '', false, false)]
    // local procedure OnAfterManualReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    // var
    //     CduPurchasePost: Codeunit "ST Sales&PurchSubscribers";
    // begin
    //     CduPurchasePost.CalcFodec(PurchaseHeader);
    // end;



    [EventSubscriber(ObjectType::Table, database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    var
    begin
        GLEntry.STCoffre := GenJournalLine.STCoffre;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnBeforePostInvtPostBuf', '', false, false)]
    local procedure OnBeforePostInvtPostBuf(var GenJournalLine: Record "Gen. Journal Line"; var InvtPostingBuffer: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if ValueEntry.Adjustment then
            GenJournalLine."ST adjt cost" := true;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnafterSTInitHeader(var PaymentHeader: Record "Payment Header")
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeCheckAccountNo', '', false, false)]
    local procedure OnBeforeCheckAccountNoDueDate(var GenJnlLine: Record "Gen. Journal Line")
    var
        GLAccount: record "G/L Account";
        Erreur001: label 'Date d''échéance ne doit pas être vide pour le compte générale %1';
        Erreur002: label 'Date d''échéance ne doit pas être vide pour le compte générale contrepartie %1';
    begin


        if (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account") and (GenJnlLine."Account No." <> '') then begin
            GLAccount.Init();
            GLAccount.Get(GenJnlLine."Account No.");
            if not GLAccount."Due Date Mandatory Gen Journal" then
                exit;
            if GenJnlLine."Due Date" = 0D then
                Error(Erreur001, GenJnlLine."Account No.");
        end;

        if (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account") and (GenJnlLine."Bal. Account No." <> '') then begin
            GLAccount.Init();
            GLAccount.Get(GenJnlLine."Bal. Account No.");
            if not GLAccount."Due Date Mandatory Gen Journal" then
                exit;
            if GenJnlLine."Due Date" = 0D then
                Error(Erreur002, GenJnlLine."Bal. Account No.");
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    begin
    end;

    // //#region NewCustomPublishers
    // [IntegrationEvent(false, false)]
    // local procedure OnBeforeUpdtBuffer(var InvPostingBuffer: Record "Payment Post. Buffer"; PaymentLine: Record "Payment Line")
    // begin
    // end;


    // [IntegrationEvent(false, false)]
    // local procedure OnAfterPostInvPostingBuffer(var GenJnlLine: Record "Gen. Journal Line"; InvPostingBuffer: Record "Payment Post. Buffer")
    // begin
    // end;
    // //#endregion NewCustomPublishers

    [IntegrationEvent(false, false)]
    local procedure OnGenerEntriesOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; PaymentHeader: Record "Payment Header"; StepLedger: Record "Payment Step Ledger")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnExportSEPACreditTransferOnAfterGenJnlLineSetFilters(var GenJnlLine: Record "Gen. Journal Line"; var XMLPortId: Integer; var PaymentHeader: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGenerInvPostingBufferOnBeforeUpdtBuffer(var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnGenerInvPostingBufferOnBeforeUpdtBuffer2(var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger"; var PaymentHeader: Record "Payment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostInvPostingBufferOnBeforeGenJnlPostLineRunWithCheck(var GenJnlLine: Record "Gen. Journal Line"; PaymentHeader: Record "Payment Header"; var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary)
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitGenJnlLine(var GenJnlLine: Record "Gen. Journal Line"; var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnProcessPaymentStepOnCaseElse(var Step: Record "Payment Step"; var PaymentLine: Record "Payment Line"; var ActionValidated: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnaftersetaccountNo(PaymentHeader: Record "Payment Header"; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger"; var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnbeforePostChecklCVendor(var GenJnlLine: Record "Gen. Journal Line"; PaymentHeader: Record "Payment Header"; StepLedger: Record "Payment Step Ledger")
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnafterCheckProcessPaymentStep(PaymentHeaderNo: Code[20]; PaymentStep: Record "Payment Step")
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure onbeforemodifyledgerpayline(var PaymentLine: Record "Payment Line"; PaymentStep: Record "Payment Step")
    begin

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAftergeninv2OnBeforeUpdtBuffer(var InvPostingBuffer: array[2] of Record "Payment Post. Buffer" temporary; PaymentLine: Record "Payment Line"; StepLedger: Record "Payment Step Ledger")
    begin
    end;

}


