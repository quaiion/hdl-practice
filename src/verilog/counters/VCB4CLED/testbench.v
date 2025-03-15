`timescale 1ns / 1ps

module VCBmCLED_tb ;

        initial begin
                $dumpfile("data/trace.vcd") ;
                $dumpvars(0, VCBmCLED_tb) ;
                #256 $finish ;
        end

        /* single load test */
        reg l = 0 ;
        initial begin
                #8 l = 1 ; // random load moment
                #2 l = 0 ; // hold "load" for 1 tick
        end

        reg clk = 0 ;
        always #1 clk <= !clk ;

        reg up = 0 ;
        always #64 up <= !up ; // change direction periodically

        reg [3:0]q ;
        wire tc ;
        wire ceo ;

        VCBmCLED counter (
                .clk (clk),
                .ce (1),
                .clr (0),
                .up (up),
                .l (l),
                .di (4'b0100), // random loaded value
                .tc (tc),
                .ceo (ceo),
                .q (q)
        );

endmodule
