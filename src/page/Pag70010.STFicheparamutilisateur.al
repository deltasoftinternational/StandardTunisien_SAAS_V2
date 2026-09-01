page 70010 "STFiche param utilisateur"
{
    Caption = 'Fiche Param utilisateur';
    PageType = Card;
    SourceTable = "User Setup";
    ApplicationArea = All;
    //UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Général")
            {
                field("User ID"; Rec."User ID")
                {
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                }

                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                }
                field("Sales Resp. Ctr. Filter"; Rec."Sales Resp. Ctr. Filter")
                {
                }
                field("Purchase Resp. Ctr. Filter"; Rec."Purchase Resp. Ctr. Filter")
                {
                }

                field("Service Resp. Ctr. Filter"; Rec."Service Resp. Ctr. Filter")
                {
                }

                field("Time Sheet Admin."; Rec."Time Sheet Admin.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Email; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(PhoneNo; Rec."Phone No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ST Modif Post. grp. on Sales"; Rec."ST Modif Post. grp. on Sales")
                {
                    ApplicationArea = all;
                }
                field("ST Show All Unpaid Traite"; Rec."ST Show All Unpaid Traite")
                {
                    ApplicationArea = All;
                }
                field("ST Admin Payment Slip"; Rec."ST Admin Payment Slip")
                {
                    ApplicationArea = all;
                }

            }

            group(Banque)
            {
                Caption = 'Banque';
                field(Coffre; Rec.STCoffre)
                {
                    ApplicationArea = All;
                }

                field("caisse-Depense-par defaut"; Rec."STcaisse-Depense-par defaut")
                {
                    ApplicationArea = All;
                }
                field("caisse-Recette-par defaut"; Rec."STcaisse-Recette-par defaut")
                {
                    ApplicationArea = All;

                }
                field("ST modify caisse depense"; Rec."ST modify caisse depense")
                {
                    ApplicationArea = All;

                }
                field("ST modify commission"; Rec."ST modify commission")
                {
                    ApplicationArea = All;

                }
                field("ST View All Bank Account"; Rec."ST View All Bank Account")
                {
                    ToolTip = 'Visualiser tous les compte bancaire.';
                    ApplicationArea = all;
                }
            }
            part("Accés Banques par Utilisateurs"; "ST User Banks")
            {
                Caption = 'Accés Banques par Utilisateurs';
                SubPageLink = "ST User ID" = FIELD("User ID");
            }
        }
    }

    actions
    {
    }

    var
        InventoryPostingGroup: Record "Inventory Posting Group";
}

