`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
// Design Name: 
// Module Name: Register_File
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


module Register_File
    #(parameter WIDTH=32)
   (
    input clk,                 //clock
    input [4:0] ra1,           //读端口0地址
    output [WIDTH-1:0] rd1,    //读端口0数据
    input [4:0] ra2,           //读端口1地址
    output [WIDTH-1:0] rd2,   //读端口1数据
    input [4:0] wa,           //写端口地址
    input RegWrite,                 //写使能，高电平有效
    input [WIDTH-1:0] wd      //写端口数据
    );    //异步读 同步写
    
    reg [WIDTH-1:0] register[31:0];
    initial begin
      register[0]=0;register[1]=0;register[2]=0;register[3]=0;register[4]=0;register[5]=0;register[6]=0;register[7]=0;
      register[8]=0;register[9]=0;register[10]=0;register[11]=0;register[12]=0;register[13]=0;register[14]=0;register[15]=0;
      register[16]=0;register[17]=0;register[18]=0;register[19]=0;register[20]=0;register[21]=0;register[22]=0;register[23]=0;
      register[24]=0;register[25]=0;register[26]=0;register[27]=0;register[28]=0;register[29]=0;register[30]=0;register[31]=0;
    end
    
     always @(posedge clk)begin
        if(RegWrite)begin
            if(wa==0) ; //禁止对0号寄存器赋值
            else register [wa] <= wd;
        end
    end
    
    assign rd1 = register[ra1];
    assign rd2 = register[ra2];
endmodule
