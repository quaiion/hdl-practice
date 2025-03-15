`timescale 1ns / 1ps

module VCJ4RE_tb ;

        initial begin
                $dumpfile("data/trace.vcd") ;
                $dumpvars(0, VCJ4RE_tb) ;
                #128 $finish ;
        end

        reg clk = 0 ;
        always #1 clk <= !clk ;

        reg [3:0]q ;
        wire tc ;
        wire ceo ;

        VCJmRE counter (
                .clk (clk),
                .ce (1),
                .r (0),
                .tc (tc),
                .ceo (ceo),
                .q (q)
        );

endmodule
