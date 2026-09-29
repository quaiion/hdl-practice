module gen4an (
    input ce,
    input clk,
    output reg [1:0] q = 0,
    output wire [3:0] an
);
  assign an = (q == 0) ? 4'b0111 :
              (q == 1) ? 4'b1011 :
              (q == 2) ? 4'b1101 :
                         4'b1110 ;

  always @(posedge clk)
    if (ce) begin
      q <= q + 1;
    end
endmodule
