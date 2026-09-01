pageextension 71019 "ST PaymentLinesListPagExt" extends "Payment Lines List" //10872
{
    layout
    {
        modify("Drawee Reference")
        {
            Visible = false;
        }

        addafter("Acceptation Code")
        {

            field("Copied To No."; Rec."Copied To No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
            field("STEn Banque"; Rec."STEn Banque")
            {
                ApplicationArea = all;
            }
            field(Libellé; Rec."STLibellé")
            {
                ApplicationArea = all;
            }

            field("Banque Societe"; rec."Banque Societe")
            {
                ApplicationArea = all;
            }
            field("STDrawee Reference1"; Rec."STDrawee Reference1")
            {
                ApplicationArea = all;
            }
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field(Coffre; Rec.STCoffre)
            {
                ApplicationArea = all;
            }
            field("Coffre Origine"; Rec."STCoffre Origine")
            {
                ApplicationArea = all;
            }
            field("Created from No."; Rec."Created from No.")
            {
                ApplicationArea = all;
            }
            field("Bank Account Code"; Rec."Bank Account Code")
            {
                ApplicationArea = all;
            }


        }
        addlast(content)
        {
            group(tt)
            {
                Caption = '';
                field(SumSelect; SumSelect)
                {
                    Caption = 'Amount Select';
                    Editable = false;
                    ApplicationArea = All;


                }
            }
        }
    }




    trigger OnAfterGetCurrRecord()
    begin
        //<< DELTA 01
        GPaymentLine.RESET();
        CLEAR(GPaymentLine);
        SumSelect := 0;
        CurrPage.SetSelectionFilter(GPaymentLine);
        GPaymentLine.CalcSums("Amount (LCY)");
        SumSelect := GPaymentLine."Amount (LCY)";

        //>> DELTA 01
    end;

    trigger OnOpenPage()
    Var
        RecRisqueClientSetup: Record STSetupRisqueClientFrs;
    begin
        IF UserSetup.GET(UPPERCASE(USERID)) THEN
            IF UserSetup.STCoffre <> '' THEN BEGIN
                If RecRisqueClientSetup.Get() Then;
                if (rec.GetFilter(STCodeSituationPaiement) = RecRisqueClientSetup.CltTraiteImpaye) and UserSetup."ST Show All Unpaid Traite" then
                    exit;
                Rec.FILTERGROUP(2);
                Rec.SETRANGE(STCoffre, UserSetup.STCoffre);
                Rec.FILTERGROUP(0);
            END;


        // CurrPage.UPDATE;
    end;


    var
        Steps: Integer;
        PayNum: Code[20];
        UserSetup: Record "User Setup";
        SumSelect: Decimal;

        GPaymentLine: Record "Payment Line";




    procedure SetSteps(Step: Integer)
    begin
        Steps := Step;
    end;


    procedure SetNumBor(N: Code[20])
    begin
        PayNum := N;
    end;


    procedure GetNumBor() N: Code[20]
    begin
        N := PayNum;
    end;


}

