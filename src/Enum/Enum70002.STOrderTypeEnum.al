enum 70002 "ST Order Type Enum"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';

    }
    value(1; "Sales orders")
    {
        Caption = 'Commandes ventes';
    }
    value(2; "Purchase Orders")
    {
        Caption = 'Commandes achats';
    }
    value(3; "Sales Blanket Order")
    {
        Caption = 'Commandes ouverte';
    }
}