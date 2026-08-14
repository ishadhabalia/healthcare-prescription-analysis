let
    Source = Table.NestedJoin(Prescription, {"LINKIDX"}, Link, {"EVNTIDX"}, "Link", JoinKind.LeftOuter),
    #"Expanded Link" = Table.ExpandTableColumn(Source, "Link", {"CONDIDX", "EVNTIDX", "CLNKIDX"}, {"CONDIDX", "EVNTIDX", "CLNKIDX"})
in
    #"Expanded Link"
