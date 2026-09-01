page 70006 "ST Référence chèque" //50698
{
    Caption = 'Liste référence chèque';
    PageType = List;
    SourceTable = "ST Référence chèque";
    UsageCategory = Administration;
    ApplicationArea = All;




    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."ST Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Réference chéque"; Rec."ST Réference chéque")
                {
                    ApplicationArea = All;
                }
                field("Starting No."; Rec."ST Starting No.")
                {

                    ApplicationArea = All;
                }
                field("Ending No."; Rec."ST Ending No.")
                {
                    ApplicationArea = All;
                }
                field("Last No. Used"; Rec."ST Last No. Used")
                {
                    ApplicationArea = All;
                }
                field("Last Date Used"; Rec."ST Last Date Used")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."ST Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Start date of use"; Rec."ST Start date of use")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("End Date of use"; Rec."ST End Date of use")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Comment; Rec."ST Comment")
                {
                    ApplicationArea = All;
                }
                field("Check Generated"; Rec."ST Check Generated")
                {
                    ApplicationArea = All;
                }
                field("Check Activated"; Rec."ST Check Activated")
                {
                    ApplicationArea = All;
                }
                field("Date Génération"; Rec."ST Date Génération")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Check No")
            {
                Caption = 'Générer numéro de chèque';
                Image = Invoice;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    "lChèquemouvementé": Record "ST chéque";
                    i: Integer;
                    VarInteger1: Integer;
                    VarInteger2: Integer;
                    test: Boolean;
                    Nextcode: Code[10];
                begin
                    //>>DELTA 01
                    lChèquemouvementé.RESET();
                    lChèquemouvementé.SETRANGE("ST Banque Code", Rec."ST Bank Code");
                    lChèquemouvementé.SETRANGE("ST Réference chéque", Rec."ST Réference chéque");
                    //lChèquemouvementé.SETFILTER("N° Bordereau",'<>','');
                    IF lChèquemouvementé.FINDSET() THEN
                        MESSAGE(Text002);


                    lChèquemouvementé.RESET();
                    lChèquemouvementé.SETRANGE("ST Banque Code", Rec."ST Bank Code");
                    lChèquemouvementé.SETRANGE("ST Réference chéque", Rec."ST Réference chéque");
                    IF (Rec."ST Check Generated" = FALSE) AND (lChèquemouvementé.ISEMPTY) AND (Rec."ST Last No. Used" = '') THEN BEGIN
                        IF EVALUATE(VarInteger1, Rec."ST Starting No.") AND EVALUATE(VarInteger2, Rec."ST Ending No.") THEN
                            FOR i := VarInteger1 TO VarInteger2 DO BEGIN
                                lChèquemouvementé.INIT();
                                lChèquemouvementé."ST Banque Code" := Rec."ST Bank Code";
                                lChèquemouvementé."ST Réference chéque" := Rec."ST Réference chéque";
                                IF lChèquemouvementé."ST Check No" = '' THEN
                                    lChèquemouvementé."ST Check No" := Rec."ST Starting No." ELSE
                                    Rec.IncrementNoText(lChèquemouvementé."ST Check No", 1);
                                lChèquemouvementé."ST Line No" := Rec."ST Line No";
                                lChèquemouvementé."ST Status" := lChèquemouvementé."ST Status"::New;
                                lChèquemouvementé.INSERT();
                            END;

                        MESSAGE(Text003);
                        Rec."ST Check Generated" := TRUE;
                        Rec."ST Date Génération" := TODAY;
                        Rec.MODIFY();
                    END



                    //<<DELTA 01
                end;
            }
            action("Chèquier")
            {
                Caption = 'Checks';
                Image = CheckJournal;
                RunObject = Page "ST chèque";
                RunPageLink = "ST Banque Code" = FIELD("ST Bank Code"),
                              "ST Réference chéque" = FIELD("ST Réference chéque");
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."ST Check Activated" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("ST Check Activated", TRUE);
    end;

    var
        Text001: Label 'The Generated Check No. is already in use!';
        Text002: Label 'Check No. already Generated';
        Text003: Label 'Check No. Generated';
}

