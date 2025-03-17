module VCDRE ( input clk, output wire tc,
               input ce,  output wire ceo,
               input r,   output reg [3:0]q = 0 );

        assign tc = (q == 9) ;
        assign ceo = ce & tc ;

        always @ (posedge clk)
                q <= (r | ceo) ? 0 : ce ? q + 1 : q ;

endmodule

module VCD4RE ( input clk, output wire tc,
                input ce,  output wire ceo,
                input r,   output reg [3:0]q0 = 0,
                           output reg [3:0]q1 = 0,
                           output reg [3:0]q2 = 0,
                           output reg [3:0]q3 = 0 );

        wire tc0, tc1, tc2, tc3 ;
        assign tc = tc0 & tc1 & tc2 & tc3 ;

        wire inter_ceo_01, inter_ceo_12, inter_ceo_23 ;

        VCDRE dec_ctr_0 (
                .clk (clk),
                .ce (ce),
                .r (r),
                .tc (tc0),
                .ceo (inter_ceo_01),
                .q (q0)
        );

        VCDRE dec_ctr_1 (
                .clk (clk),
                .ce (inter_ceo_01),
                .r (r),
                .tc (tc1),
                .ceo (inter_ceo_12),
                .q (q1)
        );

        VCDRE dec_ctr_2 (
                .clk (clk),
                .ce (inter_ceo_12),
                .r (r),
                .tc (tc2),
                .ceo (inter_ceo_23),
                .q (q2)
        );

        VCDRE dec_ctr_3 (
                .clk (clk),
                .ce (inter_ceo_23),
                .r (r),
                .tc (tc3),
                .ceo (ceo),
                .q (q3)
        );

endmodule
