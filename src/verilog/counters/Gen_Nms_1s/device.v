`define n 31

module Gen_Nms_1s ( input clk, output wire ceo,
                    input ce,
                    input tmod );

        reg [9:0]cb_n_ms = 0 ;
        wire [9:0]n_ms = tmod ? `n - 1 : 1000 - 1 ;

        assign ceo = ce & (cb_n_ms == 0) ;

        always @ (posedge clk)
                if (ce) cb_n_ms <= (cb_n_ms == 0) ? n_ms : cb_n_ms - 1 ;

endmodule
