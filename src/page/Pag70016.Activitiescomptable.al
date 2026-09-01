page 70016 "Activities comptable"
{
    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Finance Cue";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup("Intelligent Cloud")
            {
                Caption = 'Intelligent Cloud';
                Visible = False;

                actions
                {
                    action("Learn More")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Learn More';
                        Image = TileInfo;
                        RunPageMode = View;
                        ToolTip = ' Learn more about the Intelligent Cloud and how it can help your business.';

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                            HyperLink(STGetIntelligentCloudInsightsUrl());
                        end;
                    }
                    action("Intelligent Cloud Insights")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Intelligent Cloud Insights';
                        Image = TileCloud;
                        RunPageMode = View;
                        ToolTip = 'View your Intelligent Cloud insights.';

                        trigger OnAction()
                        var
                            IntelligentCloudManagement: Codeunit "Intelligent Cloud Management";
                        begin
                            //HyperLink(IntelligentCloudManagement.GetIntelligentCloudInsightsUrl);
                            HyperLink(STGetIntelligentCloudInsightsUrl());
                        end;
                    }
                }
            }
            cuegroup(Control36)
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                field("Overdue Purchase Documents"; Rec."Overdue Purchase Documents")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Vendor Ledger Entries";
                    ToolTip = 'Specifies the number of purchase invoices where your payment is late.';
                }
                field("Cash Accounts Balance"; Rec."Cash Accounts Balance")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Chart of Accounts";
                    Image = Cash;
                    ToolTip = 'Specifies the sum of the accounts that have the cash account category.';

                    trigger OnDrillDown()
                    var
                        ActivitiesMgt: Codeunit "Activities Mgt.";
                    begin
                        ActivitiesMgt.DrillDownCalcCashAccountsBalances();
                    end;
                }
                field("New Incoming Documents"; Rec."New Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Incoming Documents";
                    ToolTip = 'Specifies the number of new incoming documents in the company. The documents are filtered by today''s date.';
                }
            }
            cuegroup(Clients)
            {
                Caption = 'Clients';
                field("Sales Documents Due Today"; Rec."Sales Documents Due Today")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TotalChequeEnCoffre; Rec.TotalChequeEnCoffre)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("TotalChequeImpayé"; Rec."TotalChequeImpayé")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TotalChequecontentieux; Rec.TotalChequecontentieux)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TotalChequeEncoursVersement; Rec.TotalChequeEncoursVersement)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(TotalTraiteEnCoffre; Rec.TotalTraiteEnCoffre)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Traite encours d'encaissement"; Rec."Traite encours d'encaissement")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Traite encours escompte"; Rec."Traite encours escompte")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Traite Impayee"; Rec."Traite Impayee")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Preavise"; Rec."Cheque Preavise")
                {
                    ApplicationArea = Basic, Suite;
                }

            }

            cuegroup(Fournisseurs)
            {
                Caption = 'Fournisseurs';
                field("Purchase Documents Due Today"; Rec."Purchase Documents Due Today")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Vendor Ledger Entries";
                    ToolTip = 'Specifies the number of purchase invoices that are due for payment today.';
                }
                field("Cheque encours fournisseur"; Rec."Cheque encours fournisseur")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Traite encours fournisseur"; Rec."Traite encours fournisseur")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Traite remis au fournisseur"; Rec."Traite remis au fournisseur")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque Encaisse en banque"; Rec."Cheque Encaisse en banque")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cheque verse en banque"; Rec."Cheque verse en banque")
                {
                    ApplicationArea = Basic, Suite;
                }


                actions
                {
                    action("Edit Cash Receipt Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Edit Cash Receipt Journal';
                        RunObject = Page "Cash Receipt Journal";
                        ToolTip = 'Register received payments in a cash receipt journal that may already contain journal lines.';
                    }
                    action("New Sales Credit Memo")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Sales Credit Memo';
                        RunObject = Page "Sales Credit Memo";
                        RunPageMode = Create;
                        ToolTip = 'Process a return or refund by creating a new sales credit memo.';
                    }
                    action("Edit Payment Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Edit Payment Journal';
                        RunObject = Page "Payment Journal";
                        ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
                    }
                    action("New Purchase Credit Memo")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Purchase Credit Memo';
                        RunObject = Page "Purchase Credit Memo";
                        RunPageMode = Create;
                        ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
                    }
                }
            }
            cuegroup(Caisse)
            {
                Caption = 'Caisse';
                field("ST Total Montant caisse Depense"; "GTotal Montant caisse Depense")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Montant caisse Dépense';
                }
                field("ST Total Montant caisse recette"; "GTotal Montant caisse recette")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            cuegroup("Document Approvals")
            {
                Caption = 'Document Approvals';
                field("POs Pending Approval"; Rec."POs Pending Approval")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of purchase orders that are pending approval.';
                }
                field("SOs Pending Approval"; Rec."SOs Pending Approval")
                {
                    ApplicationArea = Suite;
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies the number of sales orders that are pending approval.';
                }

                actions
                {
                    action("Create Reminders...")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Reminders...';
                        RunObject = Report "Create Reminders";
                        ToolTip = 'Remind your customers of late payments.';
                    }
                    action("Create Finance Charge Memos...")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Create Finance Charge Memos...';
                        RunObject = Report "Create Finance Charge Memos";
                        ToolTip = 'Issue finance charge memos to your customers as a consequence of late payment.';
                    }
                }
            }
            cuegroup(Financials)
            {
                Caption = 'Financials';
                field("Non-Applied Payments"; Rec."Non-Applied Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unprocessed Payments';
                    DrillDownPageID = "Pmt. Reconciliation Journals";
                    Image = Cash;
                    ToolTip = 'Specifies a window to reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }

                actions
                {
                    action("New Payment Reconciliation Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Payment Reconciliation Journal';
                        ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing bank a bank statement feed or file.';

                        trigger OnAction()
                        var
                            BankAccReconciliation: Record "Bank Acc. Reconciliation";
                        begin
                            BankAccReconciliation.OpenNewWorksheet()
                        end;
                    }
                }
            }
            cuegroup("Incoming Documents")
            {
                Caption = 'Incoming Documents';
                field("Approved Incoming Documents"; Rec."Approved Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Incoming Documents";
                    ToolTip = 'Specifies the number of approved incoming documents in the company. The documents are filtered by today''s date.';
                }
                field("OCR Completed"; Rec."OCR Completed")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Incoming Documents";
                    ToolTip = 'Specifies that incoming document records that have been created by the OCR service.';
                }

                actions
                {
                    action(CheckForOCR)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receive from OCR Service';
                        RunObject = Codeunit "OCR - Receive from Service";
                        RunPageMode = View;
                        ToolTip = 'Process new incoming electronic documents that have been created by the OCR service and that you can convert to, for example, purchase invoices in Dynamics 365.';
                        Visible = ShowCheckForOCR;
                    }
                }
            }
            cuegroup("My User Tasks")
            {
                Caption = 'My User Tasks';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced with User Tasks Activities part';
                ObsoleteTag = '17.0';
                field("UserTaskManagement.GetMyPendingUserTasksCount"; UserTaskManagement.GetMyPendingUserTasksCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending User Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Replaced with User Tasks Activities part';
                    ObsoleteTag = '17.0';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks();
                        UserTaskList.Run();
                    end;
                }
            }
            cuegroup("Product Videos")
            {
                Caption = 'Product Videos';
                Visible = ShowProductVideosActivities;

                actions
                {
                    action(Action32)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Product Videos';
                        Image = TileVideo;
                        RunObject = Page "Product Videos";
                        ToolTip = 'Open a list of videos that showcase some of the product capabilities.';
                    }
                }
            }
            cuegroup("Get started")
            {
                Caption = 'Get started';
                Visible = ReplayGettingStartedVisible;

                actions
                {
                    action(ShowStartInMyCompany)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Try with my own data';
                        Image = TileSettings;
                        ToolTip = 'Set up My Company with the settings you choose. We''ll show you how, it''s easy.';
                        Visible = false;

                        // trigger OnAction()
                        // begin
                        //     if UserTours.IsAvailable and O365GettingStartedMgt.AreUserToursEnabled then
                        //         UserTours.StartUserTour(O365GettingStartedMgt.GetChangeCompanyTourID);
                        // end;
                    }
                    action(ReplayGettingStarted)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Play Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Show the Getting Started guide again.';

                        trigger OnAction()
                        var
                            O365GettingStarted: Record "O365 Getting Started";
                        begin
                            if O365GettingStarted.Get(UserId, ClientTypeManagement.GetCurrentClientType()) then begin
                                O365GettingStarted."Tour in Progress" := false;
                                O365GettingStarted."Current Page" := 1;
                                O365GettingStarted.Modify();
                                Commit();
                            end;

                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
            //FIXME
            // usercontrol(SATAsyncLoader; SatisfactionSurveyAsync)
            // {
            //     ApplicationArea = Basic, Suite;
            //     trigger ResponseReceived(Status: Integer; Response: Text)
            //     var
            //         SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
            //     begin
            //         SatisfactionSurveyMgt.TryShowSurvey(Status, Response);
            //     end;

            //     trigger ControlAddInReady();
            //     begin
            //         IsAddInReady := true;
            //         CheckIfSurveyEnabled();
            //     end;

            // }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CuesAndKpis: Codeunit "Cues And KPIs";
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ReplayGettingStartedVisible := false;
        if EnvironmentInfo.IsSaaS() then
            ReplayGettingStartedVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    trigger OnInit()
    var
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        ReplayGettingStartedVisible := false;
        if EnvironmentInfo.IsSaaS() then
            ReplayGettingStartedVisible := true;
    end;

    trigger OnOpenPage()
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
        BankAccount: Record "Bank Account";
        BankAccount1: Record "Bank Account";
        Activitiescomptable: Page "Activities comptable";
        coffre: Record "ST Coffre";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetFilter("Due Date Filter", '<=%1', WorkDate());
        Rec.SetFilter("Overdue Date Filter", '<%1', WorkDate());
        Rec.SetFilter("Due Next Week Filter", '%1..%2', CalcDate('<1D>', WorkDate()), CalcDate('<1W>', WorkDate()));
        //HH FIXME:
        //Rec.SetRange("User ID Filter", UserId);

        ShowProductVideosActivities := ClientTypeManagement.GetCurrentClientType() <> CLIENTTYPE::Phone;
        ShowCheckForOCR := OCRServiceMgt.OcrServiceIsEnable();
        ShowIntelligentCloud := not EnvironmentInfo.IsSaaS();

        RoleCenterNotificationMgt.ShowNotifications();
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent();
        "GTotal Montant caisse Depense" := 0;
        "GTotal Montant caisse recette" := 0;
        IF UserSetup.GET(UPPERCASE(USERID)) THEN
            IF UserSetup.STCoffre <> '' THEN BEGIN
                BankAccount.Reset();
                BankAccount.SetRange(STCaisse, BankAccount.STCaisse::"Dépense");
                BankAccount.SetRange("No.", userSetup."STcaisse-Depense-par defaut");
                if BankAccount.FindFirst() then begin
                    BankAccount.CalcFields(Balance);
                    "GTotal Montant caisse Depense" := BankAccount.Balance;
                end;
                BankAccount1.Reset();
                BankAccount1.SetRange(STCaisse, BankAccount1.STCaisse::Recette);
                BankAccount1.SetRange("No.", userSetup."STcaisse-Recette-par defaut");
                if BankAccount1.FindFirst() then begin
                    BankAccount1.CalcFields(Balance);
                    "GTotal Montant caisse recette" := BankAccount1.Balance;
                end;
            END else begin
                BankAccount.Reset();
                BankAccount.SetRange(STCaisse, BankAccount.STCaisse::"Dépense");
                if BankAccount.FindSet() then
                    repeat
                        BankAccount.CalcFields(Balance);
                        "GTotal Montant caisse Depense" += BankAccount.Balance;
                    until BankAccount.Next() = 0;
                BankAccount1.Reset();
                BankAccount1.SetRange(STCaisse, BankAccount1.STCaisse::Recette);
                if BankAccount1.FindSet() then
                    repeat
                        BankAccount1.CalcFields(Balance);
                        "GTotal Montant caisse recette" += BankAccount1.Balance;
                    until BankAccount1.Next() = 0;
            end;

        IF UserSetup.GET(UPPERCASE(USERID)) THEN
            IF UserSetup.STCoffre <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETRANGE("Coffre utilisateur", UserSetup.STCoffre);
                Rec.FILTERGROUP(0);
            END;
        CurrPage.Update();
    end;

    var
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        ClientTypeManagement: Codeunit "Client Type Management";
        EnvironmentInfo: Codeunit "Environment Information";
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        UserTaskManagement: Codeunit "User Task Management";
        // PageNotifier: DotNet PageNotifier;
        // UserTours: DotNet UserTours;
        ShowProductVideosActivities: Boolean;
        HideSatisfactionSurvey: Boolean;
        ReplayGettingStartedVisible: Boolean;
        WhatIsNewTourVisible: Boolean;
        ShowCheckForOCR: Boolean;
        ShowIntelligentCloud: Boolean;
        IsAddInReady: Boolean;
        IsPageReady: Boolean;
        userSetup: Record "User Setup";
        "GTotal Montant caisse recette": Decimal;
        "GTotal Montant caisse Depense": Decimal;



    local procedure CalculateCueFieldValues()
    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
    begin
        if Rec.FieldActive("Cash Accounts Balance") then
            Rec."Cash Accounts Balance" := ActivitiesMgt.CalcCashAccountsBalances();
    end;

    // local procedure StartWhatIsNewTour(hasTourCompleted: Boolean): Boolean
    // var
    //     O365UserTours: Record "User Tours";
    //     TourID: Integer;
    // begin
    //     TourID := O365GettingStartedMgt.GetWhatIsNewTourID;

    //     if O365UserTours.AlreadyCompleted(TourID) then
    //         exit(false);

    //     if not hasTourCompleted then begin
    //         UserTours.StartUserTour(TourID);
    //         WhatIsNewTourVisible := true;
    //         exit(true);
    //     end;

    //     if WhatIsNewTourVisible then begin
    //         O365UserTours.MarkAsCompleted(TourID);
    //         WhatIsNewTourVisible := false;
    //     end;
    //     exit(false);
    // end;

    // trigger UserTours::ShowTourWizard(hasTourCompleted: Boolean)
    // begin
    //     if O365GettingStartedMgt.IsGettingStartedSupported then
    //         if O365GettingStartedMgt.LaunchWizard(false, hasTourCompleted) then begin
    //             HideSatisfactionSurvey := true;
    //             exit;
    //         end;

    //     if StartWhatIsNewTour(hasTourCompleted) then
    //         HideSatisfactionSurvey := true;
    // end;

    // trigger UserTours::IsTourInProgressResultReady(isInProgress: Boolean)
    // begin
    // end;

    // trigger PageNotifier::PageReady()
    // begin
    //     IsPageReady := true;
    //     CheckIfSurveyEnabled();
    // end;


    //FIXME 
    // local procedure CheckIfSurveyEnabled()
    // var
    //     SatisfactionSurveyMgt: Codeunit "Satisfaction Survey Mgt.";
    //     CheckUrl: Text;
    // begin
    //     if not IsAddInReady then
    //         exit;
    //     if not IsPageReady then
    //         exit;
    //     if not SatisfactionSurveyMgt.DeactivateSurvey() then
    //         exit;
    //     if HideSatisfactionSurvey then
    //         exit;
    //     if not SatisfactionSurveyMgt.TryGetCheckUrl(CheckUrl) then
    //         exit;
    //     CurrPage.SATAsyncLoader.SendRequest(CheckUrl, SatisfactionSurveyMgt.GetRequestTimeoutAsync());
    // end;

    procedure STGetIntelligentCloudInsightsUrl(): Text
    var
        BaseUrl: Text;
        ParameterUrl: Text;
        NoDomainUrl: Text;
    begin
        BaseUrl := GetUrl(CLIENTTYPE::Web);
        ParameterUrl := GetUrl(CLIENTTYPE::Web, CompanyName, OBJECTTYPE::Page, 4013);
        NoDomainUrl := DelChr(ParameterUrl, '<', BaseUrl);

        exit(StrSubstNo('https://businesscentral.dynamics.com/%1', NoDomainUrl));
    end;

}

