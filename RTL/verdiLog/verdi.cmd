sidCmdLineBehaviorAnalysisOpt -incr -clockSkew 0 -loopUnroll 0 -bboxEmptyModule 0  -cellModel 0 -bboxIgnoreProtected 0 
debImport "-f" "dfs_rtl.f" "-top" "dfs_top"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "185" "27" "900" "659"
verdiWindowResize -win $_Verdi_1 "185" "27" "900" "659"
verdiSetActWin -dock widgetDock_<Inst._Tree>
schCreateWindow -delim "." -win $_nSchema1 -scope "dfs_top"
verdiSetActWin -win $_nSchema_2
verdiDockWidgetMaximize -dock windowDock_nSchema_2
schFit -win $_nSchema2
schSetOptions -win $_nSchema2 -quickTrace2Point on
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
verdiDockWidgetSetCurTab -dock widgetDock_<Signal_List>
verdiDockWidgetSetCurTab -dock windowDock_nSchema_2
verdiSetActWin -win $_nSchema_2
schSetOptions -win $_nSchema2 -pan on
debExit
