table 50100 "My Imported Data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Column 1"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Column 1';
        }
        field(3; "Column 2"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Column 1';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }


}