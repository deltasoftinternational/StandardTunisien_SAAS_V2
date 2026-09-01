tableextension 71039 "STVendor Bank Account" extends "Vendor Bank Account" //288
{
    fields
    {
        field(71000; "STNote"; Text[100])
        {
            Caption = 'Note';
        }
        modify("Agency Code")
        {
            trigger OnAfterValidate()
            var
                IsHandled: Boolean;
            begin
                OnBeforecheckAgencyCodeLength(Rec, IsHandled);
                if not IsHandled then
                    "Agency Code" := CopyStr("Agency Code", 3, 3);
            end;
        }
    }
    [IntegrationEvent(false, false)]
    local procedure OnBeforecheckAgencyCodeLength(var Rec: Record "Vendor Bank Account"; var IsHandled: Boolean)
    begin
    end;
}