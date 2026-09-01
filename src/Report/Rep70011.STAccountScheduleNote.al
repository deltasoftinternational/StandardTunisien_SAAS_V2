report 70011 "STAccount Schedule Note"
{
    // //Delta 01 27/10/2016 commenter par Soumaya
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDLC/AccountScheduleNoteNew2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Notes aux états financiers';

    dataset
    {
        dataitem("Acc. Schedule Name"; "Acc. Schedule Name")
        {
            DataItemTableView = SORTING(Name);
            column(SHowLogo; SHowLogo) { }
            column(ShowUserDate; ShowUserDate) { }
            column(Name_AccScheduleName; Description)
            {
            }
            column(Picture; RecGCompanyInfo.Picture)
            {
            }
            column(RecGCompanyInfoCity; RecGCompanyInfo.City)
            {
            }
            column(Phone; RecGCompanyInfo."Phone No.")
            {

            }
            column(Fax; RecGCompanyInfo."Fax No.")
            {

            }
            column(MatriculeFiscal; RecGCompanyInfo."VAT Registration No.")
            {
            }
            column(TxtAdresse; TXTADRESSE)
            {

            }
            column(CompanyAdr; RecGCompanyInfo.Address)
            {
            }
            column(CompanyCode; RecGCompanyInfo."Post Code")
            {
            }
            column(CompanyCity; RecGCompanyInfo.City)
            {
            }
            column(CompanyFax; RecGCompanyInfo."Fax No.")
            {
            }
            column(CompanyPhone; RecGCompanyInfo."Phone No.")
            {
            }
            column(CompanyVAT; RecGCompanyInfo."VAT Registration No.")
            {
            }
            dataitem(Heading; "Integer")
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(ColumnLayoutName; ColumnLayoutName)
                {
                }
                column(FiscalStartDate; FORMAT(FiscalStartDate))
                {
                }
                column(PeriodText; PeriodText)
                {
                }
                column(CompanyName; COMPANYNAME)
                {
                }
                column(AnneeExercice; 'Exercice  ' + AnneeExercice)
                {
                }
                column(AccScheduleNameDesc; "Acc. Schedule Name".Description)
                {
                }
                column(AnalysisViewCode; AnalysisView.Code)
                {
                }
                column(AnalysisViewName; AnalysisView.Name)
                {
                }
                column(HeaderText; HeaderText)
                {
                }
                // column(AccScheduleLineTableCaption; "Acc. Schedule Line".TABLECAPTION + ': ' + AccSchedLineFilter)
                // {
                // }
                column(AccSchedLineFilter; AccSchedLineFilter)
                {
                }
                column(ShowAccSchedSetup; ShowAccSchedSetup)
                {
                }
                column(ColumnLayoutNameCaption; ColumnLayoutNameCaptionLbl)
                {
                }
                column(AccScheduleNameCaption; AccScheduleNameCaptionLbl)
                {
                }
                column(FiscalStartDateCaption; FiscalStartDateCaptionLbl)
                {
                }
                column(PeriodTextCaption; PeriodTextCaptionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(AccScheduleCaption; AccScheduleCaptionLbl)
                {
                }
                column(AnalysisViewCodeCaption; AnalysisViewCodeCaptionLbl)
                {
                }
                column(RowNo_AccSchedLineSpecCaption; RowNo_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Desc_AccSchedLineSpecCaption; Desc_AccSchedLineSpecCaptionLbl)
                {
                }
                column(TotalType_AccSchedLineSpecCaption; TotalType_AccSchedLineSpecCaptionLbl)
                {
                }
                column(AnalysisViewDim1CodeCaption; AnalysisViewDim1CodeCaptionLbl)
                {
                }
                column(Totaling_AccSchedLineSpecCaption; Totaling_AccSchedLineSpecCaptionLbl)
                {
                }
                column(RowType_AccSchedLineSpecCaption; RowType_AccSchedLineSpecCaptionLbl)
                {
                }
                column(AmtType_AccSchedLineSpecCaption; AmtType_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Show_AccSchedLineSpecCaption; Show_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Underline_AccSchedLineSpecCaption; Underline_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Italic_AccSchedLineSpecCaption; Italic_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Bold_AccSchedLineSpecCaption; Bold_AccSchedLineSpecCaptionLbl)
                {
                }
                column(ShowOppSign_AccSchedLineSpecCaption; ShowOppSign_AccSchedLineSpecCaptionLbl)
                {
                }
                column(NewPage_AccSchedLineSpecCaption; NewPage_AccSchedLineSpecCaptionLbl)
                {
                }
                column(Adress; Adress)
                {
                }
                column(FiscalCode; FiscalCode)
                {
                }
                column(RegistreCommerce; RegistreCommerce)
                {
                }
                dataitem(AccSchedLineSpec; "Acc. Schedule Line")
                {
                    DataItemLink = "Schedule Name" = FIELD(Name);
                    DataItemLinkReference = "Acc. Schedule Name";
                    DataItemTableView = SORTING("Schedule Name", "Line No.");
                    column(Show_AccSchedLineSpec; Show)
                    {
                    }
                    column(TotalType_AccSchedLineSpec; "Totaling Type")
                    {
                    }
                    column(Totaling_AccSchedLineSpec; Totaling)
                    {
                    }
                    column(Desc_AccSchedLineSpec; Description)
                    {
                    }
                    column(RowNo_AccSchedLineSpec; "Row No.")
                    {
                    }
                    column(RowType_AccSchedLineSpec; "Row Type")
                    {
                    }
                    column(AmtType_AccSchedLineSpec; "Amount Type")
                    {
                    }
                    column(Bold; FORMAT(Bold))
                    {
                    }
                    column(Italic; FORMAT(Italic))
                    {
                    }
                    column(Underline; FORMAT(Underline))
                    {
                    }
                    column(ShowOppSign; FORMAT("Show Opposite Sign"))
                    {
                    }
                    column(NewPage; FORMAT("New Page"))
                    {
                    }
                    column(AnalysisViewDim1Code; AnalysisView."Dimension 1 Code")
                    {
                    }
                    column(Dim1Total_AccSchedLineSpec; "Dimension 1 Totaling")
                    {
                    }
                    column(AnalysisViewDim2Code; AnalysisView."Dimension 2 Code")
                    {
                    }
                    column(Dim2Total_AccSchedLineSpec; "Dimension 2 Totaling")
                    {
                    }
                    column(AnalysisViewDim3Code; AnalysisView."Dimension 3 Code")
                    {
                    }
                    column(Dim3Total_AccSchedLineSpec; "Dimension 3 Totaling")
                    {
                    }
                    column(AnalysisViewDim4Code; AnalysisView."Dimension 4 Code")
                    {
                    }
                    column(Dim4Total_AccSchedLineSpec; "Dimension 4 Totaling")
                    {
                    }
                    column(ScheduleName_AccSchedLineSpec; "Schedule Name")
                    {
                    }
                    column(SetupLineShadowed; LineShadowed)
                    {
                    }
                    column(Note_AccSchedLineSpec; STNote)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Row No." <> '' THEN
                            LineShadowed := NOT LineShadowed
                        ELSE
                            LineShadowed := FALSE;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT ShowAccSchedSetup THEN
                            CurrReport.BREAK();

                        NextPageGroupNo += 1;
                    end;
                }
                dataitem(PageBreak; "Integer")
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));

                    trigger OnAfterGetRecord()
                    begin
                        CurrReport.NEWPAGE();
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT ShowAccSchedSetup THEN
                            CurrReport.BREAK();
                    end;
                }
                dataitem("Acc. Schedule Line"; "Acc. Schedule Line")
                {
                    DataItemLink = "Schedule Name" = FIELD(Name);
                    DataItemLinkReference = "Acc. Schedule Name";
                    DataItemTableView = SORTING("Schedule Name", "Line No.")
                                        WHERE(Totaling = FILTER(<> '')
                                             /* STNote = FILTER(<> '')*/);
                    PrintOnlyIfDetail = false;
                    column(NextPageGroupNo; NextPageGroupNo)
                    {
                        // OptionCaption = 'None,Division by Zero,Period Error,Both';
                    }
                    column(Desc_AccScheduleLine; Description)
                    {
                    }
                    column(RowNo_AccScheduleLine; "Row No.")
                    {
                    }
                    column(LineNo_AccScheduleLine; "Line No.")
                    {
                    }
                    column(Bold_AccScheduleLine; Bold_AccScheduleLine)
                    {
                    }
                    column(Italic_AccScheduleLine; Italic_AccScheduleLine)
                    {
                    }
                    column(Underline_AccScheduleLine; Underline_AccScheduleLine)
                    {
                    }
                    column(LineShadowed; LineShadowed)
                    {
                    }
                    column(Note_AccSchedLine; STNote)
                    {
                    }
                    column(Totaling_AccSchedLine; Totaling)
                    {
                    }
                    column(Show_Opposite_Sign; "Show Opposite Sign")
                    {
                    }
                    column(Tot; Tot)
                    {
                    }
                    column(TotN; TotN)
                    {
                    }
                    dataitem("G/L Account"; "G/L Account")
                    {
                        DataItemTableView = SORTING("No.")
                                            WHERE("Account Type" = CONST(Posting));
                        column(No_GLAccount; "G/L Account"."No.")
                        {
                        }
                        column(Name_GLAccount; "G/L Account".Name)
                        {
                        }
                        column(AccountType_GLAccount; "G/L Account"."Account Type")
                        {
                        }
                        column(NetChange_GLAccount; "G/L Account"."Net Change")
                        {
                        }
                        column(DecGDebit; DecGDebit)
                        {
                        }
                        column(DecGDebitN; DecGDebitN)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            //>>DELTA CHK 12/11/2015
                            //>>

                            DecGDebit := 0;
                            DecGDebitN := 0;

                            CALCFIELDS("Debit Amount", "Credit Amount", Balance, "Balance at Date", "Net Change");


                            IF "Acc. Schedule Line"."STTotalisation debiteur" <> '' THEN BEGIN
                                CASE "Acc. Schedule Line"."Row Type" OF
                                    0:
                                        IF "Net Change" > 0 THEN
                                            DecGDebit := "Net Change";
                                    1:
                                        IF "Balance at Date" > 0 THEN
                                            DecGDebit := "Balance at Date";
                                    2:
                                        IF Balance > 0 THEN
                                            DecGDebit := Balance;
                                END;
                                Tot := Tot + DecGDebit
                            END
                            ELSE
                                IF "Acc. Schedule Line"."STTotalisation Crediteur" <> '' THEN BEGIN
                                    CASE "Acc. Schedule Line"."Row Type" OF
                                        0:
                                            IF "Net Change" < 0 THEN
                                                DecGDebit := "Net Change";
                                        1:
                                            IF "Balance at Date" < 0 THEN
                                                DecGDebit := "Balance at Date";
                                        2:
                                            IF Balance < 0 THEN
                                                DecGDebit := Balance;
                                    END;
                                    Tot := Tot + DecGDebit
                                END
                                ELSE BEGIN
                                    CASE "Acc. Schedule Line"."Row Type" OF
                                        0:
                                            DecGDebit := "Net Change";
                                        1:
                                            DecGDebit := "Balance at Date";
                                        2:
                                            DecGDebit := Balance;
                                    END;
                                    Tot := Tot + DecGDebit
                                END;

                            //<<
                            //>>
                            GlAccountN.GET("No.");
                            GlAccountN.RESET();

                            GlAccountN.SETrange("Account Type", Enum::"G/L Account Type"::Posting);

                            IF "Acc. Schedule Line"."Row Type" = 1 THEN
                                GlAccountN.SETFILTER("Date Filter", '%1..%2', 0D, DATEFN)
                            ELSE
                                GlAccountN.SETFILTER("Date Filter", '%1..%2', DATEDN, DATEFN);
                            //MESSAGE('%1',GlAccountN.GETFILTER("Date Filter"));
                            Paramcompta.GET();
                            IF "Acc. Schedule Line"."Dimension 1 Filter" <> '' THEN
                                GlAccountN.SETFILTER("Global Dimension 1 Filter", "Acc. Schedule Line"."Dimension 1 Filter");

                            IF "Acc. Schedule Line"."Dimension 2 Filter" <> '' THEN
                                GlAccountN.SETFILTER("Global Dimension 2 Filter", "Acc. Schedule Line"."Dimension 2 Filter");

                            //SETFILTER("Date Filter","Acc. Schedule Line".GETFILTER("Date Filter"));
                            IF "Acc. Schedule Line".Totaling <> '' THEN
                                GlAccountN.SETFILTER("No.", "Acc. Schedule Line".Totaling)
                            ELSE
                                GlAccountN.SETRANGE("No.", "Acc. Schedule Line".Totaling);

                            GlAccountN.CALCFIELDS("Debit Amount", "Credit Amount", Balance, "Balance at Date", "Net Change");


                            IF "Acc. Schedule Line"."STTotalisation debiteur" <> '' THEN BEGIN
                                CASE "Acc. Schedule Line"."Row Type" OF
                                    0:
                                        IF GlAccountN."Net Change" > 0 THEN
                                            DecGDebitN := GlAccountN."Net Change";
                                    1:
                                        IF GlAccountN."Balance at Date" > 0 THEN
                                            DecGDebitN := GlAccountN."Balance at Date";
                                    2:
                                        IF GlAccountN.Balance > 0 THEN
                                            DecGDebitN := GlAccountN.Balance;
                                END;
                                TotN := TotN + DecGDebitN
                            END
                            ELSE
                                IF "Acc. Schedule Line"."STTotalisation Crediteur" <> '' THEN BEGIN
                                    CASE "Acc. Schedule Line"."Row Type" OF
                                        0:
                                            IF GlAccountN."Net Change" < 0 THEN
                                                DecGDebitN := GlAccountN."Net Change";
                                        1:
                                            IF GlAccountN."Balance at Date" < 0 THEN
                                                DecGDebitN := GlAccountN."Balance at Date";
                                        2:
                                            IF GlAccountN.Balance < 0 THEN
                                                DecGDebitN := GlAccountN.Balance;
                                    END;
                                    TotN := TotN + DecGDebitN
                                END
                                ELSE BEGIN
                                    CASE "Acc. Schedule Line"."Row Type" OF
                                        0:
                                            DecGDebitN := GlAccountN."Net Change";
                                        1:
                                            DecGDebitN := GlAccountN."Balance at Date";
                                        2:
                                            DecGDebitN := GlAccountN.Balance;
                                    END;
                                    TotN := TotN + DecGDebitN
                                END;

                            //<<
                            //<<DELTA CHK 12/11/2015
                        end;

                        trigger OnPreDataItem()
                        begin
                            //>>DELTA CHK 12/03/2014
                            IF "Acc. Schedule Line"."Row Type" = 1 THEN
                                SETFILTER("Date Filter", '%1..%2', 0D, DATEF)
                            ELSE
                                SETFILTER("Date Filter", "Acc. Schedule Line".GETFILTER("Date Filter"));
                            Paramcompta.GET();
                            IF "Acc. Schedule Line"."Dimension 1 Filter" <> '' THEN
                                SETFILTER("Global Dimension 1 Filter", "Acc. Schedule Line"."Dimension 1 Filter");

                            IF "Acc. Schedule Line"."Dimension 2 Filter" <> '' THEN
                                SETFILTER("Global Dimension 2 Filter", "Acc. Schedule Line"."Dimension 2 Filter");

                            //SETFILTER("Date Filter","Acc. Schedule Line".GETFILTER("Date Filter"));
                            IF "Acc. Schedule Line".Totaling <> '' THEN
                                SETFILTER("No.", "Acc. Schedule Line".Totaling)
                            ELSE
                                SETRANGE("No.", "Acc. Schedule Line".Totaling);
                            /*
                            //SOLDE PERIODE
                            IF "Acc. Schedule Line"."Row Type" = 0 THEN
                            BEGIN
                              IF "Acc. Schedule Line"."Totalisation débiteur" <>'' THEN
                                SETFILTER("Net Change",'>%1',0);
                            
                              IF "Acc. Schedule Line"."Totalisation créditeur" <>'' THEN
                                SETFILTER("Net Change",'<%1',0);
                            END;
                            
                            //SOLDE AU
                            IF "Acc. Schedule Line"."Row Type" = 1 THEN
                            BEGIN
                              IF "Acc. Schedule Line"."Totalisation débiteur" <>'' THEN
                                SETFILTER("Balance at Date",'>%1',0);
                            
                              IF "Acc. Schedule Line"."Totalisation créditeur" <>'' THEN
                                SETFILTER("Balance at Date",'<%1',0);
                            END;
                            
                            //SOLDE OUVERTURE
                            IF "Acc. Schedule Line"."Row Type" = 2 THEN
                            BEGIN
                              IF "Acc. Schedule Line"."Totalisation débiteur" <>'' THEN
                                SETFILTER(Balance,'>%1',0);
                            
                              IF "Acc. Schedule Line"."Totalisation créditeur" <>'' THEN
                                SETFILTER(Balance,'<%1',0);
                            END;
                            */
                            //<<DELTA CHK 12/03/2014

                        end;
                    }
                    dataitem("Column Layout"; "Column Layout")
                    {
                        column(ColumnNo; "Column No.")
                        {
                        }
                        column(Header; Header)
                        {
                        }
                        column(RoundingHeader; RoundingHeader)
                        {
                            AutoCalcField = false;
                        }
                        column(ColumnValuesAsText; ColumnValuesAsText)
                        {
                            AutoCalcField = false;
                        }
                        column(LineSkipped; LineSkipped)
                        {
                        }
                        column(LineNo_ColumnLayout; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Show = Show::Never THEN
                                CurrReport.SKIP();

                            Header := "Column Header";
                            RoundingHeader := '';

                            IF "Rounding Factor" IN ["Rounding Factor"::"1000", "Rounding Factor"::"1000000"] THEN BEGIN
                                HasRounding := TRUE;
                                CASE "Rounding Factor" OF
                                    "Rounding Factor"::"1000":
                                        RoundingHeader := Text000;
                                    "Rounding Factor"::"1000000":
                                        RoundingHeader := Text001;
                                END;
                            END;

                            ColumnValuesAsText := '';
                            //Delta 01 27/10/2016 commenter par Soumaya
                            ColumnValuesDisplayed := AccSchedManagement.CalcCell("Acc. Schedule Line", "Column Layout", UseAmtsInAddCurr);
                            //ColumnValuesDisplayed := AccSchedManagement.CalcCell("Acc. Schedule Line","Column Layout",UseAmtsInAddCurr);
                            IF AccSchedManagement.GetDivisionError() THEN BEGIN
                                IF ShowError IN [ShowError::"Division by Zero", ShowError::Both] THEN
                                    ColumnValuesAsText := Text002;
                            END ELSE
                                IF AccSchedManagement.GetPeriodError() THEN BEGIN
                                    IF ShowError IN [ShowError::"Period Error", ShowError::Both] THEN
                                        ColumnValuesAsText := Text004;
                                END ELSE BEGIN
                                    ColumnValuesAsText :=
                                         AccSchedManagement.FormatCellAsText("Column Layout", ColumnValuesDisplayed, UseAmtsInAddCurr);
                                    //AccSchedManagement.FormatCellAsText("Column Layout",ColumnValuesDisplayed,TRUE);

                                    IF "Acc. Schedule Line"."Totaling Type" = "Acc. Schedule Line"."Totaling Type"::Formula THEN
                                        CASE "Acc. Schedule Line".Show OF
                                            "Acc. Schedule Line".Show::"When Positive Balance":
                                                IF ColumnValuesDisplayed < 0 THEN
                                                    ColumnValuesAsText := '';
                                            "Acc. Schedule Line".Show::"When Negative Balance":
                                                IF ColumnValuesDisplayed > 0 THEN
                                                    ColumnValuesAsText := '';
                                            "Acc. Schedule Line".Show::"If Any Column Not Zero":
                                                IF ColumnValuesDisplayed = 0 THEN
                                                    ColumnValuesAsText := '';
                                        END;
                                END;

                            IF (ColumnValuesAsText <> '') OR ("Acc. Schedule Line".Show = "Acc. Schedule Line".Show::Yes) THEN
                                LineSkipped := FALSE;
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF LineSkipped THEN
                                LineShadowed := NOT LineShadowed;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Column Layout Name", ColumnLayoutName);
                            LineSkipped := TRUE;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF (Show = Show::No) OR NOT ShowLine("Acc. Schedule Line".Bold, "Acc. Schedule Line".Italic) THEN
                            CurrReport.SKIP();

                        Bold_AccScheduleLine := "Acc. Schedule Line".Bold;
                        Italic_AccScheduleLine := "Acc. Schedule Line".Italic;
                        Underline_AccScheduleLine := "Acc. Schedule Line".Underline;
                        PageGroupNo := NextPageGroupNo;
                        IF "Acc. Schedule Line"."New Page" THEN
                            NextPageGroupNo := PageGroupNo + 1;

                        IF "Row No." <> '' THEN
                            LineShadowed := NOT LineShadowed
                        ELSE
                            LineShadowed := FALSE;
                        Tot := 0;
                        TotN := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        PageGroupNo := NextPageGroupNo;

                        SETFILTER("Date Filter", DateFilter);
                        SETFILTER("G/L Budget Filter", GLBudgetFilter);
                        SETFILTER("Cost Budget Filter", CostBudgetFilter);
                        SETFILTER("Business Unit Filter", BusinessUnitFilter);
                        SETFILTER("Dimension 1 Filter", Dim1Filter);
                        SETFILTER("Dimension 2 Filter", Dim2Filter);
                        SETFILTER("Dimension 3 Filter", Dim3Filter);
                        SETFILTER("Dimension 4 Filter", Dim4Filter);
                        SETFILTER("Cost Center Filter", CostCenterFilter);
                        SETFILTER("Cost Object Filter", CostObjectFilter);
                        SETFILTER("Cash Flow Forecast Filter", CashFlowFilter);
                        //>>DELTA CHK 12/03/2014
                        TextePeriode := GETFILTER("Date Filter");
                        IF "Acc. Schedule Line".GETFILTER("Acc. Schedule Line"."Date Filter") <> '' THEN BEGIN
                            DATED := "Acc. Schedule Line".GETRANGEMIN("Acc. Schedule Line"."Date Filter");
                            DATEF := "Acc. Schedule Line".GETRANGEMAX("Acc. Schedule Line"."Date Filter");
                            DATEDN := CALCDATE('<-1Y>', "Acc. Schedule Line".GETRANGEMIN("Acc. Schedule Line"."Date Filter"));
                            DATEFN := CALCDATE('<-1Y>', "Acc. Schedule Line".GETRANGEMAX("Acc. Schedule Line"."Date Filter"));

                        END;
                        //<<DELTA CHK 12/03/2014
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.PAGENO := 1;
                GLSetup.GET();
                IF "Analysis View Name" <> '' THEN
                    AnalysisView.GET("Analysis View Name")
                ELSE BEGIN
                    AnalysisView.INIT();
                    AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
                    AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
                END;

                IF UseAmtsInAddCurr THEN
                    HeaderText := STRSUBSTNO(Text003, GLSetup."Additional Reporting Currency")
                ELSE
                    IF GLSetup."LCY Code" <> '' THEN
                        HeaderText := STRSUBSTNO(Text003, GLSetup."LCY Code")
                    ELSE
                        HeaderText := '';
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Name, AccSchedName);

                PageGroupNo := 1;
                NextPageGroupNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group(Layout)
                    {
                        CaptionML = ENU = 'Layout',
                                    FRA = 'Mise en page';
                        field(SHowLogo; SHowLogo)
                        {
                            Caption = 'Afficher logo';
                            ApplicationArea = All;
                        }
                        field(ShowUserDate; ShowUserDate)
                        {
                            Caption = 'Afficher utilisateur & date';
                            ApplicationArea = All;
                        }
                        field(AccSchedNam; AccSchedName)
                        {
                            CaptionML = ENU = 'Acc. Schedule Name',
                                        FRA = 'Nom tableau d''analyse';
                            Lookup = true;
                            TableRelation = "Acc. Schedule Name";
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(AccSchedManagement.LookupName(AccSchedName, Text));
                            end;

                            trigger OnValidate()
                            begin
                                ValidateAccSchedName()
                            end;
                        }
                        field(ColumnLayoutNames; ColumnLayoutName)
                        {
                            CaptionML = ENU = 'Column Layout Name',
                                        FRA = 'Nom présentation colonne';
                            Lookup = true;
                            TableRelation = "Column Layout Name".Name;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(AccSchedManagement.LookupColumnName(ColumnLayoutName, Text));
                            end;

                            trigger OnValidate()
                            begin
                                IF ColumnLayoutName = '' THEN
                                    ERROR(Text006);
                                AccSchedManagement.CheckColumnName(ColumnLayoutName);
                            end;
                        }
                    }
                    group(Filters)
                    {
                        CaptionML = ENU = 'Filters',
                                    FRA = 'Filtres';
                        field(DateFilters; DateFilter)
                        {
                            CaptionML = ENU = 'Date Filter',
                                        FRA = 'Filtre date';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                //IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
                                "Acc. Schedule Line".SETFILTER("Date Filter", DateFilter);
                                DateFilter := "Acc. Schedule Line".GETFILTER("Date Filter");
                            end;
                        }
                        field(GLBudgetFilter; GLBudgetFilter)
                        {
                            CaptionML = ENU = 'G/L Budget Filter',
                                        FRA = 'Filtre budget comptable';
                            TableRelation = "G/L Budget Name".Name;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SETFILTER("G/L Budget Filter", GLBudgetFilter);
                                GLBudgetFilter := "Acc. Schedule Line".GETFILTER("G/L Budget Filter");
                            end;
                        }
                        field(CostBudgetFilter; CostBudgetFilter)
                        {
                            CaptionML = ENU = 'Cost Budget Filter',
                                        FRA = 'Filtre de budget des coûts';
                            TableRelation = "Cost Budget Name".Name;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SETFILTER("Cost Budget Filter", CostBudgetFilter);
                                CostBudgetFilter := "Acc. Schedule Line".GETFILTER("Cost Budget Filter");
                            end;
                        }
                        field(BusinessUnitFilter; BusinessUnitFilter)
                        {
                            CaptionML = ENU = 'Business Unit Filter',
                                        FRA = 'Filtre centre de profit';
                            TableRelation = "Business Unit";
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                "Acc. Schedule Line".SETFILTER("Business Unit Filter", BusinessUnitFilter);
                                BusinessUnitFilter := "Acc. Schedule Line".GETFILTER("Business Unit Filter");
                            end;
                        }
                        field(IncludeSimulation; IncludeSimulation)
                        {
                            CaptionML = ENU = 'Include Simulation',
                                        FRA = 'Inclure simulation';
                            ApplicationArea = All;
                        }
                    }
                    group("Dimension Filters")
                    {
                        CaptionML = ENU = 'Dimension Filters',
                                    FRA = 'Filtres axe';
                        field(Dim1Filter; Dim1Filter)
                        {
                            CaptionClass = FormGetCaptionClass(1);
                            CaptionML = ENU = 'Dimension 1 Filter',
                                        FRA = 'Filtre axe 1';
                            Enabled = Dim1FilterEnable;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(FormLookUpDimFilter(AnalysisView."Dimension 1 Code", Text));
                            end;
                        }
                        field(Dim2Filter; Dim2Filter)
                        {
                            CaptionClass = FormGetCaptionClass(2);
                            CaptionML = ENU = 'Dimension 2 Filter',
                                        FRA = 'Filtre axe 2';
                            Enabled = Dim2FilterEnable;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(FormLookUpDimFilter(AnalysisView."Dimension 2 Code", Text));
                            end;
                        }
                        field(Dim3Filter; Dim3Filter)
                        {
                            CaptionClass = FormGetCaptionClass(3);
                            CaptionML = ENU = 'Dimension 3 Filter',
                                        FRA = 'Filtre axe 3';
                            Enabled = Dim3FilterEnable;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(FormLookUpDimFilter(AnalysisView."Dimension 3 Code", Text));
                            end;
                        }
                        field(Dim4Filter; Dim4Filter)
                        {
                            CaptionClass = FormGetCaptionClass(4);
                            CaptionML = ENU = 'Dimension 4 Filter',
                                        FRA = 'Filtre axe 4';
                            Enabled = Dim4FilterEnable;
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                EXIT(FormLookUpDimFilter(AnalysisView."Dimension 4 Code", Text));
                            end;
                        }
                        field(CostCenterFilter; CostCenterFilter)
                        {
                            CaptionML = ENU = 'Cost Center Filter',
                                        FRA = 'Filtre centre de coûts';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CostCenter: Record "Cost Center";
                            begin
                                EXIT(CostCenter.LookupCostCenterFilter(Text));
                            end;
                        }
                        field(CostObjectFilter; CostObjectFilter)
                        {
                            CaptionML = ENU = 'Cost Object Filter',
                                        FRA = 'Filtre coûts associés';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CostObject: Record "Cost Object";
                            begin
                                EXIT(CostObject.LookupCostObjectFilter(Text));
                            end;
                        }
                        field(CashFlowFilter; CashFlowFilter)
                        {
                            CaptionML = ENU = 'Cash Flow Filter',
                                        FRA = 'Filtre de trésorerie';
                            ApplicationArea = All;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                CashFlowForecast: Record "Cash Flow Forecast";
                            begin
                                EXIT(CashFlowForecast.LookupCashFlowFilter(Text));
                            end;
                        }
                    }
                    group(Show)
                    {
                        CaptionML = ENU = 'Show',
                                    FRA = 'Afficher';
                        field(ShowError; ShowError)
                        {
                            CaptionML = ENU = 'Show Error',
                                        FRA = 'Afficher erreur';
                            OptionCaptionML = ENU = 'None,Division by Zero,Period Error,Both',
                                              FRA = 'Aucune,Division par zéro,Erreur de période,Les deux';
                            ApplicationArea = All;
                        }
                        field(UseAmtsInAddCurr; UseAmtsInAddCurr)
                        {
                            CaptionML = ENU = 'Show Amounts in Add. Reporting Currency',
                                        FRA = 'Afficher montants en devise report';
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            Dim4FilterEnable := TRUE;
            Dim3FilterEnable := TRUE;
            Dim2FilterEnable := TRUE;
            Dim1FilterEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            GLSetup.GET();
            IF AccSchedName <> '' THEN
                ValidateAccSchedName();
            IF (GNomTabAnalyse <> '') AND /*(GNomColomn <> '') AND*/ (GDateFiltersFrom <> '') THEN BEGIN
                AccSchedName := GNomTabAnalyse;
                ColumnLayoutName := GNomColomn;
                EVALUATE(DateFilter, GDateFiltersFrom);
                DateFilter := DateFilter;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        TransferValues();
        UpdateFilters();
        InitAccSched();

        RecGCompanyInfo.GET();
        RecGCompanyInfo.CALCFIELDS(Picture);
        TXTADRESSE := RecGCompanyInfo.Address + ' ' + RecGCompanyInfo.City + ' ' + RecGCompanyInfo."Post Code";
    end;

    var
        SHowLogo: Boolean;
        ShowUserDate: Boolean;
        Text000: Label '(Thousands)';
        Text001: Label '(Millions)';
        Text002: Label '* ERROR *';
        Text003: Label 'All amounts are in %1.';
        AnalysisView: Record "Analysis View";
        GLSetup: Record "General Ledger Setup";
        AccSchedManagement: Codeunit AccSchedManagement;
        AccSchedName: Code[10];
        AccSchedNameHidden: Code[10];
        ColumnLayoutName: Code[10];
        ColumnLayoutNameHidden: Code[10];
        EndDate: Date;
        ShowError: Option "None","Division by Zero","Period Error",Both;
        DateFilter: Text[30];
        UseHiddenFilters: Boolean;
        DateFilterHidden: Text[30];
        GLBudgetFilter: Text[30];
        GLBudgetFilterHidden: Text[30];
        CostBudgetFilter: Text[30];
        CostBudgetFilterHidden: Text[30];
        BusinessUnitFilter: Text[30];
        BusinessUnitFilterHidden: Text[30];
        Dim1Filter: Text[250];
        Dim1FilterHidden: Text[250];
        Dim2Filter: Text[250];
        Dim2FilterHidden: Text[250];
        Dim3Filter: Text[250];
        Dim3FilterHidden: Text[250];
        Dim4Filter: Text[250];
        Dim4FilterHidden: Text[250];
        CostCenterFilter: Text[250];
        CostObjectFilter: Text[250];
        CashFlowFilter: Text[250];
        FiscalStartDate: Date;
        ColumnValuesDisplayed: Decimal;
        PeriodText: Text[30];
        AccSchedLineFilter: Text[250];
        Header: Text[30];
        RoundingHeader: Text[30];
        HasRounding: Boolean;
        UseAmtsInAddCurr: Boolean;
        ShowAccSchedSetup: Boolean;
        HeaderText: Text[100];
        Text004: Label 'Not Available';
        Text005: Label '1,6,,Dimension %1 Filter';
        Bold_AccScheduleLine: Boolean;
        Italic_AccScheduleLine: Boolean;
        Underline_AccScheduleLine: Boolean;
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        Text006: Label 'Enter the Column Layout Name.';
        IncludeSimulation: Boolean;
        [InDataSet]
        Dim1FilterEnable: Boolean;
        [InDataSet]
        Dim2FilterEnable: Boolean;
        [InDataSet]
        Dim3FilterEnable: Boolean;
        [InDataSet]
        Dim4FilterEnable: Boolean;
        LineShadowed: Boolean;
        LineSkipped: Boolean;
        ColumnLayoutNameCaptionLbl: Label 'Column Layout';
        AccScheduleNameCaptionLbl: Label 'Account Schedule';
        FiscalStartDateCaptionLbl: Label 'Fiscal Start Date';
        PeriodTextCaptionLbl: Label 'Period';
        CurrReportPageNoCaptionLbl: Label 'Page';
        AccScheduleCaptionLbl: Label 'Account Schedule';
        AnalysisViewCodeCaptionLbl: Label 'Analysis View';
        ShowOppSign_AccSchedLineSpecCaptionLbl: Label 'Show Opposite Sign';
        Underline_AccSchedLineSpecCaptionLbl: Label 'Underline';
        Italic_AccSchedLineSpecCaptionLbl: Label 'Italic';
        Bold_AccSchedLineSpecCaptionLbl: Label 'Bold';
        Show_AccSchedLineSpecCaptionLbl: Label 'Show';
        NewPage_AccSchedLineSpecCaptionLbl: Label 'New Page';
        TotalType_AccSchedLineSpecCaptionLbl: Label 'Totaling Type';
        Totaling_AccSchedLineSpecCaptionLbl: Label 'Totaling';
        Desc_AccSchedLineSpecCaptionLbl: Label 'Description';
        RowNo_AccSchedLineSpecCaptionLbl: Label 'Row No.';
        AnalysisViewDim1CodeCaptionLbl: Label 'Dimension Code';
        RowType_AccSchedLineSpecCaptionLbl: Label 'Row Type';
        AmtType_AccSchedLineSpecCaptionLbl: Label 'Amount Type';
        "//DELTA CHK 12032014": Integer;
        RecGCompanyInfo: Record "Company Information";
        Adress: Text;
        FiscalCode: Text;
        RegistreCommerce: Text;
        Paramcompta: Record "General Ledger Setup";
        DecGDebit: Decimal;
        totdeb: Decimal;
        totcred: Decimal;
        Tot: Decimal;
        ColumnValuesAsTextGL: Text[30];
        ColumnValuesAsText: Text[30];
        DecGDebitN: Decimal;
        TextePeriode: Text[30];
        totdebN: Decimal;
        totcredN: Decimal;
        TotN: Decimal;
        GlAccountN: Record "G/L Account";
        DATEDN: Date;
        DATEFN: Date;
        DATED: Date;
        DATEF: Date;
        PeriodTextN: Text;
        GLAccount: Record "G/L Account";
        AnneeExercice: Text;
        GNomColomn: Code[10];
        GNomTabAnalyse: code[10];
        GDateFiltersFrom: Text[50];
        TXTADRESSE: Text;

    procedure InitAccSched()
    var

        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";

    begin
        "Acc. Schedule Name".SETRANGE(Name, AccSchedName);
        "Acc. Schedule Line".SETFILTER("Date Filter", DateFilter);
        "Acc. Schedule Line".SETFILTER("G/L Budget Filter", GLBudgetFilter);
        "Acc. Schedule Line".SETFILTER("Cost Budget Filter", CostBudgetFilter);
        "Acc. Schedule Line".SETFILTER("Business Unit Filter", BusinessUnitFilter);
        "Acc. Schedule Line".SETFILTER("Dimension 1 Filter", Dim1Filter);
        "Acc. Schedule Line".SETFILTER("Dimension 2 Filter", Dim2Filter);
        "Acc. Schedule Line".SETFILTER("Dimension 3 Filter", Dim3Filter);
        "Acc. Schedule Line".SETFILTER("Dimension 4 Filter", Dim4Filter);
        "Acc. Schedule Line".SETFILTER("Cost Center Filter", CostCenterFilter);
        "Acc. Schedule Line".SETFILTER("Cost Object Filter", CostObjectFilter);
        "Acc. Schedule Line".SETFILTER("Cash Flow Forecast Filter", CashFlowFilter);

        EndDate := "Acc. Schedule Line".GETRANGEMAX("Date Filter");
        FiscalStartDate := AccountingPeriodMgt.FindFiscalYear(EndDate);

        AccSchedLineFilter := "Acc. Schedule Line".GETFILTERS;
        PeriodText := "Acc. Schedule Line".GETFILTER("Date Filter");
        AnneeExercice := '20' + COPYSTR(PeriodText, 7, 2);
        HasRounding := FALSE;
    end;


    procedure SetAccSchedName(NewAccSchedName: Code[10])
    begin
        AccSchedNameHidden := NewAccSchedName;
    end;


    procedure SetColumnLayoutName(ColLayoutName: Code[10])
    begin
        ColumnLayoutNameHidden := ColLayoutName;
    end;


    procedure SetFilters(NewDateFilter: Text[30]; NewBudgetFilter: Text[30]; NewCostBudgetFilter: Text[30]; NewBusUnitFilter: Text[30]; NewDim1Filter: Text[250]; NewDim2Filter: Text[250]; NewDim3Filter: Text[250]; NewDim4Filter: Text[250])
    begin
        DateFilterHidden := NewDateFilter;
        GLBudgetFilterHidden := NewBudgetFilter;
        CostBudgetFilterHidden := NewCostBudgetFilter;
        BusinessUnitFilterHidden := NewBusUnitFilter;
        Dim1FilterHidden := NewDim1Filter;
        Dim2FilterHidden := NewDim2Filter;
        Dim3FilterHidden := NewDim3Filter;
        Dim4FilterHidden := NewDim4Filter;
        UseHiddenFilters := TRUE;
    end;


    procedure ShowLine(Bold: Boolean; Italic: Boolean): Boolean
    begin
        IF "Acc. Schedule Line"."Totaling Type" = "Acc. Schedule Line"."Totaling Type"::"Set Base For Percent" THEN
            EXIT(FALSE);
        IF "Acc. Schedule Line".Show = "Acc. Schedule Line".Show::No THEN
            EXIT(FALSE);
        IF "Acc. Schedule Line".Bold <> Bold THEN
            EXIT(FALSE);
        IF "Acc. Schedule Line".Italic <> Italic THEN
            EXIT(FALSE);

        EXIT(TRUE);
    end;

    local procedure FormLookUpDimFilter(Dim: Code[20]; var Text: Text[1024]): Boolean
    var
        DimVal: Record "Dimension Value";
        DimValList: Page "Dimension Value List";
    begin
        IF Dim = '' THEN
            EXIT(FALSE);
        DimValList.LOOKUPMODE(TRUE);
        DimVal.SETRANGE("Dimension Code", Dim);
        DimValList.SETTABLEVIEW(DimVal);
        IF DimValList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            DimValList.GETRECORD(DimVal);
            Text := DimValList.GetSelectionFilter();
            EXIT(TRUE);
        END;
        EXIT(FALSE)
    end;

    local procedure FormGetCaptionClass(DimNo: Integer): Text[250]
    begin
        CASE DimNo OF
            1:
                BEGIN
                    IF AnalysisView."Dimension 1 Code" <> '' THEN
                        EXIT('1,6,' + AnalysisView."Dimension 1 Code");
                    EXIT(STRSUBSTNO(Text005, DimNo));
                END;
            2:
                BEGIN
                    IF AnalysisView."Dimension 2 Code" <> '' THEN
                        EXIT('1,6,' + AnalysisView."Dimension 2 Code");
                    EXIT(STRSUBSTNO(Text005, DimNo));
                END;
            3:
                BEGIN
                    IF AnalysisView."Dimension 3 Code" <> '' THEN
                        EXIT('1,6,' + AnalysisView."Dimension 3 Code");
                    EXIT(STRSUBSTNO(Text005, DimNo));
                END;
            4:
                BEGIN
                    IF AnalysisView."Dimension 4 Code" <> '' THEN
                        EXIT('1,6,' + AnalysisView."Dimension 4 Code");
                    EXIT(STRSUBSTNO(Text005, DimNo));
                END;
        END;
    end;

    local procedure TransferValues()
    begin
        GLSetup.GET();
        IF AccSchedNameHidden <> '' THEN
            AccSchedName := AccSchedNameHidden;
        IF ColumnLayoutNameHidden <> '' THEN
            ColumnLayoutName := ColumnLayoutNameHidden;

        IF AccSchedName <> '' THEN
            IF NOT "Acc. Schedule Name".GET(AccSchedName) THEN
                AccSchedName := '';
        IF AccSchedName = '' THEN
            IF "Acc. Schedule Name".FINDFIRST() THEN
                AccSchedName := "Acc. Schedule Name".Name;

        IF "Acc. Schedule Name"."Analysis View Name" <> '' THEN
            AnalysisView.GET("Acc. Schedule Name"."Analysis View Name")
        ELSE BEGIN
            AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
            AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
        END;
    end;

    local procedure UpdateFilters()
    begin
        IF UseHiddenFilters THEN BEGIN
            DateFilter := DateFilterHidden;
            GLBudgetFilter := GLBudgetFilterHidden;
            CostBudgetFilter := CostBudgetFilterHidden;
            BusinessUnitFilter := BusinessUnitFilterHidden;
            Dim1Filter := Dim1FilterHidden;
            Dim2Filter := Dim2FilterHidden;
            Dim3Filter := Dim3FilterHidden;
            Dim4Filter := Dim4FilterHidden;
        END;
    end;


    procedure ValidateAccSchedName()
    var
        FinancialReport: Record "Financial Report";
    begin
        AccSchedManagement.CheckName(AccSchedName);
        "Acc. Schedule Name".GET(AccSchedName);
        If FinancialReport.Get("Acc. Schedule Name".Name) then begin
            IF FinancialReport."Financial Report Column Group" <> '' THEN
                ColumnLayoutName := FinancialReport."Financial Report Column Group";
        end;
        IF "Acc. Schedule Name"."Analysis View Name" <> '' THEN
            AnalysisView.GET("Acc. Schedule Name"."Analysis View Name")
        ELSE BEGIN
            CLEAR(AnalysisView);
            AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
            AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
        END;
        Dim1FilterEnable := AnalysisView."Dimension 1 Code" <> '';
        Dim2FilterEnable := AnalysisView."Dimension 2 Code" <> '';
        Dim3FilterEnable := AnalysisView."Dimension 3 Code" <> '';
        Dim4FilterEnable := AnalysisView."Dimension 4 Code" <> '';
    end;

    procedure GetInformationFromAccScheduleOverview(lNomTabAnalyse: Code[10]; lNomColomn: Code[10]; lDateFiltersFrom: Text[50])
    var
    begin
        GNomTabAnalyse := lNomTabAnalyse;
        GNomColomn := lNomColomn;
        GDateFiltersFrom := lDateFiltersFrom;
    end;


}

