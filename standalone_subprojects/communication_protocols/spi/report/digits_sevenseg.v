module digits_sevenseg (
    input [3:0] dig,
    output wire [6:0] seg
);
  function automatic [6:0] f(input reg [3:0] dig);
    case (dig)
      0:  f = 7'b0111111;
      1:  f = 7'b0000110;
      2:  f = 7'b1011011;
      3:  f = 7'b1001111;
      4:  f = 7'b1100110;
      5:  f = 7'b1101101;
      6:  f = 7'b1111101;
      7:  f = 7'b0000111;
      8:  f = 7'b1111111;
      9:  f = 7'b1101111;
      10: f = 7'b1110111;
      11: f = 7'b1111100;
      12: f = 7'b0111001;
      13: f = 7'b1011110;
      14: f = 7'b1111001;
      15: f = 7'b1110001;
    endcase
  endfunction

  assign seg = f(dig);
endmodule
