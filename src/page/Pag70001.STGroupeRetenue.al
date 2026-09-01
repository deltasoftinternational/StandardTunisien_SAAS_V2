page 71001 "ST Groupe Retenue"
{
    PageType = List;
    SourceTable = "ST Groupe retenue";
    UsageCategory = Lists;
    Caption = 'Groupe Retenue';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(STCode; Rec.STCode)
                {
                    ToolTip = 'Specifies the value of the Code field';
                    ApplicationArea = All;
                }
                field("ST% Retenue"; Rec."ST% Retenue")
                {
                    ToolTip = 'Specifies the value of the % Retenue field';
                    ApplicationArea = All;
                }
                field("STActivé"; Rec."STActivé")
                {
                    ToolTip = 'Specifies the value of the Activé field';
                    ApplicationArea = All;
                }
                field(STAnnexe; Rec.STAnnexe)
                {
                    ToolTip = 'Specifies the value of the Annexe field';
                    ApplicationArea = All;
                }
                field("STCompte Retenue"; Rec."STCompte Retenue")
                {
                    ToolTip = 'Specifies the value of the Compte retenue field';
                    ApplicationArea = All;
                }
                field(STDesignation; Rec.STDesignation)
                {
                    ToolTip = 'Specifies the value of the Désignation field';
                    ApplicationArea = All;
                }
                field("STPos. mnt Brut Dans Annexe"; Rec."STPos. mnt Brut Dans Annexe")
                {
                    ToolTip = 'Specifies the value of the Pos. mnt brut dans annexe field';
                    ApplicationArea = All;
                }
                field(STProposition; Rec.STProposition)
                {
                    ToolTip = 'Specifies the value of the Proposition field';
                    ApplicationArea = All;
                }
                field(STRistourne; Rec.STRistourne)
                {
                    ToolTip = 'Specifies the value of the Ristourne field';
                    ApplicationArea = All;
                }
                field("STSous Pos Mnt Brut ds Annexe"; Rec."STSous Pos Mnt Brut ds Annexe")
                {
                    ToolTip = 'Specifies the value of the Sous pos mnt brut ds annexe field';
                    ApplicationArea = All;
                }
                field("STType Retenue"; Rec."STType Retenue")
                {
                    ToolTip = 'Specifies the value of the Type retenue field';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

