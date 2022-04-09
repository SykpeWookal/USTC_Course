`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/01 08:10:38
// Design Name: 
// Module Name: BUS_CONTROL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BUS_CONTROL(
    //input clk,  //接入系统100MHz时钟
    
    input [31:0] IO_DATA_din,  //从键盘接收到的32位mips指令
	input readIO_finished_in, //标志是否已经从IO读取到完整的数据，若为1，则将此数据送入CPU指令存储器
                              //din0-din16总线控制器接收的I/O信号
	
	//output keyboard_en,
	output [31:0] IO_DATA_dout,//从键盘接收到的32位mips指令
	//output PC_EN,
	output readIO_finished_out //标志是否已经从IO读取到完整的数据，若为1，则将此数据送入CPU指令存储器
    );
 
    
  assign   IO_DATA_dout = IO_DATA_din;
  assign   readIO_finished_out = readIO_finished_in;
    
endmodule
