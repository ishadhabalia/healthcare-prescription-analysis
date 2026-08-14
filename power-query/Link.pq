let
    Source = Excel.Workbook(File.Contents(MEPSDataFolder & "h248if1.xlsx"), null, true),
    H248IF1_Sheet = Source{[Item="H248IF1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(H248IF1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"DUPERSID", Int64.Type}, {"CONDIDX", Int64.Type}, {"EVNTIDX", Int64.Type}, {"CLNKIDX", type number}, {"EVENTYPE", Int64.Type}, {"PANEL", Int64.Type}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"DUPERSID", "CONDIDX", "EVNTIDX", "CLNKIDX"})
in
    #"Removed Other Columns"
