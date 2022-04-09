`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 12:29:47
// Design Name: 
// Module Name: R_ID_EX
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


module R_ID_EX(
   input clk,  //时序模块，带异步复位和清零信号
   
   input rst,
   input clear,

    input RegDst,
   // input Jump,
   // input Branch,
    input MemtoReg,
    input [2:0] ALUop,
    input MemWrite,
    input ALUSrc,
    input RegWrite,
    
    output RegDst_EX,
  // output Jump_EX,
  // output Branch_EX,
    output MemtoReg_EX,
    output [2:0] ALUop_EX,
    output MemWrite_EX,
    output ALUSrc_EX,
    output RegWrite_EX,
    
    input [31:0] rd1,
    input [31:0] rd2,
    output [31:0] rd1_EX,
    output [31:0] rd2_EX,
    
    input [4:0] rs,rt,rd,
    output [4:0] rs_EX,rt_EX,rd_EX,
    
    input [31:0] sign_ext_imm,
    output [31:0] sign_ext_imm_EX
    
    );
    
    reg [4:0] rs_reg,  rt_reg,  rd_reg;
    reg [31:0] rd1_reg,  rd2_reg,  sign_ext_imm_reg;
    reg RegDst_reg,   MemtoReg_reg,   ALUSrc_reg,   MemWrite_reg,   RegWrite_reg;
    reg [2:0] ALUop_reg;
    
    initial begin
      rs_reg=0;    rt_reg=0;   rd_reg=0;   rd1_reg=0;   rd2_reg=0;
      sign_ext_imm_reg=0;    RegDst_reg=0;      MemtoReg_reg=0; 
      ALUSrc_reg=0;   MemWrite_reg=0;   RegWrite_reg=0;  ALUop_reg=0;
    end
    
    always@(posedge clk or posedge rst) begin
      if(rst||clear) begin
        rs_reg<=0;    rt_reg<=0;   rd_reg<=0;   rd1_reg<=0;   rd2_reg<=0;
        sign_ext_imm_reg<=0;    RegDst_reg<=0;      MemtoReg_reg<=0; 
        ALUSrc_reg<=0;   MemWrite_reg<=0;   RegWrite_reg<=0;  ALUop_reg<=0;
       end
      else begin
        rs_reg<=rs;    rt_reg<=rt;   rd_reg<=rd;   rd1_reg<=rd1;   rd2_reg<=rd2;
        sign_ext_imm_reg<=sign_ext_imm;    RegDst_reg<=RegDst;      MemtoReg_reg<=MemtoReg; 
        ALUSrc_reg<=ALUSrc;   MemWrite_reg<=MemWrite;   RegWrite_reg<=RegWrite;  ALUop_reg<=ALUop;
       end
    end
    
    assign RegDst_EX = RegDst_reg;
    assign MemtoReg_EX = MemtoReg_reg;
    assign ALUop_EX = ALUop_reg;
    assign MemWrite_EX = MemWrite_reg;
    assign ALUSrc_EX = ALUSrc_reg;
    assign RegWrite_EX = RegWrite_reg;
    
    assign rd1_EX = rd1_reg;
    assign rd2_EX = rd2_reg;
    assign rs_EX = rs_reg;
    assign rt_EX = rt_reg;
    assign rd_EX = rd_reg;
    assign sign_ext_imm_EX = sign_ext_imm_reg;
    
    
endmodule
