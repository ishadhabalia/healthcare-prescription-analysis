let
    Source = Table.NestedJoin(Prescription_with_Conditions, {"CONDIDX"}, Condition, {"CONDIDX"}, "Condition", JoinKind.LeftOuter),
    #"Expanded Condition" = Table.ExpandTableColumn(Source, "Condition", {"RXCOND", "ICD10CDX", "CCSR1X"}, {"RXCOND", "ICD10CDX", "CCSR1X"})
in
    #"Expanded Condition"
