report 71060 "Adjust Cost - Item Entries DLT"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = all;
    dataset
    {
        dataitem("Avg. Cost Adjmt. Entry Point"; "Avg. Cost Adjmt. Entry Point")
        {
            DataItemTableView = SORTING("Valuation Date", "Cost Is Adjusted")
                                ORDER(Ascending)
                                WHERE("Cost Is Adjusted" = FILTER(false));
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord();
            begin
                if ActiverControlHeureFin then
                    IF CURRENTDATETIME > Dateconrol THEN
                        CurrReport.BREAK();
                CLEAR(AdjustCostItemEntries);
                AdjustCostItemEntries.USEREQUESTPAGE(FALSE);
                AdjustCostItemEntries.SetPostToGL(PostToGL);
                AdjustCostItemEntries.InitializeRequest("Avg. Cost Adjmt. Entry Point"."Item No.", '');
                AdjustCostItemEntries.RUNMODAL();
                COMMIT();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    Caption = 'Option';
                    field(ActiverControlHeureFin; ActiverControlHeureFin)
                    {
                        Caption = 'Activer Contrôle sur l''heure de fin';
                        ApplicationArea = All;
                    }
                    field(HeureFin; HeureFin)
                    {
                        Caption = 'Heure Fin';
                        ApplicationArea = All;
                    }


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
    var
        myInt: Integer;
    begin
        InvtSetup.Get();
        HeureFin := 040000T;
        PostToGL := InvtSetup."Automatic Cost Posting";
    end;

    trigger OnPreReport();
    begin
        IF TIME < HeureFin
        THEN
            Dateconrol := CREATEDATETIME(CALCDATE('<+0D>', TODAY), HeureFin)
        ELSE
            Dateconrol := CREATEDATETIME(CALCDATE('<+1D>', TODAY), HeureFin);

    end;








    var
        AdjustCostItemEntries: Report "Adjust Cost - Item Entries";
        ExecutetDate: Date;
        Dateconrol: DateTime;
        ActiverControlHeureFin: Boolean;
        HeureFin: Time;
        PostToGL: Boolean;
        InvtSetup: Record "Inventory Setup";
}