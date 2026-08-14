let
    Source = Excel.Workbook(File.Contents(MEPSDataFolder & "CCSR_Labels.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"CCSR1X VALUE", type text}, {"CCSR1X LABEL", type text}, {"CCSR2X VALUE", type any}, {"CCSR2X LABEL", type text}, {"CCSR3X VALUE", type any}, {"CCSR3X LABEL", type text}, {"CCSR4X VALUE", type any}, {"CCSR4X LABEL", type text}, {"UNWEIGHTED", Int64.Type}, {"WEIGHTED BY perwt23f", type number}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"CCSR1X VALUE", "CCSR1X LABEL"}),
    #"Filtered Rows" = Table.SelectRows(#"Removed Other Columns", each [#"CCSR1X VALUE"] <> null),
    #"Removed Duplicates" = Table.Distinct(#"Filtered Rows")
in
    #"Removed Duplicates"
