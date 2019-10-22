codeunit 50100 "Process Excel Import"
{
    var
        NoRecordsErr: Label 'There is no records to be processed.';

    procedure ProcessExcelImport(var ExcelBuffer: Record "Excel Buffer");
    var
        MyImportedData: Record "My Imported Data";
    begin
        if ExcelBuffer.IsEmpty() then
            Error(NoRecordsErr);

        if ExcelBuffer.FindSet() then
            repeat
                case ExcelBuffer.xlColID of
                    'A':
                        begin
                            MyImportedData.Init();
                            MyImportedData."Entry No." := 0;
                            MyImportedData."Column 1" := ExcelBuffer."Cell Value as Text";
                        end;
                    'B':
                        begin
                            MyImportedData."Column 2" := ExcelBuffer."Cell Value as Text";
                            MyImportedData.Insert(true);
                        end;
                end;
            until ExcelBuffer.Next() = 0;
    end;
}