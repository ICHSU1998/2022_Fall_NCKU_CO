wvResizeWindow -win $_nWave1 8 31 893 72
wvResizeWindow -win $_nWave1 0 23 1920 1137
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/CO2022/co2022_024/CO2022_Lab2/top.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/top_tb"
wvGetSignalSetScope -win $_nWave1 "/top_tb/top/dm"
wvGetSignalSetScope -win $_nWave1 "/top_tb/top/im"
wvGetSignalSetScope -win $_nWave1 "/top_tb/top/dm"
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/top/dm/mem\[0:65535\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/top/reg_pc"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/top/dm/mem\[0:65535\]} \
{/top_tb/top/reg_pc/clk} \
{/top_tb/top/reg_pc/current_pc\[31:0\]} \
{/top_tb/top/reg_pc/rst} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvGetSignalSetScope -win $_nWave1 "/top_tb/top/regfile"
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/top/dm/mem\[0:65535\]} \
{/top_tb/top/reg_pc/clk} \
{/top_tb/top/reg_pc/current_pc\[31:0\]} \
{/top_tb/top/reg_pc/rst} \
{/top_tb/top/regfile/registers\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/top_tb/top/dm/mem\[0:65535\]} \
{/top_tb/top/reg_pc/clk} \
{/top_tb/top/reg_pc/current_pc\[31:0\]} \
{/top_tb/top/reg_pc/rst} \
{/top_tb/top/regfile/registers\[0:31\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSetPosition -win $_nWave1 {("G1" 5)}
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 )} 
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSetPosition -win $_nWave1 {("G1" 5)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 5)}
wvSelectGroup -win $_nWave1 {G2}
wvSetCursor -win $_nWave1 105.409859 -snap {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvExpandBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 37)}
wvSelectSignal -win $_nWave1 {( "G1" 37 )} 
wvExpandBus -win $_nWave1 {("G1" 37)}
wvScrollUp -win $_nWave1 15
wvScrollUp -win $_nWave1 2
wvScrollUp -win $_nWave1 238
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 639
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 896
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 768
wvScrollUp -win $_nWave1 1087
wvScrollUp -win $_nWave1 3840
wvScrollUp -win $_nWave1 4351
wvScrollUp -win $_nWave1 1536
wvScrollUp -win $_nWave1 2111
wvScrollUp -win $_nWave1 1280
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 832
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 1471
wvScrollUp -win $_nWave1 832
wvScrollUp -win $_nWave1 1536
wvScrollUp -win $_nWave1 896
wvScrollUp -win $_nWave1 1600
wvScrollUp -win $_nWave1 1727
wvScrollUp -win $_nWave1 1664
wvScrollUp -win $_nWave1 1984
wvScrollUp -win $_nWave1 1471
wvScrollUp -win $_nWave1 1088
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 960
wvScrollUp -win $_nWave1 896
wvScrollUp -win $_nWave1 1151
wvScrollUp -win $_nWave1 1216
wvScrollUp -win $_nWave1 1472
wvScrollUp -win $_nWave1 768
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 127
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 256
wvScrollDown -win $_nWave1 319
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollUp -win $_nWave1 191
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 1088
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 127
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 1280
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 447
wvScrollUp -win $_nWave1 1088
wvScrollUp -win $_nWave1 2496
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 832
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 832
wvScrollDown -win $_nWave1 1855
wvScrollDown -win $_nWave1 1344
wvScrollDown -win $_nWave1 1152
wvScrollDown -win $_nWave1 2496
wvScrollDown -win $_nWave1 1023
wvScrollDown -win $_nWave1 2688
wvScrollDown -win $_nWave1 1024
wvScrollDown -win $_nWave1 1855
wvScrollDown -win $_nWave1 1216
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 1151
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 1408
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 1600
wvScrollDown -win $_nWave1 1535
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 1152
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 896
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 1216
wvScrollDown -win $_nWave1 1152
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 63
wvScrollUp -win $_nWave1 575
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 255
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 960
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 1152
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 575
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 127
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 127
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollDown -win $_nWave1 191
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvSelectSignal -win $_nWave1 {( "G1" 36820 )} 
wvScrollDown -win $_nWave1 26
wvScrollDown -win $_nWave1 44
wvScrollDown -win $_nWave1 5
wvSelectSignal -win $_nWave1 {( "G1" 36902 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvScrollUp -win $_nWave1 203
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 767
wvScrollUp -win $_nWave1 896
wvScrollUp -win $_nWave1 1024
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 1216
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 1087
wvScrollUp -win $_nWave1 1152
wvScrollUp -win $_nWave1 1280
wvScrollUp -win $_nWave1 1280
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 1343
wvScrollUp -win $_nWave1 1216
wvScrollUp -win $_nWave1 1152
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 1152
wvScrollUp -win $_nWave1 1152
wvScrollUp -win $_nWave1 639
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 960
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 832
wvScrollUp -win $_nWave1 832
wvScrollUp -win $_nWave1 1343
wvScrollUp -win $_nWave1 1408
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 383
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 384
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 127
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 447
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 320
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 896
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 1471
wvScrollUp -win $_nWave1 1088
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvCollapseBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 65541)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvExpandBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 65573)}
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvCollapseBus -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 65541)}
wvScrollDown -win $_nWave1 1215
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 703
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 1983
wvScrollDown -win $_nWave1 383
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 447
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 447
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 511
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 319
wvScrollDown -win $_nWave1 896
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 703
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 767
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 959
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 1599
wvScrollDown -win $_nWave1 895
wvScrollDown -win $_nWave1 1279
wvScrollDown -win $_nWave1 896
wvScrollDown -win $_nWave1 639
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 447
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 767
wvScrollDown -win $_nWave1 2431
wvScrollDown -win $_nWave1 1279
wvScrollDown -win $_nWave1 6076
wvScrollDown -win $_nWave1 2239
wvScrollDown -win $_nWave1 511
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 447
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 767
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 639
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 319
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 511
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 384
wvScrollDown -win $_nWave1 767
wvScrollDown -win $_nWave1 640
wvScrollDown -win $_nWave1 639
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 1535
wvScrollDown -win $_nWave1 895
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 511
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 192
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 511
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 639
wvScrollUp -win $_nWave1 896
wvScrollUp -win $_nWave1 1343
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 575
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 127
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 511
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 1087
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 447
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 575
wvScrollUp -win $_nWave1 704
wvScrollUp -win $_nWave1 1407
wvScrollUp -win $_nWave1 575
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 959
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 255
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 255
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 320
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 767
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 1343
wvScrollUp -win $_nWave1 1663
wvScrollUp -win $_nWave1 2110
wvScrollUp -win $_nWave1 1983
wvScrollUp -win $_nWave1 1343
wvScrollUp -win $_nWave1 1663
wvScrollUp -win $_nWave1 1151
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 383
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 447
wvScrollUp -win $_nWave1 640
wvScrollUp -win $_nWave1 1407
wvScrollUp -win $_nWave1 895
wvScrollUp -win $_nWave1 512
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 64
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 383
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 767
wvScrollDown -win $_nWave1 1024
wvScrollDown -win $_nWave1 1535
wvScrollDown -win $_nWave1 3709
wvScrollDown -win $_nWave1 1919
wvScrollDown -win $_nWave1 2047
wvScrollDown -win $_nWave1 1791
wvScrollDown -win $_nWave1 1918
wvScrollDown -win $_nWave1 832
wvScrollDown -win $_nWave1 575
wvScrollDown -win $_nWave1 960
wvScrollDown -win $_nWave1 383
wvScrollDown -win $_nWave1 320
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 768
wvScrollDown -win $_nWave1 959
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 576
wvScrollDown -win $_nWave1 1407
wvScrollDown -win $_nWave1 575
wvScrollDown -win $_nWave1 256
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 191
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 575
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 639
wvScrollDown -win $_nWave1 512
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 319
wvScrollDown -win $_nWave1 704
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 448
wvScrollDown -win $_nWave1 255
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 383
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 511
wvScrollUp -win $_nWave1 448
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 511
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 703
wvScrollUp -win $_nWave1 384
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 1407
wvScrollUp -win $_nWave1 576
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 191
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 192
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 256
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 63
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 128
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollUp -win $_nWave1 64
wvScrollDown -win $_nWave1 192
wvScrollDown -win $_nWave1 128
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollDown -win $_nWave1 64
wvScrollUp -win $_nWave1 85
wvScrollUp -win $_nWave1 11
wvScrollDown -win $_nWave1 29
wvScrollDown -win $_nWave1 4
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 15041.176056 -snap {("G1" 36870)}
wvSetCursor -win $_nWave1 23555.049296 -snap {("G1" 36872)}
wvSetCursor -win $_nWave1 6182.693662 -snap {("G1" 36870)}
wvSetCursor -win $_nWave1 12770.809859 -snap {("G1" 36871)}
wvSelectSignal -win $_nWave1 {( "G1" 36870 )} 
wvSetCursor -win $_nWave1 20088.686620 -snap {("G1" 36873)}
wvSelectSignal -win $_nWave1 {( "G1" 36874 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36873 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36870 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36874 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36878 )} 
wvSetCursor -win $_nWave1 23473.964789 -snap {("G1" 36880)}
wvSetCursor -win $_nWave1 6851.640845 -snap {("G1" 36883)}
wvSelectSignal -win $_nWave1 {( "G1" 36884 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36883 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36883 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36882 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36888 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36887 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36886 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36870 )} 
wvSelectSignal -win $_nWave1 {( "G1" 36873 )} 
wvExit
