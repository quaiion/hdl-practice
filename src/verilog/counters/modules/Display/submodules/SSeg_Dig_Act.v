module SSeg_Dig_Act ( input clk, output reg [1:0]q = 0,
                      input ce,  output wire [3:0]act );

        assign act = (q == 0) ? 4'b0111 :
                     (q == 1) ? 4'b1011 :
                     (q == 2) ? 4'b1101 :
                                4'b1110 ;

        always @ (posedge clk)
                q <= ce ? (q == 3 ? 0 : (q + 1)) : q ;

endmodule
