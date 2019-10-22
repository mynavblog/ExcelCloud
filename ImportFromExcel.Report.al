report 50100 "Import From Excel"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Import From Excel';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FileInformation)
                {
                    Caption = 'Excel Parameters';
                    field(Name; FileName)
                    {
                        Caption = 'Choose File';
                        ApplicationArea = All;
                        Editable = false;
                        AssistEdit = true;
                        trigger OnAssistEdit()
                        begin
                            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
                            FileExt := FileManagement.GetExtension(FileName);
                            if (FileName = '') or (not TempBlob.HasValue()) or not (FileExt in ['xlsx', 'xls']) then begin
                                FileName := '';
                                Error(FileNameErr);
                            end;

                            TempBlob.CreateInStream(ImportedInStream);
                        end;
                    }
                    field(SheetNameField; SheetName)
                    {
                        Caption = 'Choose Sheet Name';
                        ApplicationArea = All;
                        Editable = false;
                        trigger OnAssistEdit()
                        begin
                            if (FileName = '') or (not TempBlob.HasValue()) then
                                Error(FileNameErr);
                            SheetName := TempExcelBuffer.SelectSheetsNameStream(ImportedInStream);
                        end;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
            FileExt := FileManagement.GetExtension(FileName);
            if (FileName = '') or (not TempBlob.HasValue()) or not (FileExt in ['xlsx', 'xls']) then begin
                FileName := '';
                Message(FileNameErr);
            end else
                TempBlob.CreateInStream(ImportedInStream);
        end;
    }
    trigger OnPreReport()
    var
        ProcessExcelImport: Codeunit "Process Excel Import";
    begin
        TempExcelBuffer.OpenBookStream(ImportedInStream, SheetName);
        TempExcelBuffer.ReadSheetContinous(SheetName, true);
        ProcessExcelImport.ProcessExcelImport(TempExcelBuffer);
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        ImportedInStream: InStream;
        FileName: Text;
        FileExt: Text;
        SheetName: Text;
        FileNameErr: Label 'Please choose proper file';
        FileDialogTxt: Label 'Import (%1)|%1';
        ImportTxt: Label 'Import Excel File';
        FilterTxt: Label '*.xlsx;*.xls;*.*', Locked = true;
}