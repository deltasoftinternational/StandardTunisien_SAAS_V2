tableextension 70004 "ST PurchaseHeaderTabExt" extends "Purchase Header" //38
{
    fields
    {
        field(70006; "STApply Stamp Fiscal"; Boolean)
        {
            CaptionML = FRA = 'Appliquer timbre fiscal';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                lVendorPostingGroup: Record "Vendor Posting Group";
            begin
                if "STApply Stamp Fiscal" = false then
                    "STStamp Fiscal Amount" := 0
                ELSE BEGIN
                    lVendorPostingGroup.GET("Vendor Posting Group");
                    IF lVendorPostingGroup."STApply Stamp Fiscal" THEN
                        "STStamp Fiscal Amount" := lVendorPostingGroup."STStamp Fiscal Amount";
                end;
            end;
        }
        field(70001; "STStamp Fiscal Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant timbre';
            DataClassification = ToBeClassified;
        }


    }

}