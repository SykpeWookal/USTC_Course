`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 10:30:45
// Design Name: 
// Module Name: MEM_DATA_REGISTER
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


module MEM_DATA_REGISTER(  //存储memory中读出的内容（数据）
    input clk,   //时序模块
    
    input [31:0] in,
    output [31:0] out
    );
    
    reg [31:0] in_reg;
    initial in_reg=0;
    
    always@(posedge clk)begin
       in_reg<=in;
    end
    
    assign out=in_reg;
    
endmodule
