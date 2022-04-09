`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 12:30:06
// Design Name: 
// Module Name: TOP
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


module TOP(
    input clk,
    input rst
    );
  /*以下为控制信号声明*/
    wire RegWrite,MemtoReg,MemWrite,ALUSrc,RegDst,Branch,Jump;
    wire RegWrite_EX,MemtoReg_EX,MemWrite_EX,ALUSrc_EX,RegDst_EX;
    wire [2:0] ALUop,ALUop_EX;
    wire RegWrite_MEM,MemtoReg_MEM,MemWrite_MEM;
    wire RegWrite_WB,MemtoReg_WB;
 /*以下声明了相关模块的输出信号*/
    wire PC_EN, R_IF_ID_EN, SEL_RD1, SEL_RD2, R_ID_EX_CLEAR,  R_IF_ID_CLEAR;//两个清除寄存器信号也在此处声明
    wire [1:0] SEL_ALU1, SEL_ALU2;  
 /*以下为取指段需要用到的信号以及5位长的信号的声明*/
    wire [1:0] pc_sel;
    wire [31:0] pc_in, pc_out, pc_4, pc_branch, pc_jump, instruction, npc;
    wire [5:0] op;
    wire [4:0] rs,rt,rd, rs_EX, rt_EX, rd_EX, WriteReg_EX, WriteReg_MEM, WriteReg_WB;
    wire [15:0] addr_immediate;
    wire [27:0] jumpaddr_28bit; 
  /*以下为译码段产生的信号声明*/
    wire [31:0] RD1,RD2,sign_ext_imm_ID,RD1_ID,RD2_ID;
    wire beq_equal;
  /*以下为EX阶段信号声明*/
    wire [31:0] RD1_EX,RD2_EX,sign_ext_imm_EX;
    wire [31:0] ALU_in1,ALU_in2, ALUout_EX;
    wire [31:0] WriteData_EX;
  /*以下为MEM段信号声明*/
    wire [31:0] ALUout_MEM, WriteData_MEM, ReadData_MEM;
  /*以下为WB段信号声明*/
    wire [31:0] ReadData_WB, ALUout_WB, WB_DATA;
  
 
    Instruction_Memory INS_MEM (pc_out, instruction);
    PC pc (clk, rst, pc_in, pc_out, PC_EN);
    R_IF_ID  R_IF_ID(clk, rst, R_IF_ID_CLEAR, R_IF_ID_EN, instruction, pc_4, op, rs, rt, rd, addr_immediate, jumpaddr_28bit, npc);
    Register_File #(32) RF (.clk(clk), .ra1(rs), .ra2(rt), .wa(WriteReg_WB), .RegWrite(RegWrite_WB), .wd(WB_DATA), .rd1(RD1), .rd2(RD2));
    Sign_Extend Sign_Extend (addr_immediate, sign_ext_imm_ID);
    R_ID_EX R_ID_EX (clk, rst, R_ID_EX_CLEAR, RegDst, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite, RegDst_EX, MemtoReg_EX, ALUop_EX,
          MemWrite_EX, ALUSrc_EX, RegWrite_EX, RD1_ID, RD2_ID, RD1_EX, RD2_EX, rs, rt, rd, rs_EX, rt_EX, rd_EX, sign_ext_imm_ID,sign_ext_imm_EX);
    ALU #(32) ALU(ALU_in1, ALU_in2, ALUop_EX, ALUout_EX);
    R_EX_MEM R_EX_MEM (clk, rst, RegWrite_EX, MemtoReg_EX, MemWrite_EX, ALUout_EX, WriteData_EX, WriteReg_EX, RegWrite_MEM, MemtoReg_MEM,
          MemWrite_MEM, ALUout_MEM, WriteData_MEM, WriteReg_MEM);
    Data_Memory DATA_MEM (clk, ALUout_MEM, WriteData_MEM, MemWrite_MEM, ReadData_MEM);
    R_MEM_WB  R_MEM_WB (clk, rst, RegWrite_MEM, MemtoReg_MEM, ReadData_MEM, ALUout_MEM, WriteReg_MEM, RegWrite_WB, MemtoReg_WB, ReadData_WB, ALUout_WB, WriteReg_WB);
    Control_Unit Control_Unit (op, RegDst, Jump, Branch, MemtoReg, ALUop, MemWrite, ALUSrc, RegWrite);
    Hazard_unit Hazard (Branch, MemtoReg_EX, RegWrite_EX, MemtoReg_MEM, RegWrite_MEM, RegWrite_WB, rs, rt, rs_EX, rt_EX, WriteReg_EX, WriteReg_MEM,
          WriteReg_WB, PC_EN, R_IF_ID_EN, SEL_RD1, SEL_RD2, R_ID_EX_CLEAR, SEL_ALU1, SEL_ALU2);
    MUX_4 #(32) MUX_PC (pc_4, {sign_ext_imm_ID[29:0],2'b00}+npc, {npc[31:28],jumpaddr_28bit}, 32'h0, pc_sel, pc_in);
    MUX_2 #(32) MUX_RD1 (RD1, ALUout_MEM, SEL_RD1, RD1_ID);
    MUX_2 #(32) MUX_RD2 (RD2, ALUout_MEM, SEL_RD2, RD2_ID);
    MUX_2 #(32) MUX_RegDst_EX (rt_EX, rd_EX, RegDst_EX, WriteReg_EX);
    MUX_4 #(32) MUX_ALU1 (RD1_EX, WB_DATA, ALUout_MEM, 32'h0, SEL_ALU1, ALU_in1);
    MUX_4 #(32) MUX_ALU2 (RD2_EX, WB_DATA, ALUout_MEM, 32'h0, SEL_ALU2, WriteData_EX);
    MUX_2 #(32) MUX_ALUSrc_EX (WriteData_EX, sign_ext_imm_EX, ALUSrc_EX, ALU_in2);
    MUX_2 #(32) MUX_MemtoReg_WB (ALUout_WB, ReadData_WB, MemtoReg_WB, WB_DATA);
    
    
    reg beq_equal_reg;
     initial beq_equal_reg=0;
    always@(*)begin
      if((MemtoReg_MEM==1)&&(MemtoReg_EX==1)) beq_equal_reg = 0;
      else if((MemtoReg_MEM==1)&&(MemtoReg_WB==1)) beq_equal_reg = 0;//(ReadData_MEM==WB_DATA)? 1:0;
      else begin
        if(RD1_ID==RD2_ID) beq_equal_reg=1;
        else beq_equal_reg=0;
      end
    end
    
    assign beq_equal = beq_equal_reg;
    assign pc_4 = pc_out+32'h4;
    assign pc_sel = {Jump,Branch&beq_equal};
    assign R_IF_ID_CLEAR = Jump|(Branch&beq_equal);
    
endmodule
