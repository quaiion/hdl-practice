module rs232 (
    input [9:0] sw,

    input clk,

    output wire [3:0] digits,
    output wire [7:0] segments,

    input reg [7:0] tx_dat = 8'b10010010,

    output wire TXD,
    output wire [3:0] cb_bit_tx,
    output wire en_rx_byte,
    output wire [3:0] cb_bit_rx,
    output wire ok_rx_byte,
    output wire start_rx,
    output wire T_start,
    output wire T_dat,
    output wire T_stop,
    output wire ce_tact,
    output wire ce_bit,
    output wire RXD,

    input wire but3
);

  wire [7:0] cb_bit;
  wire ce_tact;
  wire ce1ms;
  wire ce1s_n_ms;
  wire [15:0] dat;

  assign dat[7:0] = tx_dat;

  Display display (
    .clk(clk),
    .ce_1ms(ce1ms),
    .pt(0),
    .dat(dat),
    .act(digits),
    .seg(segments)
  );

  Sch_test_URXD1B sch (
    .tx_clk(clk),
    .rx_clk(clk),
    .tx_dat(tx_dat),
    .st(ce1ms),
    .TXD(TXD),
    .cb_bit_tx(cb_bit_tx),
    .en_rx_byte(en_rx_byte),
    .sr_dat(dat[15:8]),
    .cb_bit_rx(cb_bit_rx),
    .ok_rx_byte(ok_rx_byte),
    .start_rx(start_rx),
    .T_start(T_start),
    .T_dat(T_dat),
    .T_stop(T_stop),
    .ce_tact(ce_tact),
    .ce_bit(ce_bit),
    .RXD(RXD)
  );

endmodule
