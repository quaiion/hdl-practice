module Device ( input clk,     output wire [3:0]act,
                input [7:0]sw, output wire [7:0]seg,
                input btn_0,
                input btn_1,
                input btn_2 );

        reg [15:0]dat ;
        wire ce_1ms, tc, ceo ;
        wire btn_2_deb ;

        Debouner deb (
                .clk (clk),
                .ce (ce_1ms),
                .btn_in (btn_2),
                .btn_out (btn_2_deb)
        );

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

        VCB4CLED counter_0 (
                .clk (clk),
                .ce (btn_2_deb),
                .clr (btn_0),
                .up (sw[6]),
                .l (btn_1),
                .di (sw[3:0]),
                .tc (tc),
                .ceo (ceo),
                .q (dat[3:0])
        );

        VCB4RE counter_1 (
                .clk (clk),
                .ce (btn_2_deb),
                .r (btn_0),
                .tc (tc),
                .ceo (ceo),
                .q (dat[7:4])
        );

        VCBD4SE counter_2 (
                .clk (clk),
                .ce (btn_2_deb),
                .s (btn_0),
                .tc (tc),
                .ceo (ceo),
                .q (dat[11:8])
        );

        VCD4RE counter_3 (
                .clk (clk),
                .ce (btn_2_deb),
                .r (btn_0),
                .tc (tc),
                .ceo (ceo),
                .q (dat[15:12])
        );

endmodule
