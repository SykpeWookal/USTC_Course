`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 11:15:13
// Design Name: 
// Module Name: REGISTER_32bit
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


module REGISTER
 #(parameter WIDTH = 4)
   (
    input [WIDTH-1:0] in,
    input en,
    input clk,
    input rst,
    output reg [WIDTH-11:0] out
    );
    
    always@(posedge clk)begin
      if(rst==1)  out<=0;
      else begin
        if(en==1) out<=in;
        else out<=out;
      end
    end
    
endmodule
