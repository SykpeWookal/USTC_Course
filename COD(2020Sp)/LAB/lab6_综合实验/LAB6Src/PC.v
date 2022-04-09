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
    input clk,
    input rst,
    input PC_EN,
    input [31:0] addr,
    output [31:0] pc_next
    );
    
    reg [31:0] pc_reg;
    initial pc_reg=32'h00000000;
    
    always@(posedge clk or posedge rst)begin
       if(rst) pc_reg<=32'h00000000;
       else begin
          if(PC_EN) pc_reg<=addr;
          else pc_reg<=pc_reg;
       end
    end
    
    assign pc_next=pc_reg;
    
endmodule
