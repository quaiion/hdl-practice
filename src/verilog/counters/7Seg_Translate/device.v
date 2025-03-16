module Translate_7Seg ( input [3:0]dig, output wire [6:0]seg );

        //      a
        //  f | ‾ | b
        //      g
        //  e | ‾ | c
        //      d
        //      ‾

                                  /* gfedcba */
        assign seg = (dig == 0)  ? 7'b0111111 :
                     (dig == 1)  ? 7'b0000110 :
                     (dig == 2)  ? 7'b1011011 :
                     (dig == 3)  ? 7'b1001111 :
                     (dig == 4)  ? 7'b1100110 :
                     (dig == 5)  ? 7'b1101101 :
                     (dig == 6)  ? 7'b1111101 :
                     (dig == 7)  ? 7'b0000111 :
                     (dig == 8)  ? 7'b1111111 :
                     (dig == 9)  ? 7'b1101111 :
                     (dig == 10) ? 7'b1110111 :
                     (dig == 11) ? 7'b1111100 :
                     (dig == 12) ? 7'b0111001 :
                     (dig == 13) ? 7'b1011110 :
                     (dig == 14) ? 7'b1111001 :
                     (dig == 15) ? 7'b1110001 :
                                   7'b0000000 ;

endmodule
