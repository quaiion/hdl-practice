module Display ( input clk,       output wire [3:0]act,
                 input [15:0]dat, output wire [7:0]seg,
                 input [1:0]pt,   output wire ce_1ms );

        wire [3:0]dig_val ;
        wire [1:0]dig ;

        7Seg_Dig_Act DD1 (
                .clk (clk),
                .ce (ce_1ms),
                .q (dig),
                .act (act)
        );

        Mux_16_4 DD2 (
                .dat (dat),
                .do (dig_val),
                .adr (dig)
        );

        7Seg_Translate DD3 (
                .dig (dig_val),
                .seg (seg[6:0])
        );

        7Seg_Pt_Act DD4 (
                .pt (pt),
                .dig (dig),
                .act_pt (seg[7])
        );

        Gen_1ms DD5 (
                .clk (clk),
                .ce_1ms (ce_1ms)
        );

endmodule
