module Debouncer ( input clk,   output wire btn_out,
                   input ce,
                   input btn_in );

        reg q1 = 0,
            q2 = 0 ;

        assign btn_out = q1 & !q2 & ce;

        always @ (posedge clk) begin
                q1 <= ce ? btn_in : q1 ;
                q2 <= ce ? q1 : q2 ;
        end

endmodule
