`define m 4

module VCJmRE ( input clk, output wire tc,
                input ce,  output wire ceo,
                input r,   output reg [`m - 1 : 0]q = 0 );

        assign tc = (q == (1 << `m) - 1) ;
        assign ceo = ce & tc ;

        always @ (posedge clk)
                q <= r ? 0 : ce ? (q << 1) | {3'b000, !q[`m - 1]} : q ;

endmodule
