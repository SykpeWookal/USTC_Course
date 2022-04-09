`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
// Design Name: 
// Module Name: INS_Register
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


module INS_Register(
    input clk,  //时序模块
    input rst,
    
    input [31:0] instruction,   
    input IRWrite,
    
    output [5:0] op,   
    output [4:0] rs, rt, rd,
    output [15:0] addr_immediate,
    output [27:0] jumpaddr_28bit //最低两位补0，top模块就不需要左移
    );

    reg [31:0] instruction_reg;
    initial instruction_reg=0;
    
    always@(posedge clk or posedge rst) begin
      if(rst) instruction_reg<=0;
      else 
        if(IRWrite) instruction_reg<=instruction;
        else instruction_reg<=instruction_reg;
    end
    
    assign op=instruction_reg[31:26];
    assign rs=instruction_reg[25:21];
    assign rt=instruction_reg[20:16];
    assign rd=instruction_reg[15:11];
    assign addr_immediate=instruction_reg[15:0];
    assign jumpaddr_28bit={instruction_reg[25:0],2'b00};
    
endmodule
