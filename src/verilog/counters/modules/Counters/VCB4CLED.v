`define m 4

module VCBmCLED( input clk,           output wire tc,
                 input ce,            output wire ceo,
                 input clr,           output reg [`m - 1 : 0]q = 0,
                 input up,
                 input l,
                 input [`m - 1 : 0]di );

        assign tc = up ? (q == (1 << `m) - 1) : (q == 0) ;
        assign ceo = ce & tc ;

        always @ (posedge clr or posedge clk) begin
                if (clr | ceo) q <= 0 ;
                else q <= l ? di : (up & ce) ? q + 1 : (!up & ce) ? (q - 1) : q ;
        end

endmodule
