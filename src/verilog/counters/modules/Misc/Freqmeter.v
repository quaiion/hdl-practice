module VC4D4RE ( input clk, output wire tc,
                 input ce,  output wire ceo,
                 input r,   output reg [3:0]q0,
                            output reg [3:0]q1,
                            output reg [3:0]q2,
                            output reg [3:0]q3 );

        wire tc_0, tc_1, tc_2, tc_3 ;
        assign tc = tc_0 & tc_1 & tc_2 & tc_3 ;

        wire inter_ce_01,
             inter_ce_12,
             inter_ce_23 ;

        VCD4RE dec_ctr_0 (
                .clk (clk),
                .ce (ce),
                .r (r),
                .tc (tc_0),
                .ceo (inter_ce_01),
                .q (q0)
        );

        VCD4RE dec_ctr_1 (
                .clk (clk),
                .ce (inter_ce_01),
                .r (r),
                .tc (tc_1),
                .ceo (inter_ce_12),
                .q (q1)
        );

        VCD4RE dec_ctr_2 (
                .clk (clk),
                .ce (inter_ce_12),
                .r (r),
                .tc (tc_2),
                .ceo (inter_ce_23),
                .q (q2)
        );

        VCD4RE dec_ctr_3 (
                .clk (clk),
                .ce (inter_ce_23),
                .r (r),
                .tc (tc_3),
                .ceo (ceo),
                .q (q3)
        );

endmodule

module Freqmeter ( input clk,    output reg [15:0]dat,
                   input ce_1ms,
                   input ce );

        wire ceo, tc ;
        reg [15:0] q ;

        VC4D4RE counter (
                .clk (clk),
                .ce (ce_1ms),
                .r (ce),
                .tc (tc),
                .ceo (ceo),
                .q0 (q[15:12]),
                .q1 (q[11:8]),
                .q2 (q[7:4]),
                .q3 (q[3:0])
        );

        always @ (posedge clk) begin
                if (ce) dat <= q ;
        end

endmodule
