`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 13:43:39
// Design Name: 
// Module Name: REG_32Bit
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


module REG_32Bit(
    input clk,
    input rst,
    
    input [31:0] in,
    output [31:0] out
    );
    
    reg [31:0] in_reg;
    initial in_reg=0;
    
    always@(posedge clk or posedge rst)begin
      if(rst) in_reg<=0;
      else in_reg<=in;
    end
    
    assign out=in_reg;
    
endmodule
