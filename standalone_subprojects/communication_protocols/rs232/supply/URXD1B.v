`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:25:50 01/14/2016 
// Design Name: 
// Module Name:    URXD1B 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 

////////////////////////////////////////////////////////////////////////////////
module URXD1B(	input Inp,	 output reg en_rx_byte=0,
    				input clk,	 output reg [7:0] sr_dat=0,
									 output reg [3:0]cb_bit=10, 
    					  			 output wire ok_rx_byte,
									 output wire start,									  
									 output wire T_dat,
									 output wire ce_tact,
									 output wire ce_bit,
									 output wire T_start,
									 output wire T_stop,
									 output reg RXD=1
									  );									  
parameter Fclk=50000000 ; //50 MHz
parameter VEL = 115200 ; //115.2 kBod (из таблицы 1 вариантов)
parameter Nt = Fclk/VEL ; //434

reg tRXD=1; 
reg [15:0]cb_tact=0 ; 
assign ce_tact = (cb_tact==Nt) ;
wire df_RXD = !RXD & tRXD ;//Спад RXD
assign T_start = (cb_bit==0) ;
assign T_stop = (cb_bit==9) & en_rx_byte ;
assign T_dat = (cb_bit>0) & (cb_bit<9);
assign start = df_RXD & !en_rx_byte ;//
assign ce_bit = (cb_tact==Nt/2);
assign ok_rx_byte = (ce_bit & T_stop & en_rx_byte & RXD);

always @ (posedge clk) begin
RXD <= Inp ; tRXD <= RXD ;
cb_tact <= (start | ce_tact)? 1 : cb_tact+1;  
en_rx_byte <= (T_start & ce_bit & !RXD)? 1 : (T_stop & ce_tact)? 0 : en_rx_byte ;
cb_bit <=  start? 0 : (ce_tact & en_rx_byte)? cb_bit+1 : cb_bit ;
sr_dat <= start? 0 : (ce_bit & T_dat)? sr_dat>>1 | RXD<<7 : sr_dat ;//in
end

endmodule
