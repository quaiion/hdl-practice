module spi_tb;
  localparam int WIDTH = 15;

  reg clk;
  reg load;
  reg [WIDTH-1:0] mtx_dat;
  reg [WIDTH-1:0] stx_dat;
  reg rst = 0;

  wire mosi;
  wire miso;
  wire sclk;

  initial begin
    $dumpfile("spi_tb.vcd");
    $dumpvars(0, spi_tb);

    mtx_dat = 15'b101110010100011;
    stx_dat = 15'b101011010101010;

    #20000;

    $finish;
  end

  always begin
    clk = 1;
    #1;
    clk = 0;
    #1;
  end

  spi #(
      .WIDTH  (WIDTH),
      .CLKFREQ(2000),
      .SPIFREQ(100)
  ) spi (
      .clk(clk),
      .rst(rst),
      .mtx_dat(mtx_dat),
      .stx_dat(stx_dat),
      .mosi(mosi),
      .miso(miso),
      .sclk(sclk),
      .load(load),
      .sw(8'b00000000)
  );
endmodule
