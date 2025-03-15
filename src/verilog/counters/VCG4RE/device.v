module VCG4RE ( input clk, output wire tc,
                input ce,  output wire ceo,
                input r,   output wire [3:0]q );

        reg [4:0]sup = 0 ;

        assign tc = (sup[4:0] == ((1 << 4) | 1)) ;
        assign ceo = ce & tc ;
        assign q = sup[4:1] ;

        always @ (posedge clk) begin
                sup[0] <= (r | ceo) ? 0 : ce ? !sup[0] : sup[0] ;
                sup[1] <= (r | ceo) ? 0 : ((sup[0] == 0) & ce) ? !sup[1] : sup[1] ; 
                sup[2] <= (r | ceo) ? 0 : ((sup[1:0] == ((1 << 1) | 1)) & ce) ? !sup[2] : sup[2] ;
                sup[3] <= (r | ceo) ? 0 : ((sup[2:0] == ((1 << 2) | 1)) & ce) ? !sup[3] : sup[3] ;
                sup[4] <= (r | ceo) ? 0 : ((sup[3:0] == ((1 << 3) | 1)) & ce) ? !sup[4] : sup[4] ;
        end

endmodule
