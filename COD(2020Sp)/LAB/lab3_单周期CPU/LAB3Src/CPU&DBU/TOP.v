`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 14:03:13
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
   
   input  [7:0] m_rf_addr,
   output [31:0] m_data,
   
   output [31:0] rf_data,
   
   output [31:0] pc_in,pc_out,//传入和传出pc的内容
   output [31:0] instr,//指令存储器输出的数据
   output [31:0] rf_rd1,//寄存器堆读口1的数据
   output [31:0] rf_rd2,//寄存器堆读口2的数据
   output [31:0] alu_y,//ALU的运算结果
   output [31:0] m_rd,
   
   output Jump,Branch,RegDst,RegWrite,/*MemRead,*/MemtoReg,MemWrite,
   output [2:0] ALUop,
   output ALUSrc,ALUZero
    );
    
    
    wire [31:0] pc,pc_4,ppcc;//ppcc指分支信号和跳转信号两个MUX中间的pc值
    wire [5:0] op; wire [4:0] rs,rt,rd; wire [15:0] addr_immediate; wire[27:0]jumpaddr_28bit;   //取指模块
    wire RegDst,Jump,Branch,MemtoReg,MemWrite,ALUSrc,RegWrite;  wire [2:0] ALUop;  //控制模块
    wire [4:0] reg_write_addr; wire [31:0] reg_write_data; wire [31:0] rd1,rd2;  //寄存器堆模块
    wire [31:0] sign_ext_imm;   //符号扩展模块
    wire [31:0] alu1; /*ALU下方输入*/  wire zero; wire [31:0] result;
    wire [31:0] mem_read;
    
    wire [31:0] addr;//要传入的pc地址
  
    PC programcounter (.clk(clk), .rst(rst), .addr(addr), .pc_next(pc));
    Instruction_Memory INSMEM (.pc(pc), .op(op), .rs(rs), .rt(rt), .rd(rd), .addr_immediate(addr_immediate), .jumpaddr_28bit(jumpaddr_28bit));
    adder adder1 (pc,32'h00000004,pc_4);
    Control_Unit control (op,RegDst,Jump,Branch,MemtoReg,ALUop,MemWrite,ALUSrc,RegWrite);
    MUX_2 #(5) MUX_RegDst (.in_0(rt), .in_1(rd), .s(RegDst),  .out(reg_write_addr));
    Register_File REGFILE (.clk(clk), .ra1(rs), .ra2(rt), .rd1(rd1), .rd2(rd2), .RegWrite(RegWrite), .wa(reg_write_addr), .wd(reg_write_data), .DBUADDR(m_rf_addr[4:0]), .DBUREAD(rf_data));
    Sign_Extend SE (.immediate(addr_immediate), .out(sign_ext_imm));
    MUX_2 #(32) MUX_ALUSrc (.in_0(rd2), .in_1(sign_ext_imm), .s(ALUSrc),  .out(alu1));
    ALU #(32) ALU (.in0(rd1), .in1(alu1), .ALUop(ALUop), .zero(zero), .result(result));
    Data_Memory DATAMEM (.clk(clk), .addr(result), .mem_write(MemWrite), .readdata(mem_read), .m_rf_addr(m_rf_addr), .m_data(m_data));
    MUX_2 #(32) MUX_MemtoReg (.in_0(result), .in_1(mem_read), .s(MemtoReg), .out(reg_write_data));
    MUX_2 #(32) MUX_BRANCH (.in_0(pc_4), .in_1(pc_4+(sign_ext_imm<<2)), .s(Branch & zero), .out(ppcc));
    MUX_2 #(32) MUX_JUMP (.in_0(ppcc), .in_1({pc_4[31:28],(jumpaddr_28bit<<2)}), .s(Jump), .out(addr));
    
    assign pc_in=addr;
    assign pc_out=pc;
    assign instr={op,rs,rt,addr_immediate};
    assign rf_rd1=rd1;
    assign rf_rd2=rd2;
    assign alu_y=result;
    assign m_rd=mem_read;
    assign ALUZero=zero;
endmodule
