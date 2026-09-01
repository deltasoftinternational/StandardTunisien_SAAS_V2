tableextension 71023 "ST Acc.ScheduleLineTabExt" extends "Acc. Schedule Line" //85
{
    fields
    {
        field(71000; "STTotalisation debiteur"; Text[250])
        {
            Caption = 'Totalisation débiteur';

            trigger OnValidate()
            begin
                CASE "Totaling Type" OF
                    "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts":
                        // begin
                        //     CpteGL.Reset();
                        //     CpteGL.SETFILTER("No.", "STTotalisation debiteur");
                        //     if CpteGL.FindFirst() then
                        //         CpteGL.CALCFIELDS("Debit Amount");
                        //     //      CpteGL.CALCFIELDS("Debit Amount");
                        // end;
                        CpteGL.CALCFIELDS(Balance);
                    "Totaling Type"::Formula:
                        LigTabAna.SETFILTER(LigTabAna."Row No.", LigTabAna.Totaling);
                END;
            End;
        }
        field(71001; "STTotalisation Crediteur"; Text[250])
        {
            Caption = 'Totalisation créditeur';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CASE "Totaling Type" OF
                    "Totaling Type"::"Posting Accounts", "Totaling Type"::"Total Accounts":
                        // begin
                        //     CpteGL.Reset();
                        //     CpteGL.SETFILTER("No.", "STTotalisation Crediteur");
                        //     if CpteGL.FindFirst() then
                        //         CpteGL.CALCFIELDS("Credit Amount");
                        // end;
                        CpteGL.CALCFIELDS(Balance);
                    "Totaling Type"::Formula:
                        LigTabAna.SETFILTER(LigTabAna."Row No.", LigTabAna.Totaling);
                END;
            End;
        }
        field(71002; STNote; Code[10])
        {
            Caption = 'Note';
            DataClassification = ToBeClassified;

        }

    }
    var

        CpteGL: Record "G/L Account";

        LigTabAna: Record "Acc. Schedule Line";
}


