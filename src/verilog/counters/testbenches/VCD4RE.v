`timescale 1ns / 1ps

module VCD4RE_tb ;

        initial begin
                $dumpfile("data/trace.vcd") ;
                $dumpvars(0, VCD4RE_tb) ;
                #4200 $finish ;
        end

        reg clk = 0 ;
        always #1 clk <= !clk ;

        reg [3:0] q[0:3] ;
        wire tc ;
        wire ceo ;

        VCD4RE counter (
                .clk (clk),
                .ce (1),
                .r (0),
                .tc (tc),
                .ceo (ceo),
                .q0 (q[0]),
                .q1 (q[1]),
                .q2 (q[2]),
                .q3 (q[3])
        );

endmodule
