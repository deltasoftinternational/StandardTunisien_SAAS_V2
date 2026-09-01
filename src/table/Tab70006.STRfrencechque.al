table 71006 "ST Référence chèque"
{


    fields
    {
        field(1; "ST Line No"; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "ST Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
            NotBlank = true;
            TableRelation = "Bank Account"."No.";
        }
        field(3; "ST Réference chéque"; Code[20])
        {
            Caption = 'Réference chéque';
            NotBlank = true;

            trigger OnValidate()
            begin
                IF "ST Last No. Used" <> '' THEN
                    ERROR(Text02);
                IF (xRec."ST Réference chéque" <> Rec."ST Réference chéque") THEN
                    Checks.RESET();
                Checks.SETRANGE("ST Banque Code", xRec."ST Bank Code");
                Checks.SETRANGE("ST Réference chéque", xRec."ST Réference chéque");
                Checks.DELETEALL();
                Rec."ST Check Generated" := FALSE;
            end;
        }
        field(4; "ST Starting No."; Code[35])
        {
            Caption = 'Starting No.';
            NotBlank = true;
            trigger OnValidate()
            var
                lPaymentLine: Record "Payment Line";
                lCompanyInformation: Record "Company Information";
                Err002: Label 'The number of characters entered exceeds %1 Character';
            begin
                IF (Rec."ST Starting No." <> xRec."ST Starting No.") OR (Rec."ST Starting No." <> '') THEN
                    ChecklengthCheck("ST Starting No.");
                IF "ST Last No. Used" <> '' THEN
                    ERROR(Text02);

                IF (xRec."ST Starting No." <> Rec."ST Starting No.") THEN BEGIN
                    Checks.RESET();
                    Checks.SETRANGE("ST Banque Code", xRec."ST Bank Code");
                    Checks.SETRANGE("ST Réference chéque", xRec."ST Réference chéque");
                    Checks.DELETEALL();
                    Rec."ST Check Generated" := FALSE;
                END
            end;
        }
        field(5; "ST Ending No."; Code[35])
        {
            Caption = 'Ending No.';
            NotBlank = true;


            trigger OnValidate()
            begin
                IF (Rec."ST Ending No." <> xRec."ST Ending No.") OR (Rec."ST Starting No." <> '') THEN
                    ChecklengthCheck("ST Ending No.");


                IF "ST Ending No." < "ST Starting No." THEN
                    ERROR(Text01);
                IF "ST Last No. Used" <> '' THEN
                    ERROR(Text02);
                IF (xRec."ST Ending No." <> Rec."ST Ending No.") THEN BEGIN
                    Checks.RESET();
                    Checks.SETRANGE("ST Banque Code", xRec."ST Bank Code");
                    Checks.SETRANGE("ST Réference chéque", xRec."ST Réference chéque");
                    Checks.DELETEALL();
                    Rec."ST Check Generated" := FALSE;
                END
            end;
        }
        field(6; "ST Last No. Used"; Code[20])
        {
            Caption = 'Last No. Used';
            Editable = false;
        }
        field(7; "ST Last Date Used"; Date)
        {
            Caption = 'Last Date Used';
            Editable = false;

        }
        field(8; "ST Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(9; "ST Start date of use"; Date)
        {
            Caption = 'Start date of use';

            trigger OnValidate()
            begin

                IF "ST Check Generated" = FALSE THEN
                    IF "ST End Date of use" <> 0D THEN
                        IF "ST End Date of use" < "ST Start date of use" THEN
                            ERROR(Error05)
            end;
        }
        field(10; "ST End Date of use"; Date)
        {
            Caption = 'End Date of use';

            trigger OnValidate()
            begin

                IF "ST Check Generated" = FALSE THEN
                    IF "ST Start date of use" <> 0D THEN
                        IF "ST End Date of use" < "ST Start date of use" THEN
                            ERROR(Error05)
            end;
        }
        field(11; "ST Comment"; Text[50])
        {
            Caption = 'Comment';
        }
        field(12; "ST Check Generated"; Boolean)
        {
            Caption = 'Generated Check';
            Editable = false;
        }
        field(13; "ST Check Activated"; Boolean)
        {
            Caption = 'Check Activated';
        }
        field(50000; "ST Date Génération"; Date)
        {
            Caption = 'Generation Date';
            Description = 'NKOUKI';
        }
    }

    keys
    {
        key(Key1; "ST Bank Code", "ST Réference chéque")
        {
            Clustered = false;
        }
        key(Key2; "ST Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Checks.RESET();
        Checks.SETRANGE("ST Banque Code", "ST Bank Code");
        Checks.SETRANGE("ST Réference chéque", "ST Réference chéque");
        Checks.SETFILTER("ST Status", '<> %1', Checks."ST Status"::New);
        IF NOT Checks.ISEMPTY THEN
            ERROR(Text02)
        ELSE
            IF "ST Check Generated" = TRUE THEN
                IF CONFIRM(Text03) THEN
                    Checks.DELETEALL();
    end;

    trigger OnInsert()
    var
        lCheckReference: Record "ST Référence chèque";
    begin
        lCheckReference.RESET();
        Nligne_gi := 10000;
        lCheckReference.SETRANGE("ST Bank Code", "ST Bank Code");
        IF lCheckReference.FINDLAST() THEN
            "ST Line No" := lCheckReference."ST Line No" + Nligne_gi
        ELSE
            "ST Line No" := Nligne_gi;
        "ST Creation Date" := WORKDATE();


    end;

    trigger OnRename()
    begin
        IF "ST Last No. Used" <> '' THEN
            ERROR(Text02);

        Checks.RESET();
        Checks.SETRANGE("ST Banque Code", xRec."ST Bank Code");
        Checks.SETRANGE("ST Réference chéque", xRec."ST Réference chéque");
        Checks.DELETEALL();
        //VALIDATE("N° fin","N° début");
    end;

    var
        Nligne_gi: Integer;
        Text01: Label 'Please choose the correct Value';
        Checks: Record "ST chéque";
        i: Integer;
        Text02: Label 'You cannot Delete this record';
        Text03: Label 'the deletion of the check No. will delete also the relted Check.do you wan to delete the check No.?';
        Error05: Label 'La date fin d''utulisation doit étre antérieure à la date de début';
        Text010: Label 'The number %1 cannot be extended to more than 20 characters.';

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        IF StartPos > 1 THEN
            StartNo := COPYSTR(No, 1, StartPos - 1);
        IF EndPos < STRLEN(No) THEN
            EndNo := COPYSTR(No, EndPos + 1);
        NewLength := STRLEN(NewNo);
        OldLength := EndPos - StartPos + 1;
        IF FixedLength > OldLength THEN
            OldLength := FixedLength;
        IF OldLength > NewLength THEN
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        IF STRLEN(StartNo) + STRLEN(ZeroNo) + STRLEN(NewNo) + STRLEN(EndNo) > 20 THEN
            ERROR(Text010, No);
        No := StartNo + ZeroNo + NewNo + EndNo;
    end;

    local procedure GetNoText(No: Code[20]): Code[20]
    var
        StartPos: Integer;
        EndPos: Integer;
    begin
        GetIntegerPos(No, StartPos, EndPos);
        IF StartPos <> 0 THEN
            EXIT(COPYSTR(No, StartPos, EndPos - StartPos + 1));
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        IF No <> '' THEN BEGIN
            i := STRLEN(No);
            REPEAT
                IsDigit := No[i] IN ['0' .. '9'];
                IF IsDigit THEN BEGIN
                    IF EndPos = 0 THEN
                        EndPos := i;
                    StartPos := i;
                END;
                i := i - 1;
            UNTIL (i = 0) OR (StartPos <> 0) AND NOT IsDigit;
        END;
    end;


    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
        lCompanyInformation: Record "Company Information";
    begin
        lCompanyInformation.GET();
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, lCompanyInformation."STNombre cheque", StartPos, EndPos);
    end;

    local procedure ChecklengthCheck(pCheckNo: Code[35])
    var
        lCompanyInformation: Record "Company Information";
        Err002: Label 'The number of characters entered exceeds %1 Character';
    begin
        lCompanyInformation.GET();
        IF lCompanyInformation."STNombre cheque" <> 0 THEN
            IF (STRLEN(pCheckNo) <> lCompanyInformation."STNombre cheque") THEN
                ERROR(Err002, lCompanyInformation."STNombre cheque");
    end;
}

