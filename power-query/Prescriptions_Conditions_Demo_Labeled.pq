let
    Source = Table.NestedJoin(Prescriptions_Conditions_Demographics, {"ICD10CDX"}, Labels, {"ICD10CDX VALUE"}, "Labels", JoinKind.LeftOuter),
    #"Expanded Labels" = Table.ExpandTableColumn(Source, "Labels", {"ICD10CDX LABEL"}, {"ICD10CDX LABEL"}),
    #"Merged CCSR" = Table.NestedJoin(#"Expanded Labels", {"CCSR1X"}, CCSR_Labels, {"CCSR1X VALUE"}, "CCSR_Labels", JoinKind.LeftOuter),
    #"Expanded CCSR" = Table.ExpandTableColumn(#"Merged CCSR", "CCSR_Labels", {"CCSR1X LABEL"}, {"CCSR1X LABEL"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded CCSR",{"DUPERSID", "RXRECIDX", "RXNAME", "RXFORM", "RXDAYSUP", "PERWT23F", "RXCOND", "ICD10CDX", "ICD10CDX LABEL", "CCSR1X", "CCSR1X LABEL", "AGE23X", "SEX", "FAMINC23"}),
    #"Added Custom" = Table.AddColumn(
    #"Reordered Columns",
    "Age Group",
 each if [AGE23X] = null then "Unknown"
         else if [AGE23X] <= 17 then "0–17"
         else if [AGE23X] <= 34 then "18–34"
         else if [AGE23X] <= 49 then "35–49"
         else "50+",
    type text
),
    #"Added Custom1" = Table.AddColumn(#"Added Custom",
    "Gender",
each if [SEX] = null then "Unknown"
         else if [SEX] = 1 then "Male"
         else if [SEX] = 2 then "Female"
         else "Other",
    type text
),
    Custom1 = Table.AddColumn(
    #"Added Custom1",
    "Family Income Group",
    each if [FAMINC23] = null then "Unknown"
         else if [FAMINC23] < 20000 then "<20k"
         else if [FAMINC23] < 50000 then "20k–49k"
         else if [FAMINC23] < 100000 then "50k–99k"
         else "100k+",
    type text
),
    #"Replaced Value" = Table.ReplaceValue(Custom1,null,"Unknown",Replacer.ReplaceValue,{"RXNAME"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",null,"Unknown",Replacer.ReplaceValue,{"RXFORM"}),
    Custom2 = Table.ReplaceValue(
    #"Replaced Value1",
    null,
    "CANNOT BE COMPUTED",
    Replacer.ReplaceValue,
    {"ICD10CDX LABEL"}
),
    Custom3 = Table.ReplaceValue(
    Custom2,
    null,
    "CANNOT BE COMPUTED",
    Replacer.ReplaceValue,
    {"CCSR1X LABEL"}
),
    #"Removed Columns" = Table.RemoveColumns(Custom3,{"RXCOND"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Columns",{{"CCSR1X", type text}, {"CCSR1X LABEL", type text}})
in
    #"Changed Type"
