let
    Source = Excel.Workbook(File.Contents(MEPSDataFolder & "h249.xlsx"), null, true),
    H249_Sheet = Source{[Item="H249",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(H249_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"DUID", Int64.Type}, {"PID", Int64.Type}, {"DUPERSID", Int64.Type}, {"CONDN", Int64.Type}, {"CONDIDX", Int64.Type}, {"PANEL", Int64.Type}, {"CONDRN", Int64.Type}, {"AGEDIAG", Int64.Type}, {"CRND1", Int64.Type}, {"CRND2", Int64.Type}, {"CRND3", Int64.Type}, {"CRND4", Int64.Type}, {"CRND5", Int64.Type}, {"INJURY", Int64.Type}, {"ACCDNWRK", Int64.Type}, {"ICD10CDX", type text}, {"CCSR1X", type text}, {"CCSR2X", type text}, {"CCSR3X", type text}, {"CCSR4X", type text}, {"HHCOND", Int64.Type}, {"IPCOND", Int64.Type}, {"OPCOND", Int64.Type}, {"OBCOND", Int64.Type}, {"ERCOND", Int64.Type}, {"RXCOND", Int64.Type}, {"PERWT23F", type number}, {"VARSTR", Int64.Type}, {"VARPSU", Int64.Type}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"DUID", "PID", "DUPERSID", "CONDIDX", "RXCOND", "ICD10CDX", "CCSR1X"})
in
    #"Removed Other Columns"
