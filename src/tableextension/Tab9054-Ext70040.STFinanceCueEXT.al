tableextension 71040 "ST FinanceCue EXT" extends "Finance Cue" //9054
{
    fields
    {
        field(70000; "TotalChequeEnCoffre"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_CHQCOF'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Chèques En Coffre';
            FieldClass = FlowField;
        }
        field(70001; "TotalChequeImpayé"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_CHQIMP'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                    ));
            Caption = 'Chèques Impayés';
            FieldClass = FlowField;
        }
        field(70003; "TotalChequecontentieux"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''), STCodeSituationPaiement = filter('CLT_CHQCONT'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                   ));
            Caption = 'Chèques contentieux';
            FieldClass = FlowField;
        }
        field(70004; "TotalChequeEncoursVersement"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_CHQENCV'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                       ));
            Caption = 'Chèques Encours De Versement';
            FieldClass = FlowField;
        }
        field(70005; "TotalTraiteEnCoffre"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_TRTCOF'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                   ));
            Caption = 'Traites En Coffre';
            FieldClass = FlowField;
        }
        field(70006; "Traite encours d'encaissement"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_TRTENCENC'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Traites Encours D''encaissement';
            FieldClass = FlowField;
        }
        field(70007; "Traite encours escompte"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_TRTENCESC'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                             ));
            Caption = 'Traites encours d''escompte';
            FieldClass = FlowField;
        }
        field(70008; "Traite Impayee"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT_TRTIMP'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Traites Impayées';
            FieldClass = FlowField;
        }
        field(70009; "Cheque Preavise"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT-CHQ-PREAV'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Chèques Préavisés';
            FieldClass = FlowField;
        }
        field(70010; "Cheque encours fournisseur"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('FRS_CHQENC'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = ' Chèques encours fournisseur';
            FieldClass = FlowField;
        }
        field(70011; "Traite encours fournisseur"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('FRS_TRTENC'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Traites Encours Fournisseur';
            FieldClass = FlowField;
        }
        field(70012; "Traite remis au fournisseur"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('FRS_TRTREM'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Traites Remis Au Fournisseur';
            FieldClass = FlowField;
        }
        field(70016; "Cheque verse en banque"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT-CHQREM'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Chèques versés en banque';
            FieldClass = FlowField;
        }
        field(70017; "Cheque Encaisse en banque"; Decimal)
        {
            CalcFormula = - Sum("Payment Line".Amount where("Copied To No." = filter(''),
                                                            STCodeSituationPaiement = filter('CLT-CHQ-ENCB'),
                                                            STCoffre = field("Coffre utilisateur")
                                                                                 ));
            Caption = 'Chèques Encaissés en banque';
            FieldClass = FlowField;
        }
        field(70013; "Sales Documents Due Today"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Document Type" = FILTER(Invoice | "Credit Memo"),
                                                             "Due Date" = FIELD("Due Date Filter"),
                                                               Open = CONST(true)));
            CaptionML = ENU = 'Sales Documents Due Today', FRA = 'Documents vente arrivant à échéance aujourd’hui';
            FieldClass = FlowField;
        }

        field(70014; "Total Montant caisse Depense"; Decimal)
        {

        }
        field(70015; "Total Montant caisse recette"; Decimal)
        {

        }

        field(70020; "Coffre utilisateur"; code[20])
        {
            FieldClass = FlowFilter;
        }


    }


}