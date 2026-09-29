module Mux_16_4 ( input [15:0]dat, output wire [3:0]dig_val,
                  input [1:0]dig );

        assign dig_val = (dig == 0) ? dat[15:12]  :
                         (dig == 1) ? dat[11:8]  :
                         (dig == 2) ? dat[7:4] :
                                      dat[3:0] ;

endmodule
