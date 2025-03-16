module Mux_16_4 ( input [15:0]dat, output wire [3:0]dig_val,
                  input [1:0]dig );

        assign do = (dig == 0) ? dat[3:0]  :
                    (dig == 1) ? dat[7:4]  :
                    (dig == 2) ? dat[11:8] :
                                 dat[15:12] ;

endmodule
