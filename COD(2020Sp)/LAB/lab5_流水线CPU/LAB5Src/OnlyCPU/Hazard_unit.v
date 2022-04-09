`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 07:56:56
// Design Name: 
// Module Name: Hazard_unit
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


module Hazard_unit(         //相关处理模块，采用纯组合逻辑输出控制信号
    input Branch,
    input MemtoReg_EX,
    input RegWrite_EX,
    input MemtoReg_MEM,
    input RegWrite_MEM,
    input RegWrite_WB,
    input [4:0] rs,rt,rs_EX,rt_EX,WriteReg_EX,WriteReg_MEM,WriteReg_WB,
    
    output PC_EN,           //pc使能控制，若为0则阻塞pc的变化
    output R_IF_ID_EN,      //IF_ID寄存器使能信号
    output SEL_RD1,SEL_RD2,
    output R_ID_EX_CLEAR,   //ID_EX寄存器清除信号
    output [1:0] SEL_ALU1,SEL_ALU2
    );
    
    wire lw_stall,branch_stall;
    
    assign SEL_RD1 = (rs!=0) & (rs==WriteReg_MEM) & RegWrite_MEM;
    assign SEL_RD2 = (rt!=0) & (rt==WriteReg_MEM) & RegWrite_MEM;
    
    reg [1:0] SEL_ALU1_reg,SEL_ALU2_reg;
   always @(*) begin
        SEL_ALU1_reg = 2'b00;
        SEL_ALU2_reg = 2'b00;
      if((rs_EX != 0) && (rs_EX == WriteReg_MEM) && RegWrite_MEM)
           SEL_ALU1_reg = 2'b10;
      else if((rs_EX != 0) && (rs_EX == WriteReg_WB) && RegWrite_WB)
           SEL_ALU1_reg = 2'b01;
      if((rt_EX != 0) && (rt_EX == WriteReg_MEM) && RegWrite_MEM)
           SEL_ALU2_reg = 2'b10;
      else if((rt_EX != 0) && (rt_EX == WriteReg_WB) && RegWrite_WB)
           SEL_ALU2_reg =2'b01;
   end

   assign SEL_ALU1=SEL_ALU1_reg;
   assign SEL_ALU2=SEL_ALU2_reg;

 assign lw_stall = ((rs == rt_EX) | (rt == rt_EX)) & MemtoReg_EX;
 assign branch_stall = (Branch & RegWrite_EX & ((rs == WriteReg_EX) |(rt == WriteReg_EX))) | (Branch & MemtoReg_MEM & ((rs == WriteReg_MEM) |(rt == WriteReg_MEM)));
 assign PC_EN = ~(lw_stall | branch_stall);
 assign R_IF_ID_EN = ~(lw_stall | branch_stall);
 assign R_ID_EX_CLEAR = lw_stall | branch_stall;
    
    
endmodule
