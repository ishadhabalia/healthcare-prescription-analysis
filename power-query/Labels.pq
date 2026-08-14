let
    Source = Excel.Workbook(File.Contents(MEPSDataFolder & "ICD10CDX_Code_Frequencies.xlsx"), null, true),
    Sheet1_Sheet = Source{[Item="Sheet1",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Sheet1_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ICD10CDX VALUE", type text}, {"ICD10CDX LABEL", type text}, {"UNWEIGHTED", Int64.Type}, {"WEIGHTED BY perwt19f", type number}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type", each [#"ICD10CDX VALUE"] <> null)
in
    #"Filtered Rows"
