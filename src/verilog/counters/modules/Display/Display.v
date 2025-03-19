module Display ( input clk,       output wire [3:0]act,
                 input [15:0]dat, output wire [7:0]seg,
                 input [1:0]pt,   output wire ce_1ms );

        parameter CLK_FREQ = 50_000_000 ;

        wire [3:0]dig_val ;
        wire [1:0]dig ;

        7Seg_Dig_Act dig_act (
                .clk (clk),
                .ce (ce_1ms),
                .q (dig),
                .act (act)
        );

        Mux_16_4 mux (
                .dat (dat),
                .do (dig_val),
                .adr (dig)
        );

        7Seg_Translate transl (
                .dig (dig_val),
                .seg (seg[6:0])
        );

        7Seg_Pt_Act pt_act (
                .pt (pt),
                .dig (dig),
                .act_pt (seg[7])
        );

        Gen_1ms #(
              .CLK_FREQ (CLK_FREQ)
        ) gen (
                .clk (clk),
                .ce_1ms (ce_1ms)
        );

endmodule
