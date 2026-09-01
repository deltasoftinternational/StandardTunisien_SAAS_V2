table 71008 "STSituationPaiement"
{
    Caption = 'ST Situation Paiement';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    procedure InitDefaultSetup()
    var
        LrecSitPaiement: record STSituationPaiement;
    begin
        LrecSitPaiement.Init();
        LrecSitPaiement.Code := 'CLT_CHQCOF';
        LrecSitPaiement.Description := 'Chèque en coffre';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Init();
        LrecSitPaiement.Code := 'CLT_CHQIMP';
        LrecSitPaiement.Description := 'Chèque Impayé';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_CHQCONT';
        LrecSitPaiement.Description := 'Chèque contentieux';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_CHQENCV';
        LrecSitPaiement.Description := 'Chèque encours de versement';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTCOF';
        LrecSitPaiement.Description := 'Traite en coffre';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTREMENC';
        LrecSitPaiement.Description := 'Traite Remise à l''encaissement';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTENCENC';
        LrecSitPaiement.Description := 'Traite encours d''encaissement';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTREMESC';
        LrecSitPaiement.Description := 'Traite remise à l''escompte';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTENCESC';
        LrecSitPaiement.Description := 'Traite encours d''escompte';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTIMP';
        LrecSitPaiement.Description := 'Traite impayée';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'CLT_TRTCONT';
        LrecSitPaiement.Description := 'Traite Contentieux';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'FRS_TRTREM';
        LrecSitPaiement.Description := 'Traite remise fournisseur';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'FRS_TRTENC';
        LrecSitPaiement.Description := 'Traite encours fournisseur';
        if LrecSitPaiement.Insert() then;
        LrecSitPaiement.Code := 'FRS_CHQENC';
        LrecSitPaiement.Description := 'Chèque encours fournisseur';
        if LrecSitPaiement.Insert() then;





    end;

}
