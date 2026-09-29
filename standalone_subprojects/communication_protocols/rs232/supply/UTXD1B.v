`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:58:52 09/28/11
// Design Name:    
// Module Name:    UTXD1B
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
module UTXD1B(	input clk,		output wire TXD,//Выход 
    				input[7:0]dat,	output wire ce_tact,//Строб такта
    				input st,		output reg en_tx_byte=0,//Интервал передачи
										output reg [3:0] cb_bit=0, 
										output wire T_start,//Старт такт
										output wire T_dat,//Интервал данных
										output wire T_stop,//Стоп такт
										output wire ce_stop,//Конец кадра
										output reg [7:0] sr_dat=0//Регистр сдвига данных
										 );
										 
parameter Fclk=50000000 ; //50 MHz
parameter VEL = 115200 ; //115.2 kBod (из таблицы 1 вариантов)
parameter Nt = Fclk/VEL ; //434

reg [15:0]cb_tact=0 ;							//Счетчик такта 	
assign ce_tact = (cb_tact==Nt) ;				//Строб такта
assign T_start=((cb_bit==0) & en_tx_byte);//Старт такт  
assign T_dat = (cb_bit<9) & (cb_bit>0);	//Интервал данных
assign T_stop = (cb_bit==9) ;					//Стоп такт
assign ce_stop = T_stop & ce_tact ;			//Строб стопа
assign TXD = T_start? 0 : T_dat? sr_dat[0] : 1 ;//Последовательные данные
wire start = st & !en_tx_byte ;
always @ (posedge clk) begin
cb_tact <= (start | ce_tact)? 1 : cb_tact+1 ;
en_tx_byte  <= st? 1 : ce_stop? 0 : en_tx_byte ; 
cb_bit <= start? 0 : (ce_tact & en_tx_byte)? cb_bit+1 : cb_bit ;
sr_dat <= (T_start & ce_tact)? dat : (T_dat & ce_tact)? sr_dat>>1 : sr_dat ; 
end
endmodule



