pageextension 71023 "ST Acc.ScheduleOverviewPagExt" extends "Acc. Schedule Overview" //490
{
    layout
    {

        addafter(Description)
        {
            field(STNote; Rec.STNote)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {


        // Add changes to page actions here

        addafter(Print)
        {

            action("Imprimer tableau analyse")
            {

                Caption = 'Imprimer tableau analyse';
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    AccSched: Report "STAccount Schedule 2";
                    DateFilter2: Text;
                    GLBudgetFilter2: Text;
                    BusUnitFilter: Text;
                    CostBudgetFilter2: Text;


                BEGIN
                    AccSched.SetAccSchedName(CurrentSchedName);
                    AccSched.SetColumnLayoutName(CurrentColumnName);
                    DateFilter2 := Rec.GETFILTER("Date Filter");
                    GLBudgetFilter2 := Rec.GETFILTER("G/L Budget Filter");
                    CostBudgetFilter2 := Rec.GETFILTER("Cost Budget Filter");
                    BusUnitFilter := Rec.GETFILTER("Business Unit Filter");
                    AccSched.SetFilters(DateFilter2, GLBudgetFilter2, CostBudgetFilter2, BusUnitFilter, Dim1Filter, Dim2Filter, Dim3Filter, Dim4Filter);
                    AccSched.RUN();
                end;
            }
            action("Etats Financiers")
            {

                Caption = 'Imprimer Tableau analyse financiers';
                Image = AnalysisView;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AccSched: Report "STAccount Schedule4";

                BEGIN
                    AccSched.GetInformation(Rec."Schedule Name", CurrentColumnName, Rec.GETFILTER("Date Filter"));
                    AccSched.RUN();
                end;
            }
            action("Notes Etats Financiers")
            {

                Caption = 'Imprimer Notes aux états financiers';
                Image = IssueFinanceCharge;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AccSched: Report "STAccount Schedule Note";
                    DateFilter2: Text;
                    GLBudgetFilter2: Text;
                    BusUnitFilter: Text;
                    CostBudgetFilter2: Text;
                    tabanalyse: Page "Acc. Schedule Overview";
                    columnTab: Record "Column Layout Name";

                BEGIN

                    //  accSchedManagement.SetColumnLayoutName(CurrentColumnName);
                    AccSched.GetInformationFromAccScheduleOverview(Rec."Schedule Name", CurrentColumnName, Rec.GETFILTER("Date Filter"));
                    AccSched.RUN();

                end;
            }


        }

    }

    Var
        CurrentSchedName: Code[10];
        CurrentColumnName: Code[10];
        Dim1Filter: Text;
        Dim2Filter: Text;
        Dim3Filter: Text;
        Dim4Filter: Text;




}





