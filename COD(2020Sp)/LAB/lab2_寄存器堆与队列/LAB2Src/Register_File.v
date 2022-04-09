`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/04 15:34:42
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
    input [4:0] ra0,           //读端口0地址
    output [WIDTH-1:0] rd0,    //读端口0数据
    input [4:0] ra1,           //读端口1地址
    output [WIDTH-1:0] rd1,   //读端口1数据
    input [4:0] wa,           //写端口地址
    input we,                 //写使能，高电平有效
    input [WIDTH-1:0] wd      //写端口数据
    );    //异步读 同步写
    
    reg [WIDTH-1:0] register[31:0];
    
     always @(posedge clk)begin
        if(we)begin
            register [wa] <= wd;
        end
    end
    
    assign rd0 = register[ra0];
    assign rd1 = register[ra1];


endmodule


