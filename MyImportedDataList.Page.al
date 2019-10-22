page 50100 "My Imported Data List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "My Imported Data";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Column 1"; "Column 1")
                {
                    ApplicationArea = All;
                }
                field("Column 2"; "Column 2")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteAll)
            {
                ApplicationArea = All;
                Image = Delete;

                trigger OnAction();
                begin
                    DeleteAll();
                end;
            }
        }
    }
}