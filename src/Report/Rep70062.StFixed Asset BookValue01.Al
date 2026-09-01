report 71062 "STFixed Asset - Book Value 01"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/STFixedAssetBookValue01.rdl';
    ApplicationArea = FixedAssets;
    Caption = 'Tableau d''amortissement';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(MainHeadLineText_FA; MainHeadLineText)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(DeprBookText_FA; DeprBookText)
            {
            }
            column(TableFilter_FA; TableCaption + ': ' + FAFilter)
            {
            }
            column(Filter_FA; FAFilter)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GroupTotals; SelectStr(GroupTotals + 1, GroupTotalsTxt))
            {
            }
            column(GroupCodeName; GroupCodeName)
            {
            }
            column(HeadLineText1; HeadLineText[1])
            {
            }
            column(HeadLineText2; HeadLineText[2])
            {
            }
            column(HeadLineText3; HeadLineText[3])
            {
            }
            column(HeadLineText4; HeadLineText[4])
            {
            }
            column(HeadLineText5; HeadLineText[5])
            {
            }
            column(HeadLineText6; HeadLineText[6])
            {
            }
            column(HeadLineText7; HeadLineText[7])
            {
            }
            column(HeadLineText8; HeadLineText[8])
            {
            }
            column(HeadLineText9; HeadLineText[9])
            {
            }
            column(HeadLineText10; HeadLineText[10])
            {
            }
            column(FANo; FANo)
            {
            }
            column(Desc_FA; FADescription)
            {
            }
            column(GroupHeadLine; GroupHeadLine)
            {
            }
            column(No_FA; "No.")
            {
            }
            column(Description_FA; Description)
            {
            }
            column(StartAmounts1; StartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmounts1; NetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmounts1; DisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts1; TotalEndingAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(StartAmounts2; StartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(NetChangeAmounts2; NetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(DisposalAmounts2; DisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalEndingAmounts2; TotalEndingAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(BookValueAtStartingDate; BookValueAtStartingDate)
            {
                AutoFormatType = 1;
            }
            column(BookValueAtEndingDate; BookValueAtEndingDate)
            {
                AutoFormatType = 1;
            }
            column(FormatGrpTotGroupHeadLine; Format(Text002 + ': ' + GroupHeadLine))
            {
            }
            column(GroupStartAmounts1; GroupStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmounts1; GroupNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmounts1; GroupDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(GroupStartAmounts2; GroupStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupNetChangeAmounts2; GroupNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(GroupDisposalAmounts2; GroupDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalStartAmounts1; TotalStartAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmounts1; TotalNetChangeAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmounts1; TotalDisposalAmounts[1])
            {
                AutoFormatType = 1;
            }
            column(TotalStartAmounts2; TotalStartAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalNetChangeAmounts2; TotalNetChangeAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(TotalDisposalAmounts2; TotalDisposalAmounts[2])
            {
                AutoFormatType = 1;
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            column(DepEndingBookDate; FAEndDate)
            {
            }

            column(FAEndDate; FAEndDateTXT)
            {

            }

            column(DepRate; DepRate)
            {
                AutoFormatType = 1;
            }



            column(DepRateTXT; DepRateTXT)
            {

            }

            column(MatriculeFiscal; Rec_Company."VAT Registration No.")
            {
            }
            column(Fax; Rec_Company."Fax No.")
            {
            }
            column(Phone; Rec_Company."Phone No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            column(Picture; Rec_Company.Picture)
            { }

            trigger OnAfterGetRecord()
            begin
                FAEndDate := 0D;
                if not FADeprBook.Get("No.", DeprBookCode) then
                    CurrReport.Skip();
                if SkipRecord() then
                    CurrReport.Skip();

                if GroupTotals = GroupTotals::"FA Posting Group" then
                    if "FA Posting Group" <> FADeprBook."FA Posting Group" then
                        Error(Text007, FieldCaption("FA Posting Group"), "No.");



                BeforeAmount := 0;
                EndingAmount := 0;
                DepRate := 0;
                FAEndDate := FADeprBook."Depreciation Starting Date";
                FASetup.Get('');
                if FASetup."ST depreciation rate" = FASetup."ST depreciation rate"::Linear then begin
                    if FADeprBook."Straight-Line %" <> 0 then
                        DepRate := FADeprBook."Straight-Line %"
                    else
                        if FADeprBook."No. of Depreciation Years" <> 0 then
                            DepRate := (1 / FADeprBook."No. of Depreciation Years") * 100;
                    DepRateTXT := 'Taux Amort';
                end;
                if FASetup."ST depreciation rate" = FASetup."ST depreciation rate"::Year then begin
                    if FADeprBook."No. of Depreciation Years" <> 0 then
                        DepRate := FADeprBook."No. of Depreciation Years"
                    else
                        if FADeprBook."Straight-Line %" <> 0 then
                            DepRate := (1 / FADeprBook."Straight-Line %") * 100;
                    DepRateTXT := 'Nbre Année';
                end;


                if BudgetReport then
                    BudgetDepreciation.Calculate(
                      "No.", GetStartingDate(StartingDate), EndingDate, DeprBookCode, BeforeAmount, EndingAmount);


                i := 0;
                while i < NumberOfTypes do begin
                    i := i + 1;
                    case i of
                        1:
                            PostingType := FADeprBook.FieldNo("Acquisition Cost");
                        2:
                            PostingType := FADeprBook.FieldNo(Depreciation);
                        3:
                            PostingType := FADeprBook.FieldNo("Write-Down");
                        4:
                            PostingType := FADeprBook.FieldNo(Appreciation);
                        5:
                            PostingType := FADeprBook.FieldNo("Custom 1");
                        6:
                            PostingType := FADeprBook.FieldNo("Custom 2");
                    end;
                    if StartingDate <= 00000101D then
                        StartAmounts[i] := 0
                    else
                        StartAmounts[i] := FAGenReport.CalcFAPostedAmount("No.", PostingType, Period1, StartingDate,
                            EndingDate, DeprBookCode, BeforeAmount, EndingAmount, false, true);
                    NetChangeAmounts[i] :=
                      FAGenReport.CalcFAPostedAmount(
                        "No.", PostingType, Period2, StartingDate, EndingDate,
                        DeprBookCode, BeforeAmount, EndingAmount, false, true);
                    if GetPeriodDisposal() then
                        DisposalAmounts[i] := -(StartAmounts[i] + NetChangeAmounts[i])
                    else
                        DisposalAmounts[i] := 0;
                    if i >= 3 then
                        AddPostingType(i - 3);
                end;
                for j := 1 to NumberOfTypes do
                    TotalEndingAmounts[j] := StartAmounts[j] + NetChangeAmounts[j] + DisposalAmounts[j];
                BookValueAtEndingDate := 0;
                BookValueAtStartingDate := 0;
                for j := 1 to NumberOfTypes do begin
                    BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
                    BookValueAtStartingDate := BookValueAtStartingDate + StartAmounts[j];
                end;

                MakeGroupHeadLine();
                UpdateTotals();
                CreateGroupTotals();
            end;

            trigger OnPostDataItem()
            begin
                CreateTotals();
            end;

            trigger OnPreDataItem()
            begin
                case GroupTotals of
                    GroupTotals::"FA Class":
                        SetCurrentKey("FA Class Code");
                    GroupTotals::"FA Subclass":
                        SetCurrentKey("FA Subclass Code");
                    GroupTotals::"FA Location":
                        SetCurrentKey("FA Location Code");
                    GroupTotals::"Main Asset":
                        SetCurrentKey("Component of Main Asset");
                    GroupTotals::"Global Dimension 1":
                        SetCurrentKey("Global Dimension 1 Code");
                    GroupTotals::"Global Dimension 2":
                        SetCurrentKey("Global Dimension 2 Code");
                    GroupTotals::"FA Posting Group":
                        SetCurrentKey("FA Posting Group");
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DeprBookCode; DeprBookCode)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Loi d''ammortissement';
                        TableRelation = "Depreciation Book";
                        ToolTip = 'Specifies the code for the depreciation book to be included in the report or batch job.';
                    }
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Date début';
                        ToolTip = 'Specifies the date when you want the report to start.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Date fin';
                        ToolTip = 'Specifies the date when you want the report to end.';
                    }
                    field(GroupTotals; GroupTotals)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Sous-totaux';
                        OptionCaptionML = ENG = ' ,FA Class,FA Subclass,FA Location,Main Asset,Global Dimension 1,Global Dimension 2,FA Posting Group',
                                          FRA = ' ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo.';
                        ToolTip = 'Specifies if you want the report to group fixed assets and print totals using the category defined in this field. For example, maintenance expenses for fixed assets can be shown for each fixed asset class.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Imprimer par immobilisation';
                        ToolTip = 'Specifies if you want the report to print information separately for each fixed asset.';
                    }
                    field(BudgetReport; BudgetReport)
                    {
                        ApplicationArea = Suite;
                        Caption = 'État budget';
                        ToolTip = 'Specifies if you want the report to calculate future depreciation and book value. This is valid only if you have selected Depreciation and Book Value for Amount Field 1, 2 or 3.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            GetDepreciationBookCode();
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        NumberOfTypes := 6;
        DeprBook.Get(DeprBookCode);
        if GroupTotals = GroupTotals::"FA Posting Group" then
            FAGenReport.SetFAPostingGroup("Fixed Asset", DeprBook.Code);
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GetFilters;
        MainHeadLineText := Text000;
        if BudgetReport then
            MainHeadLineText := StrSubstNo('%1 %2', MainHeadLineText, Text001);
        DeprBookText := StrSubstNo('%1%2 %3', DeprBook.TableCaption, ':', DeprBookCode);
        MakeGroupTotalText();
        FAGenReport.ValidateDates(StartingDate, EndingDate);
        MakeDateText();
        MakeHeadLine();
        if PrintDetails then begin
            FANo := "Fixed Asset".FieldCaption("No.");
            FADescription := "Fixed Asset".FieldCaption(Description);
        end;


        Period1 := Period1::"Before Starting Date";
        Period2 := Period2::"Net Change";
    end;

    trigger OnInitReport()
    begin
        Rec_Company.GET;
        Rec_Company.CALCFIELDS(Picture);
        TXTADRESSE := Rec_Company.Address + ' ' + Rec_Company.City + ' ' + Rec_Company."Post Code";
    end;

    var
        Text000: Label 'Immo. - Valeur comptable 01';

        Text001: Label '(Etat budget)';
        Text002: Label 'Sous-total';
        Text003: Label 'Sous-totaux';
        Text004: Label 'dans la période';
        Text005: Label 'Cession';
        Text006: Label 'Ajout';
        Text007: Label '%1 a été modifié(e) dans l''immobilisation %2.';

        DepRateTXT: Text;
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FA: Record "Fixed Asset";
        FAPostingTypeSetup: Record "FA Posting Type Setup";
        FAGenReport: Codeunit "FA General Report";
        BudgetDepreciation: Codeunit "Budget Depreciation";
        DeprBookCode: Code[10];
        FAFilter: Text;
        MainHeadLineText: Text[100];
        DeprBookText: Text[50];
        GroupCodeName: Text[50];
        GroupHeadLine: Text[50];
        FANo: Text[50];
        FADescription: Text[100];

        FAEndDateTXT: Label 'Date d''acquisition';

        FAEndDate: date;
        GroupTotals: Option " ","FA Class","FA Subclass","FA Location","Main Asset","Global Dimension 1","Global Dimension 2","FA Posting Group";
        HeadLineText: array[10] of Text[50];
        StartAmounts: array[6] of Decimal;
        NetChangeAmounts: array[6] of Decimal;
        DisposalAmounts: array[6] of Decimal;
        GroupStartAmounts: array[6] of Decimal;
        GroupNetChangeAmounts: array[6] of Decimal;
        GroupDisposalAmounts: array[6] of Decimal;
        TotalStartAmounts: array[6] of Decimal;
        TotalNetChangeAmounts: array[6] of Decimal;
        TotalDisposalAmounts: array[6] of Decimal;
        TotalEndingAmounts: array[6] of Decimal;
        BookValueAtStartingDate: Decimal;
        BookValueAtEndingDate: Decimal;
        i: Integer;
        j: Integer;
        NumberOfTypes: Integer;
        PostingType: Integer;
        Period1: Option "Before Starting Date","Net Change","at Ending Date";
        Period2: Option "Before Starting Date","Net Change","at Ending Date";
        StartingDate: Date;
        EndingDate: Date;
        PrintDetails: Boolean;
        BudgetReport: Boolean;
        BeforeAmount: Decimal;
        EndingAmount: Decimal;
        AcquisitionDate: Date;

        DepRate: Decimal;
        DisposalDate: Date;
        StartText: Text[30];
        EndText: Text[30];
        PageCaptionLbl: Label 'Page';
        TotalCaptionLbl: Label 'Total';
        GroupTotalsTxt: Label ' ,Classe immo.,Sous-classe immo.,Emplacement immo.,Immo. principale,Axe principal 1,Axe principal 2,Groupe compta. immo.';
        Rec_Company: Record "Company Information";
        TXTADRESSE: Text;

    local procedure AddPostingType(PostingType: Option "Write-Down",Appreciation,"Custom 1","Custom 2")
    var
        i: Integer;
        j: Integer;
    begin
        i := PostingType + 3;
        case PostingType of
            PostingType::"Write-Down":
                FAPostingTypeSetup.Get(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Write-Down");
            PostingType::Appreciation:
                FAPostingTypeSetup.Get(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::Appreciation);
            PostingType::"Custom 1":
                FAPostingTypeSetup.Get(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Custom 1");
            PostingType::"Custom 2":
                FAPostingTypeSetup.Get(DeprBookCode, FAPostingTypeSetup."FA Posting Type"::"Custom 2");
        end;
        if FAPostingTypeSetup."Depreciation Type" then
            j := 2
        else
            if FAPostingTypeSetup."Acquisition Type" then
                j := 1;
        if j > 0 then begin
            StartAmounts[j] := StartAmounts[j] + StartAmounts[i];
            StartAmounts[i] := 0;
            NetChangeAmounts[j] := NetChangeAmounts[j] + NetChangeAmounts[i];
            NetChangeAmounts[i] := 0;
            DisposalAmounts[j] := DisposalAmounts[j] + DisposalAmounts[i];
            DisposalAmounts[i] := 0;
        end;
    end;

    local procedure SkipRecord(): Boolean
    begin
        AcquisitionDate := FADeprBook."Acquisition Date";
        DisposalDate := FADeprBook."Disposal Date";
        exit(
          "Fixed Asset".Inactive or
          (AcquisitionDate = 0D) or
          (AcquisitionDate > EndingDate) and (EndingDate > 0D) or
          (DisposalDate > 0D) and (DisposalDate < StartingDate))
    end;

    local procedure GetPeriodDisposal(): Boolean
    begin
        if DisposalDate > 0D then
            if (EndingDate = 0D) or (DisposalDate <= EndingDate) then
                exit(true);
        exit(false);
    end;

    local procedure MakeGroupTotalText()
    begin
        case GroupTotals of
            GroupTotals::"FA Class":
                GroupCodeName := Format("Fixed Asset".FieldCaption("FA Class Code"));
            GroupTotals::"FA Subclass":
                GroupCodeName := Format("Fixed Asset".FieldCaption("FA Subclass Code"));
            GroupTotals::"FA Location":
                GroupCodeName := Format("Fixed Asset".FieldCaption("FA Location Code"));
            GroupTotals::"Main Asset":
                GroupCodeName := Format("Fixed Asset".FieldCaption("Main Asset/Component"));
            GroupTotals::"Global Dimension 1":
                GroupCodeName := Format("Fixed Asset".FieldCaption("Global Dimension 1 Code"));
            GroupTotals::"Global Dimension 2":
                GroupCodeName := Format("Fixed Asset".FieldCaption("Global Dimension 2 Code"));
            GroupTotals::"FA Posting Group":
                GroupCodeName := Format("Fixed Asset".FieldCaption("FA Posting Group"));
        end;
        if GroupCodeName <> '' then
            GroupCodeName := Format(StrSubstNo('%1%2 %3', Text003, ':', GroupCodeName));
    end;

    local procedure MakeDateText()
    begin
        StartText := StrSubstNo('%1', StartingDate - 1);
        EndText := StrSubstNo('%1', EndingDate);
    end;

    local procedure MakeHeadLine()
    var
        InPeriodText: Text[30];
        DisposalText: Text[30];
    begin
        InPeriodText := Text004;
        DisposalText := Text005;
        HeadLineText[1] := StrSubstNo('%1 %2', FADeprBook.FieldCaption("Acquisition Cost"), StartText);
        HeadLineText[2] := StrSubstNo('%1 %2', Text006, InPeriodText);
        HeadLineText[3] := StrSubstNo('%1 %2', DisposalText, InPeriodText);
        HeadLineText[4] := StrSubstNo('%1 %2', FADeprBook.FieldCaption("Acquisition Cost"), EndText);
        HeadLineText[5] := StrSubstNo('%1 %2', FADeprBook.FieldCaption(Depreciation), StartText);
        HeadLineText[6] := StrSubstNo('%1 %2', FADeprBook.FieldCaption(Depreciation), InPeriodText);
        HeadLineText[7] := StrSubstNo(
            '%1 %2 %3', DisposalText, FADeprBook.FieldCaption(Depreciation), InPeriodText);
        HeadLineText[8] := StrSubstNo('%1 %2', FADeprBook.FieldCaption(Depreciation), EndText);
        HeadLineText[9] := StrSubstNo('%1 %2', FADeprBook.FieldCaption("Book Value"), StartText);
        HeadLineText[10] := StrSubstNo('%1 %2', FADeprBook.FieldCaption("Book Value"), EndText);
    end;

    local procedure MakeGroupHeadLine()
    begin
        for j := 1 to NumberOfTypes do begin
            GroupStartAmounts[j] := 0;
            GroupNetChangeAmounts[j] := 0;
            GroupDisposalAmounts[j] := 0;
        end;
        case GroupTotals of
            GroupTotals::"FA Class":
                GroupHeadLine := Format("Fixed Asset"."FA Class Code");
            GroupTotals::"FA Subclass":
                GroupHeadLine := Format("Fixed Asset"."FA Subclass Code");
            GroupTotals::"FA Location":
                GroupHeadLine := Format("Fixed Asset"."FA Location Code");
            GroupTotals::"Main Asset":
                begin
                    FA."Main Asset/Component" := FA."Main Asset/Component"::"Main Asset";
                    GroupHeadLine :=
                      Format(StrSubstNo('%1 %2', Format(FA."Main Asset/Component"), "Fixed Asset"."Component of Main Asset"));
                    if "Fixed Asset"."Component of Main Asset" = '' then
                        GroupHeadLine := Format(StrSubstNo('%1 %2', GroupHeadLine, '*****'));
                end;
            GroupTotals::"Global Dimension 1":
                GroupHeadLine := Format("Fixed Asset"."Global Dimension 1 Code");
            GroupTotals::"Global Dimension 2":
                GroupHeadLine := Format("Fixed Asset"."Global Dimension 2 Code");
            GroupTotals::"FA Posting Group":
                GroupHeadLine := Format("Fixed Asset"."FA Posting Group");
        end;
        if GroupHeadLine = '' then
            GroupHeadLine := Format('*****');
    end;

    local procedure UpdateTotals()
    begin
        for j := 1 to NumberOfTypes do begin
            GroupStartAmounts[j] := GroupStartAmounts[j] + StartAmounts[j];
            GroupNetChangeAmounts[j] := GroupNetChangeAmounts[j] + NetChangeAmounts[j];
            GroupDisposalAmounts[j] := GroupDisposalAmounts[j] + DisposalAmounts[j];
            TotalStartAmounts[j] := TotalStartAmounts[j] + StartAmounts[j];
            TotalNetChangeAmounts[j] := TotalNetChangeAmounts[j] + NetChangeAmounts[j];
            TotalDisposalAmounts[j] := TotalDisposalAmounts[j] + DisposalAmounts[j];
        end;
    end;

    local procedure CreateGroupTotals()
    begin
        for j := 1 to NumberOfTypes do
            TotalEndingAmounts[j] :=
              GroupStartAmounts[j] + GroupNetChangeAmounts[j] + GroupDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        for j := 1 to NumberOfTypes do begin
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
            BookValueAtStartingDate := BookValueAtStartingDate + GroupStartAmounts[j];
        end;
    end;

    local procedure CreateTotals()
    begin
        for j := 1 to NumberOfTypes do
            TotalEndingAmounts[j] :=
              TotalStartAmounts[j] + TotalNetChangeAmounts[j] + TotalDisposalAmounts[j];
        BookValueAtEndingDate := 0;
        BookValueAtStartingDate := 0;
        for j := 1 to NumberOfTypes do begin
            BookValueAtEndingDate := BookValueAtEndingDate + TotalEndingAmounts[j];
            BookValueAtStartingDate := BookValueAtStartingDate + TotalStartAmounts[j];
        end;
    end;

    local procedure GetStartingDate(StartingDate: Date): Date
    begin
        if StartingDate <= 00000101D then
            exit(0D);

        exit(StartingDate - 1);
    end;

    procedure SetMandatoryFields(DepreciationBookCodeFrom: Code[10]; StartingDateFrom: Date; EndingDateFrom: Date)
    begin
        DeprBookCode := DepreciationBookCodeFrom;
        StartingDate := StartingDateFrom;
        EndingDate := EndingDateFrom;
    end;

    procedure SetTotalFields(GroupTotalsFrom: Option; PrintDetailsFrom: Boolean; BudgetReportFrom: Boolean)
    begin
        GroupTotals := GroupTotalsFrom;
        PrintDetails := PrintDetailsFrom;
        BudgetReport := BudgetReportFrom;
    end;

    procedure GetDepreciationBookCode()
    begin
        if DeprBookCode = '' then begin
            FASetup.Get();
            DeprBookCode := FASetup."Default Depr. Book";
        end;
    end;
}

