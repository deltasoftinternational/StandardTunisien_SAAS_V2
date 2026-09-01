tableextension 71021 "ST ItemChargeTabExt" extends "Item Charge" //5800
{
    fields
    {
        field(71000; "ST Not Assignable"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Non Affectable';
            trigger OnValidate()
            var
                ValueEntry: Record "Value Entry";
                PurchReceiptLine: Record "Purch. Rcpt. Line";
                PurchInvLine: Record "Purch. Inv. Line";
                PurchCreditMemoLine: Record "Purch. Cr. Memo Line";
                Text001: Label 'Vous ne pouvez pas modifier %1 car il existe des écritures valeurs associées à ce frais.';
                Text002: Label 'Vous ne pouvez pas modifier %1 car il existe des documents enregistrées associés à ce frais.';
            Begin
                If xRec."ST Not Assignable" = false and rec."ST Not Assignable" = true then Begin
                    ValueEntry.SETCURRENTKEY("Item Charge No.", "Inventory Posting Group", "Item No.");
                    ValueEntry.SetRange("Item Charge No.", rec."No.");
                    IF NOT ValueEntry.ISEMPTY THEN
                        ERROR(Text001, rec."No.");

                end;

                If xRec."ST Not Assignable" = true and rec."ST Not Assignable" = false then Begin
                    PurchReceiptLine.SetCurrentKey(Type, "No.");
                    PurchReceiptLine.SetRange(Type, PurchReceiptLine.type::"Charge (Item)");
                    PurchReceiptLine.SetRange("No.", rec."No.");
                    IF NOT PurchReceiptLine.ISEMPTY THEN
                        ERROR(Text002, rec."No.");

                    PurchInvLine.SetCurrentKey(Type, "No.");
                    PurchInvLine.SetRange(Type, PurchInvLine.type::"Charge (Item)");
                    PurchInvLine.SetRange("No.", rec."No.");
                    IF NOT PurchInvLine.ISEMPTY THEN
                        ERROR(Text002, rec."No.");

                    PurchCreditMemoLine.SetCurrentKey(Type, "No.");
                    PurchCreditMemoLine.SetRange(Type, PurchReceiptLine.type::"Charge (Item)");
                    PurchCreditMemoLine.SetRange("No.", rec."No.");
                    IF NOT PurchCreditMemoLine.ISEMPTY THEN
                        ERROR(Text002, rec."No.");
                end;


            End;


        }


    }

}