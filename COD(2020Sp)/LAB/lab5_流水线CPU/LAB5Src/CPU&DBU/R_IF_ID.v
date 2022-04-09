`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 12:29:47
// Design Name: 
// Module Name: R_IF_ID
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


module R_IF_ID(
    input clk,
    input rst,
    input clear, //清除段内数据
    input IRWrite,
    input [31:0] instruction,
    input [31:0] pc_4,
    
    output [5:0] op,   
    output [4:0] rs, rt, rd,  
    output [15:0] addr_immediate,
    output [27:0] jumpaddr_28bit, //最低两位补0，top模块就不需要左移
    
    output [31:0] npc
    );
    
   reg [31:0] instruction_reg,npc_reg;
    initial instruction_reg=0;
    initial npc_reg=0;
    
    always@(posedge clk or posedge rst) begin
      if(rst||clear) begin 
         instruction_reg<=0;
         npc_reg<=0;       
       end
      else begin
         if(IRWrite) begin
           instruction_reg<=instruction;
           npc_reg<=pc_4;
          end
         else begin
           instruction_reg<=instruction_reg;
           npc_reg<=npc_reg;
          end
       end
    end
    
    
    assign op=instruction_reg[31:26];
    assign rs=instruction_reg[25:21];
    assign rt=instruction_reg[20:16];
    assign rd=instruction_reg[15:11];
    assign addr_immediate=instruction_reg[15:0];
    assign jumpaddr_28bit={instruction_reg[25:0],2'b00};
    assign npc = npc_reg;
    
endmodule
