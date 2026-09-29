module Device ( input clk,     output wire [3:0]act,
                input [7:0]sw, output wire [7:0]seg );

        reg [15:0]dat = {4'd1, 4'd2, 4'd3, 4'd9};
        wire ce_1ms ;

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

endmodule
