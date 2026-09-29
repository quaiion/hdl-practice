module spi #(
    parameter int WIDTH   = 15,
    parameter int CLKFREQ = 27000000,
    parameter int SPIFREQ = 250000
) (
    input [9:0] sw,

    output wire load,
    output wire sclk,
    output wire miso,
    output wire mosi,

    input clk,
    input rst,

    output wire [ 3:0] digits,
    output wire [ 7:0] segments,
    output wire [15:0] dat,

    input reg [WIDTH-1:0] mtx_dat = 15'b101110010100011,
    input reg [WIDTH-1:0] stx_dat = 15'b101011010101010,

    output wire ce1s_n_ms
);

  wire [WIDTH-1:0] mrx_dat;
  wire [WIDTH-1:0] srx_dat;

  wire [WIDTH-1:0] sr_mtx;
  wire [WIDTH-1:0] sr_mrx;

  wire [WIDTH-1:0] sr_stx;
  wire [WIDTH-1:0] sr_srx;

  wire [7:0] cb_bit;
  wire ce_tact;
  wire ce1ms;

  gennms_1s #(
      .N(25)
  ) gen25ms_1s (
      .clk (clk),
      .tmod(sw[7]),
      .ceo (ce1s_n_ms),
      .ce  (ce1ms)
  );

  reg [15:0] displayed = 0;
  
  always @(posedge clk) begin
    displayed <= sw[9:8] == 0 ? { 1'b0, 15'b101110010100011 } :
                 sw[9:8] == 1 ? { 1'b0, 15'b101011010101010 } :
                 sw[9:8] == 2 ? { 1'b0, 15'b101011010101010 } :
                                { 1'b0, 15'b101110010100011 } ;
  end

 // always @(posedge clk) begin
 //   displayed <= sw[9:8] == 0 ? { 1'b0, sr_mtx } :
 //                sw[9:8] == 1 ? { 1'b0, sr_mrx } :
 //                sw[9:8] == 2 ? { 1'b0, sr_stx } :
 //                               { 1'b0, sr_srx } ;
 // end

  Display display (
      .clk(clk),
      .ce_1ms(ce1ms),
      .pt(~sw[5:4]),
      .dat(displayed),
      .act(digits),
      .seg(segments)
  );

  spi_master #(
      .WIDTH  (WIDTH),
      .CLKFREQ(CLKFREQ),
      .SPIFREQ(SPIFREQ)
  ) master (
      .clk(clk),
      .st(ce1s_n_ms),
      .din(mtx_dat),
      .dout(mrx_dat),
      .load(load),
      .sclk(sclk),
      .mosi(mosi),
      .clr(rst),
      .miso(miso),
      .sr_mtx(sr_mtx),
      .sr_mrx(sr_mrx),
      .cb_bit(cb_bit),
      .ce_tact(ce_tact)
  );

  spi_slave #(
      .WIDTH(WIDTH)
  ) slave (
      .din(stx_dat),
      .dout(srx_dat),
      .load(load),
      .miso(miso),
      .sclk(sclk),
      .mosi(mosi),
      .sr_stx(sr_stx),
      .sr_srx(sr_srx),
      .clr(rst)
  );
endmodule
