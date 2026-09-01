pageextension 70027 "Payment Step Card PagExt" extends "Payment Step Card" //10867
{
    layout
    {
        addlast(Control1)
        {
            field("STCode Coffre"; Rec."STCode Coffre")
            {
                ApplicationArea = All;
            }
            field("STTiré Oblig."; Rec."STTiré Oblig.")
            {
                ToolTip = 'Specifies the value of the Tiré obligatoire field';
                ApplicationArea = All;
            }

            field("STCode Journal Ligne"; Rec."STCode Journal Ligne")
            {
                ToolTip = 'Specifies the value of the Code journal ligne field';
                ApplicationArea = All;
            }
            field(STCode_Motif_Obligatoir; Rec.STCode_Motif_Obligatoir)
            {
                ToolTip = 'Specifies the value of the Code motif obligatoire field';
                ApplicationArea = All;
            }

            field(STAgent_Remis_Obligatoire; Rec.STAgent_Remis_Obligatoire)
            {
                ToolTip = 'Specifies the value of the Agent remis obligatoire field';
                ApplicationArea = All;
            }
            field("STBanque Entête Obligatoire"; Rec."STBanque Entête Obligatoire")
            {
                ToolTip = 'Specifies the value of the Banque entête obligatoire field';
                ApplicationArea = All;
            }


        }
        modify(Line)
        {
            Editable = true;
        }
    }

    actions
    {
    }
}