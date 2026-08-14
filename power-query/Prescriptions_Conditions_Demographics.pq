let
    Source = Table.NestedJoin(Prescription_With_Condition_Details, {"DUPERSID"}, Demographic, {"DUPERSID"}, "Demographic", JoinKind.LeftOuter),
    #"Expanded Demographic" = Table.ExpandTableColumn(Source, "Demographic", {"AGE23X", "SEX", "FAMINC23"}, {"AGE23X", "SEX", "FAMINC23"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded Demographic",{"DUID", "PID", "DRUGIDX", "LINKIDX", "CONDIDX", "EVNTIDX", "CLNKIDX"})
in
    #"Removed Columns"
