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


module KeyBoard_IO(
    input clk,  //接入系统100MHz时钟
    
    input  PRESS_0,
	input  PRESS_1,
	input  PRESS_2,
	input  PRESS_3,
	input  PRESS_4,
	input  PRESS_5,
	input  PRESS_6,
	input  PRESS_7,
	input  PRESS_8,
	input  PRESS_9,
	input  PRESS_A,
	input  PRESS_B,
	input  PRESS_C,
	input  PRESS_D,
	input  PRESS_E,
	input  PRESS_F,
	input  PRESS_ENTER,  //din0-din16总线控制器接收的I/O信号
	
	//output keyboard_en,
	output [31:0] IO_DATA,//从键盘接收到的32位mips指令
	//output PC_EN,
	output readIO_finished, //标志是否已经从IO读取到完整的数据，若为1，则将此数据送入CPU指令存储器
	output SSEG_MODE
    );
    
    reg [2:0] count;
    initial count=0;
    
    reg [31:0] IO_DATA_reg;
    reg readIO_finished_reg;
    initial readIO_finished_reg=0;
    initial IO_DATA_reg=0;
    
  always@(posedge clk) begin
    if(PRESS_0) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0000;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0000;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0000;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0000;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0000;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0000;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0000;
       else                   IO_DATA_reg[3:0]<=4'b0000;      
       count<=count+1;
     end
    else if(PRESS_1) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0001;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0001;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0001;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0001;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0001;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0001;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0001;
       else                   IO_DATA_reg[3:0]<=4'b0001;      
       count<=count+1;
     end
    else if(PRESS_2) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0010;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0010;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0010;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0010;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0010;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0010;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0010;
       else                   IO_DATA_reg[3:0]<=4'b0010;      
       count<=count+1;
     end
    else if(PRESS_3) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0011;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0011;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0011;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0011;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0011;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0011;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0011;
       else                   IO_DATA_reg[3:0]<=4'b0011;      
       count<=count+1;
     end
    else if(PRESS_4) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0100;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0100;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0100;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0100;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0100;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0100;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0100;
       else                   IO_DATA_reg[3:0]<=4'b0100;      
       count<=count+1;
     end
    else if(PRESS_5) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0101;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0101;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0101;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0101;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0101;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0101;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0101;
       else                   IO_DATA_reg[3:0]<=4'b0101;      
       count<=count+1;
     end
    else if(PRESS_6) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0110;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0110;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0110;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0110;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0110;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0110;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0110;
       else                   IO_DATA_reg[3:0]<=4'b0110;      
       count<=count+1;
     end
    else if(PRESS_7) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b0111;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b0111;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b0111;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b0111;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b0111;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b0111;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b0111;
       else                   IO_DATA_reg[3:0]<=4'b0111;      
       count<=count+1;
     end
    else if(PRESS_8) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1000;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1000;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1000;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1000;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1000;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1000;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1000;
       else                   IO_DATA_reg[3:0]<=4'b1000;      
       count<=count+1;
     end
    else if(PRESS_9) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1001;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1001;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1001;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1001;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1001;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1001;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1001;
       else                   IO_DATA_reg[3:0]<=4'b1001;      
       count<=count+1;
     end
    else if(PRESS_A) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1010;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1010;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1010;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1010;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1010;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1010;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1010;
       else                   IO_DATA_reg[3:0]<=4'b1010;      
       count<=count+1;
     end
    else if(PRESS_B) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1011;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1011;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1011;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1011;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1011;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1011;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1011;
       else                   IO_DATA_reg[3:0]<=4'b1011;      
       count<=count+1;
     end
    else if(PRESS_C) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1100;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1100;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1100;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1100;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1100;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1100;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1100;
       else                   IO_DATA_reg[3:0]<=4'b1100;      
       count<=count+1;
     end
    else if(PRESS_D) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1101;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1101;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1101;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1101;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1101;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1101;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1101;
       else                   IO_DATA_reg[3:0]<=4'b1101;      
       count<=count+1;
     end
    else if(PRESS_E) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1110;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1110;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1110;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1110;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1110;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1110;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1110;
       else                   IO_DATA_reg[3:0]<=4'b1110;      
       count<=count+1;
     end
    else if(PRESS_F) begin
       if     (count==3'b000) IO_DATA_reg[31:28]<=4'b1111;
       else if(count==3'b001) IO_DATA_reg[27:24]<=4'b1111;
       else if(count==3'b010) IO_DATA_reg[23:20]<=4'b1111;
       else if(count==3'b011) IO_DATA_reg[19:16]<=4'b1111;
       else if(count==3'b100) IO_DATA_reg[15:12]<=4'b1111;
       else if(count==3'b101) IO_DATA_reg[11:8]<=4'b1111;
       else if(count==3'b110) IO_DATA_reg[7:4]<=4'b1111;
       else                   IO_DATA_reg[3:0]<=4'b1111;      
       count<=count+1;
     end
    else begin 
      count<=count; IO_DATA_reg<=IO_DATA_reg;
    end
    
    if(count==3'b000) begin
       readIO_finished_reg<=1;
     end
    else readIO_finished_reg<=0;
    
  end
    
    wire readIO_finished_edge;
    reg readIO_finished_r1,readIO_finished_r2;
     always@(posedge clk)
       readIO_finished_r1 <= readIO_finished_reg;
     always@(posedge clk)
       readIO_finished_r2 <= readIO_finished_r1;
    
    assign readIO_finished_edge = readIO_finished_r1 & (~readIO_finished_r2);
 
    
  assign   IO_DATA = IO_DATA_reg;
  assign   readIO_finished = readIO_finished_edge;
  assign   SSEG_MODE = (PRESS_ENTER)? 1:0;  
    
endmodule
