let
    Source = Excel.Workbook(File.Contents(MEPSDataFolder & "h251.xlsx"), null, true),
    H251_Sheet = Source{[Item="H251",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(H251_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"DUID", Int64.Type}, {"PID", Int64.Type}, {"DUPERSID", Int64.Type}, {"PANEL", Int64.Type}, {"DATAYEAR", Int64.Type}, {"AGE23X", Int64.Type}, {"SEX", Int64.Type}, {"FAMINC23", Int64.Type}}),
    #"Removed Columns" = Table.SelectColumns(#"Changed Type", {"DUID", "PID", "DUPERSID", "AGE23X", "SEX", "FAMINC23"}),
    #"Missing Values" = Table.TransformColumns(
    #"Removed Columns",
    List.Transform(
        Table.ColumnNames(#"Removed Columns"),
        (col) => {col, each if Value.Is(_, type number) and _ < 0 then null else _}
    )
)
in
    #"Missing Values"
