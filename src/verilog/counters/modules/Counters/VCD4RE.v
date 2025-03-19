module VCD4RE ( input clk, output wire tc,
                input ce,  output wire ceo,
                input r,   output reg [3:0]q = 0 );

        assign tc = (q == 9) ;
        assign ceo = ce & tc ;

        always @ (posedge clk)
                q <= (r | ceo) ? 0 : ce ? (q + 1) : q ;

endmodule
