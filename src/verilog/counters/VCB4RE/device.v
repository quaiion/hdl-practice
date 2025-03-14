module VCB4RE ( input clk, output wire tc,
                input ce,  output wire ceo,
                input r,   output reg [3:0]q = 0 );

        assign tc = (q == 15) ;
        assign ceo = ce & tc ;

        always @ (posedge clk) begin
                q <= r ? 0 : ce ? (q + 1) : q ;
        end

endmodule
