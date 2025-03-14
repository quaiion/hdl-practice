`timescale 1ns / 1ps

module VCBD4SE_tb ;

        initial begin
                $dumpfile("data/trace.vcd") ;
                $dumpvars(0, VCBD4SE_tb) ;
                #64 $finish ;
        end

        reg clk = 0 ;
        always #1 clk = !clk ;

        reg [3:0]q ;
        wire tc ;
        wire ceo ;

        VCBDmSE counter (
                .clk (clk),
                .ce (1),
                .s (0),
                .tc (tc),
                .ceo (ceo),
                .q (q)
        );

endmodule
