module SSeg_Dig_Act ( input clk, output reg [1:0]q = 0,
                      input ce,  output wire [3:0]act );

        assign act = (q == 0) ? 4'b1110 :
                     (q == 1) ? 4'b1101 :
                     (q == 2) ? 4'b1011 :
                                4'b0111 ;

        always @ (posedge clk)
                if (ce) q <= q + 1;

endmodule
