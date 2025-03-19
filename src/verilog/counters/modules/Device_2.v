module Device ( input clk,     output wire [3:0]act,
                input [7:0]sw, output wire [7:0]seg );

        reg [15:0]dat ;
        wire ce_1ms, imp_ce ;

        Freqmeter meter (
                .clk (clk),
                .ce_1ms (ce_1ms),
                .ce (imp_ce),
                .dat (dat)
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

        Gen_Nms_1s gen (
                .clk (clk),
                .ce (ce_1ms),
                .tmod (sw[7]),
                .ceo (imp_ce)
        );

endmodule
