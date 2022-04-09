`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
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
    input rst,
    
   input  [8:0] m_rf_addr_DBU,
   output [31:0] m_data_DBU,
   
   output [31:0] rf_data_DBU,
   
   output [31:0] pc_out_DBU,//传出pc的内容
   output [31:0] IR_DBU,//指令寄存器的数据
   output [31:0] MD_DBU,//存储器读出数据寄存器
   output [31:0] rf_A_DBU,//寄存器堆读出寄存器A的数据
   output [31:0] rf_B_DBU,//寄存器堆读出寄存器B的数据
   output [31:0] aluout_DBU,//ALU的运算结果
  // output [31:0] m_rd_DBU,
   
   output [1:0] PCSourse,
   output PCwe,IorD,MemWrite,IRWrite,RegDst,MemtoReg,RegWrite,
   output [2:0] ALUop,
   output ALUSrcA,
   output [1:0] ALUSrcB,
   output zero
    );
    
   // wire PCwe;
    wire [31:0] pc_in, pc_out, aluout, memdata, RA, RB, mdr_out, writedata, sign_ext_imm, rdA, rdB, result, alu_in0,alu_in1;
    wire [7:0] memaddr;//未加最高位，最高位=1为数据，=0为指令
    
    wire PCWriteCond, PCWrite/*, IorD, MemWrite,  MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst,  zero*/;
    wire [1:0] PCSourse,ALUSrcB;
  //  wire [2:0] ALUop;
    
    wire [5:0] op;
    wire [4:0] rs, rt, rd, writeregister;
    wire [15:0] addr_immediate;
    wire [27:0] jumpaddr_28bit;
    
    PC programcounter(clk,rst,PCwe,pc_in,pc_out);
    MUX_2 #(8) MUX_IorD(.in_0(pc_out[9:2]), .in_1(aluout[9:2]), .sel(IorD), .out(memaddr));
    Memory MEM (clk, {1'b0,memaddr}, MemWrite, RB, memdata, m_rf_addr_DBU, m_data_DBU);
    INS_Register INS_R (clk,rst,memdata,IRWrite, op,rs,rt,rd,addr_immediate,jumpaddr_28bit);
    MEM_DATA_REGISTER MDR (clk,memdata,mdr_out);
    MUX_2 #(5) MUX_RegDst(.in_0(rt), .in_1(rd), .sel(RegDst), .out(writeregister));
    MUX_2 #(32) MUX_MemtoReg(.in_0(aluout), .in_1(mdr_out), .sel(MemtoReg), .out(writedata));
    Sign_Extend SE (addr_immediate,sign_ext_imm);
    Register_File #(32) RF (clk,rs,rdA,rt,rdB,writeregister,RegWrite,writedata,m_rf_addr_DBU[4:0],rf_data_DBU);
    REG_32Bit A (clk,rst,rdA,RA);
    REG_32Bit B (clk,rst,rdB,RB);
    MUX_2 #(32) MUX_ALUSrcA (.in_0(pc_out), .in_1(RA), .sel(ALUSrcA), .out(alu_in0));
    MUX_4 #(32) MUX_ALUSrcB (.in_0(RB), .in_1(32'h00000004), .in_2(sign_ext_imm), .in_3(sign_ext_imm<<2), .sel(ALUSrcB), .out(alu_in1));
    ALU #(32) alu (.in0(alu_in0), .in1(alu_in1), .ALUop(ALUop), .zero(zero), .result(result));
    REG_32Bit ALUOut (clk,rst,result,aluout);
    MUX_4 #(32) MUX_PCSourse (.in_0(result), .in_1(aluout), .in_2({pc_out[31:28],jumpaddr_28bit}), .in_3(32'h0), .sel(PCSourse), .out(pc_in));
     wire ppcc;
    and A1 (ppcc,zero,PCWriteCond);
    or A2 (PCwe,ppcc,PCWrite);
    
    Control_Unit control (clk,rst,op,PCWriteCond, PCWrite, IorD, MemWrite,  MemtoReg, IRWrite, PCSourse, ALUop, ALUSrcB, ALUSrcA, RegWrite, RegDst);
    
    assign pc_out_DBU = pc_out;
    assign IR_DBU = {op,rs,rt,addr_immediate};
    assign rf_A_DBU = RA;
    assign rf_B_DBU = RB;
    assign aluout_DBU=result;
    assign MD_DBU = mdr_out;
    
    
endmodule
