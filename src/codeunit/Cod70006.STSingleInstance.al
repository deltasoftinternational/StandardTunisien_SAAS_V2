codeunit 71006 "STSingleInstance"
{
    SingleInstance = true;


    procedure GetSourceNoSerieByCoffre(VAR pCoffre: Code[20]): Boolean
    begin
        IF (Coffre = '') THEN
            EXIT(FALSE);

        pCoffre := Coffre;

        EXIT(TRUE);
    end;

    procedure SetSourceNoSerieByCoffre(pCoffre: Code[20])
    begin
        Coffre := pCoffre;
    end;

    procedure GetAppliesToInvNos(VAR pAppliesToInvNos: Code[1024]): Boolean
    begin
        IF (AppliesToInvNos = '') THEN
            EXIT(FALSE);

        pAppliesToInvNos := AppliesToInvNos;

        EXIT(TRUE);
    end;

    procedure GetAppliesToDocNos(VAR pAppliesToDocNos: Code[2048]): Boolean
    begin
        IF (AppliesToDocNos = '') THEN
            EXIT(FALSE);

        pAppliesToDocNos := AppliesToDocNos;

        EXIT(TRUE);
    end;

    procedure SetAppliesToInvNos(pAppliesToInvNos: Code[1024])
    begin
        AppliesToInvNos := pAppliesToInvNos;

    end;

    procedure SetAppliesToDocNos(pAppliesToDocNos: Code[2048])
    begin
        AppliesToDocNos := pAppliesToDocNos;

    end;

    var
        Coffre: Code[20];
        AppliesToInvNos: Code[1024];
        AppliesToDocNos: Code[2048];
}


