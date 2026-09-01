page 71013 "STRisqueFrs"
{

    Caption = 'Risque Fournisseur';
    PageType = CardPart;
    SourceTable = STRisqueClientFRs;
    Editable = false;
    InsertAllowed = False;
    DeleteAllowed = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field("DLT Vendor G/L Amount"; Rec."DLT Vendor G/L Amount")
            {
                ApplicationArea = all;
            }

            field(FrsChequeEncoursMnt; Rec.FrsChequeEncoursMnt)
            {
                Visible = ChequeEncoursVisible;
                ApplicationArea = All;
            }
            field(FrsTraiteEncoursMnt; Rec.FrsTraiteEncoursMnt)
            {
                Visible = TraiteEncoursVisible;
                ApplicationArea = All;
            }
            field(FrsTraiteRemiseMnt; Rec.FrsTraiteRemiseMnt)
            {
                visible = TraiteRemiseVisible;
                ApplicationArea = All;
            }

        }
    }
    var
        ChequeEncoursVisible: Boolean;
        TraiteEncoursVisible: Boolean;
        TraiteRemiseVisible: Boolean;

        RecRisqueClientSetup: Record STSetupRisqueClientFrs;
        Vend: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";

    trigger OnOpenPage()
    begin
        RecRisqueClientSetup.Get();
        If RecRisqueClientSetup.FrsChequeEncours <> '' then ChequeEncoursVisible := True;
        If RecRisqueClientSetup.FrsTraiteEncours <> '' then TraiteEncoursVisible := True;
        If RecRisqueClientSetup.FrsTraiteRemise <> '' then TraiteRemiseVisible := True;
        Rec.Setrange(FrsChequeEncoursFilter, RecRisqueClientSetup.FrsChequeEncours);
        Rec.Setrange(FrsTraiteEncoursFilter, RecRisqueClientSetup.FrsTraiteEncours);
        Rec.Setrange(FrsTraiteRemiseFilter, RecRisqueClientSetup.FrsTraiteRemise);






    end;

    trigger OnAfterGetRecord()
    begin
        RecRisqueClientSetup.Get();
        Rec.Setrange(FrsChequeEncoursFilter, RecRisqueClientSetup.FrsChequeEncours);
        Rec.Setrange(FrsTraiteEncoursFilter, RecRisqueClientSetup.FrsTraiteEncours);
        Rec.Setrange(FrsTraiteRemiseFilter, RecRisqueClientSetup.FrsTraiteRemise);

        If Vend.get(Rec.Code) then
            if VendorPostingGroup.get(Vend."Vendor Posting Group") then
                if VendorPostingGroup."STSG/L Account Filter" <> '' then
                    Rec.SetFilter("DLT G/L Account Filter", VendorPostingGroup."STSG/L Account Filter");

    end;
}
