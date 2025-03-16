`define n 31

module Gen_Nms_1s ( input clk, output wire ceo,
                    input ce,
                    input t_mod );

        parameter clk_freq = 50000000 ;
        parameter gen_freq = 1 ;
        parameter gen_base_freq_tmod = 1000 ;

        reg [31:0]cb_n_ticks = 0 ;
        wire [31:0]n_ticks = t_mod ? clk_freq / gen_base_freq_tmod * `n - 1 :
                                     clk_freq / gen_freq - 1 ;

        assign ceo = ce & (cb_n_ticks == 0) ;

        always @ (posedge clk)
                if (ce) cb_n_ticks <= (cb_n_ticks == 0) ? n_ticks :
                                                          cb_n_ticks - 1 ;

endmodule
