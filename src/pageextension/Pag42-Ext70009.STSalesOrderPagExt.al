pageextension 70009 "ST SalesOrderPagExt" extends "Sales Order" //42
{
    layout
    {

        addlast("Invoice Details")
        {
            field("Stamp Amount"; Rec."STStamp Amount")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Apply Stamp Fiscal"; Rec."STApply Stamp Fiscal")
            {
                ApplicationArea = All;
            }
            field("STImpayeMnt"; Rec."STImpayeMnt")
            {
                ApplicationArea = All;
                Visible = false; // affichage dans l'extention du client final avec le traitement dédié
            }


        }

    }
    actions
    {
        addafter("Archive Document")
        {
            action(UpdateGrpCompte)
            {
                ApplicationArea = All;
                Caption = 'Mofier groupe compta Commande & Expédition';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ModifGroupIsVisible;
                Image = RefreshVATExemption;

                trigger OnAction()
                Var
                    LSalesHeader: Record "Sales Header";
                    UpdateSalesDocsPostGrps: Report "Update Sales Docs Post. Grps.";
                    UserSetup: Record "User Setup";
                begin


                    UserSetup.GET(USERID);
                    UserSetup.TESTFIELD("ST Modif Post. grp. on Sales");
                    LSalesHeader.RESET();
                    LSalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    LSalesHeader.SETRANGE("No.", Rec."No.");
                    CLEAR(UpdateSalesDocsPostGrps);
                    UpdateSalesDocsPostGrps.SETTABLEVIEW(LSalesHeader);
                    UpdateSalesDocsPostGrps.RUNMODAL();

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        Lusersetup: Record "User Setup";
    begin
        if Lusersetup.Get() then
            ModifGroupIsVisible := Lusersetup."ST Modif Post. grp. on Sales";
    end;

    var
        ModifGroupIsVisible: Boolean;

}