module Dig_Act ( input clk, output reg [1:0]q = 0,
                      input ce,  output wire [3:0]act );

        assign act = (q == 0) ? 4'b0001 :
                     (q == 1) ? 4'b0010 :
                     (q == 2) ? 4'b0100 :
                                4'b1000 ;

        always @ (posedge clk)
                if (ce) q <= q + 1;

endmodule
