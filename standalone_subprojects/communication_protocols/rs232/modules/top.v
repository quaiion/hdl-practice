module top (
    input clk,

    input [9:0] switch,
    input btn0,
    input btn3,

    output wire [3:0] digits,
    output wire [7:0] segments,
    output wire [7:0] led,

    output wire osc0,
    output wire osc1,
    output wire osc2,
    // output wire osc3,
    output wire osc4,
    output wire osc5,
    output wire osc6,
    output wire osc7,
    output wire osc8
);

  wire TXD;
  wire [3:0] cb_bit_tx;
  wire en_rx_byte;
  wire [3:0] cb_bit_rx;
  wire ok_rx_byte;
  wire start_rx;
  wire T_start;
  wire T_dat;
  wire T_stop;
  wire ce_tact;
  wire ce_bit;
  wire RXD;

  assign led[5] = en_tx_byte;
  assign led[4] = en_rx_byte;

  reg loaded0 = 0, loaded1 = 1;
  assign led[6] = loaded0;
  assign led[7] = loaded1;

  reg [7:0] tx_dat = 8'b10010010;
  always @(posedge clk) begin
    tx_dat <= switch[7:0];
  end

  always @(posedge ok_rx_byte) begin
    loaded0 <= ~loaded0;
    loaded1 <= ~loaded1;
  end

  rs232 rs (
    .tx_dat(tx_dat),
    .clk(clk),
    .sw(switch),
    .digits(digits),
    .segments(segments),
    .TXD(TXD),
    .cb_bit_tx(cb_bit_tx),
    .en_rx_byte(en_rx_byte),
    .cb_bit_rx(cb_bit_rx),
    .ok_rx_byte(ok_rx_byte),
    .start_rx(start_rx),
    .T_start(T_start),
    .T_dat(T_dat),
    .T_stop(T_stop),
    .ce_tact(ce_tact),
    .ce_bit(ce_bit),
    .RXD(RXD),
    .but3(but3)
  );

  assign osc0 = TXD;
  assign osc1 = en_tx_byte;
  assign osc2 = T_start;
  assign osc6 = T_dat;
  assign osc4 = T_stop;
  assign osc5 = RXD;

endmodule
