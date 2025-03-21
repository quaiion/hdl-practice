module Device ( input clk, output wire [3:0]act,
                           output wire [7:0]seg );

        initial begin
                act <= 4'b0000 ;
                seg <= 8'b11111111 ;
        end

endmodule
