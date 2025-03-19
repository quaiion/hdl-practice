module SSeg_Translate ( input [3:0]dig_val, output wire [6:0]seg );

        //      a
        //  f | ‾ | b
        //      g
        //  e | ‾ | c
        //      d
        //      ‾

                                       /* gfedcba */
        assign seg = (dig_val == 0)  ? 7'b0111111 :
                     (dig_val == 1)  ? 7'b0000110 :
                     (dig_val == 2)  ? 7'b1011011 :
                     (dig_val == 3)  ? 7'b1001111 :
                     (dig_val == 4)  ? 7'b1100110 :
                     (dig_val == 5)  ? 7'b1101101 :
                     (dig_val == 6)  ? 7'b1111101 :
                     (dig_val == 7)  ? 7'b0000111 :
                     (dig_val == 8)  ? 7'b1111111 :
                     (dig_val == 9)  ? 7'b1101111 :
                     (dig_val == 10) ? 7'b1110111 :
                     (dig_val == 11) ? 7'b1111100 :
                     (dig_val == 12) ? 7'b0111001 :
                     (dig_val == 13) ? 7'b1011110 :
                     (dig_val == 14) ? 7'b1111001 :
                     (dig_val == 15) ? 7'b1110001 :
                                       7'b0000000 ;

endmodule
