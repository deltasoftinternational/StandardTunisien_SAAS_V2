tableextension 71029 "ST Purchase Line EXT" extends "Purchase Line"//39
{
    fields
    {
        field(71000; Fodec; Boolean)
        {
            Caption = 'Fodec';
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                if FODEC = true then begin
                    PurchSetup.GET();
                    PurchSetup.TESTFIELD("Taux Fodec");
                    "Taux Fodec" := PurchSetup."Taux Fodec";
                    "Montant Fodec" := ("Line Amount" * "Taux Fodec") / 100;
                end
                else begin
                    Clear("Taux Fodec");
                    Clear("Montant Fodec");
                end;
            end;
        }
        field(71001; "Taux Fodec"; Decimal)
        {
            Caption = 'Taux FODEC';
            DataClassification = ToBeClassified;
        }
        field(71002; "Montant Fodec"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(71003; "Fodec Amount"; Decimal)
        // {
        //     CaptionML = ENU = 'Fodec Amount',
        //                 FRA = 'Montant Fodec';
        // }
        // field(71004; "Fodec Amount Including VAT"; Decimal)
        // {
        //     CaptionML = ENU = 'Fodec Amount Including VAT',
        //                 FRA = 'Montant TTC Fodec';
        // }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Paramach.GET();
                GrpFrs.RESET();
                PurchHeader.Reset();
                Frs.RESET();
                Sect.RESET();
                Item.Reset();
                IF Paramach."Activer Fodec" THEN
                    if PurchHeader.get("Document Type", rec."Document No.") then
                        if GrpFrs.get(PurchHeader."Vendor Posting Group") then
                            IF GrpFrs."STApply FODEC" THEN
                                if Item.get("No.") then
                                    validate(Fodec, Item.Fodec);
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Paramach.GET();
                GrpFrs.RESET();
                PurchHeader.Reset();
                Frs.RESET();
                Sect.RESET();
                Item.Reset();
                IF Paramach."Activer Fodec" THEN
                    if PurchHeader.get("Document Type", rec."Document No.") then
                        if GrpFrs.get(PurchHeader."Vendor Posting Group") then
                            IF GrpFrs."STApply FODEC" THEN
                                if Item.get("No.") then
                                    validate(Fodec, Item.Fodec);
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Paramach.GET();
                GrpFrs.RESET();
                PurchHeader.Reset();
                Frs.RESET();
                Sect.RESET();
                Item.Reset();
                IF Paramach."Activer Fodec" THEN
                    if PurchHeader.get("Document Type", rec."Document No.") then
                        if GrpFrs.get(PurchHeader."Vendor Posting Group") then
                            IF GrpFrs."STApply FODEC" THEN
                                if Item.get("No.") then
                                    validate(Fodec, Item.Fodec);
                if Fodec = true then begin
                    PurchSetup.GET();
                    PurchSetup.TESTFIELD("Taux Fodec");
                    "Taux Fodec" := PurchSetup."Taux Fodec";
                end
                else
                    Clear("Taux Fodec");
            end;
        }


    }
    var
        Paramach: Record "Purchases & Payables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GrpFrs: Record "Vendor Posting Group";
        Frs: Record Vendor;
        Sect: Record Territory;
        PurchHeader: Record "Purchase Header";
        Item: Record Item;
}