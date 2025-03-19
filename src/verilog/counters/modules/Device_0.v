module Device ( input clk,     output wire [3:0]act,
                input [7:0]sw, output wire [7:0]seg,
                input btn_0,
                input btn_1 );

        reg [15:0]dat ;
        wire ce_1ms, init_ce, tc, ceo ;
        wire inter_ce_01,
             inter_ce_12,
             inter_ce_23 ;

        Display #(
                .CLK_FREQ (27_000_000)
        ) disp (
                .clk (clk),
                .dat (dat),
                .pt (sw[5:4]),
                .act (act),
                .seg (seg),
                .ce_1ms (ce_1ms)
        );

        Gen_Nms_1s gen (
                .clk (clk),
                .ce (ce_1ms),
                .tmod (sw[7]),
                .ceo (init_ce)
        );

        VCBmCLED counter_0 (
                .clk (clk),
                .ce (init_ce),
                .clr (btn_0),
                .up (sw[6]),
                .l (btn_1),
                .di (sw[3:0]),
                .tc (tc),
                .ceo (inter_ce_01),
                .q (dat[3:0])
        );

        VCB4RE counter_1 (
                .clk (clk),
                .ce (inter_ce_01),
                .r (btn_0),
                .tc (tc),
                .ceo (inter_ce_12),
                .q (dat[7:4])
        );

        VCBDmSE counter_2 (
                .clk (clk),
                .ce (inter_ce_12),
                .s (btn_0),
                .tc (tc),
                .ceo (inter_ce_23),
                .q (dat[11:8])
        );

        VCD4RE counter_3 (
                .clk (clk),
                .ce (inter_ce_23),
                .r (btn_0),
                .tc (tc),
                .ceo (ceo),
                .q (dat[15:12])
        );

endmodule
