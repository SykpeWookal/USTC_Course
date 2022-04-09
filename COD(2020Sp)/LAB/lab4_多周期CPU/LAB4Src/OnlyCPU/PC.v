`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,  //时序模块
    input rst,  //异步复位
    input PCwe,
    
    input [31:0] pc_in,  //输入pc的值
    output [31:0] pc_out //输出pc的值
    );
    
    reg [31:0] pc_reg;
    initial pc_reg=32'h00000000;
    
    always@(posedge clk or posedge rst)begin
       if(rst) pc_reg<=32'h00000000;
       else  
         if(PCwe) pc_reg<=pc_in;
         else pc_reg<=pc_reg;
    end
    
    assign pc_out=pc_reg;
    
endmodule
