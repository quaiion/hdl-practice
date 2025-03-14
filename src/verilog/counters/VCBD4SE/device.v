`define m 4

module VCBDmSE ( input clk, output wire tc,
                 input ce,  output wire ceo,
                 input s,   output reg [`m - 1 : 0]q = (1 << `m) - 1 );
        
        assign tc = (q == 0) ;
        assign ceo = ce & tc ;

        always @ (posedge clk) begin
                q <= s ? ((1 << `m) - 1) : ce ? q - 1 : q ;
        end

endmodule
