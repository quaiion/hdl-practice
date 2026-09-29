module Gen_1ms ( input clk, output wire ce_1ms );

        parameter CLK_FREQ = 27_000_000 ;

        reg [15:0]cb_ms = 0 ;

        assign ce_1ms = (cb_ms == 1) ;

        always @ (posedge clk)
                cb_ms <= ce_1ms ? (CLK_FREQ / 1000) : (cb_ms - 1) ;

endmodule
