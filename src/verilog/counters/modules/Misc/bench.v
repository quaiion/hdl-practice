`timescale 1ns / 1ps

module Bench ;

        initial begin
                $dumpfile("bench.vcd") ;
                $dumpvars(0, Bench) ;
                #100 $finish ;
        end

        reg clk = 0 ;
        always #0.5 clk <= !clk ;

        reg ce_1ms = 0 ;
        always #5 ce_1ms <= !ce_1ms ;

        reg [15:0]dat ;
        wire tc0, tc1, tc2, tc3, ceo ;
        wire inter_ce_01,
             inter_ce_12,
             inter_ce_23 ;

        VCBmCLED counter_0 (
                .clk (clk),
                .ce (ce_1ms),
                .clr (0),
                .up (1),
                .l (0),
                .di (0),
                .tc (tc),
                .ceo (inter_ce_01),
                .q (dat[15:12])
        );

        VCB4RE counter_1 (
                .clk (clk),
                .ce (inter_ce_01),
                .r (0),
                .tc (tc),
                .ceo (inter_ce_12),
                .q (dat[11:8])
        );

        VCBDmSE counter_2 (
                .clk (clk),
                .ce (inter_ce_12),
                .s (0),
                .tc (tc),
                .ceo (inter_ce_23),
                .q (dat[7:4])
        );

        VCD4RE counter_3 (
                .clk (clk),
                .ce (inter_ce_23),
                .r (0),
                .tc (tc),
                .ceo (ceo),
                .q (dat[3:0])
        );

endmodule
