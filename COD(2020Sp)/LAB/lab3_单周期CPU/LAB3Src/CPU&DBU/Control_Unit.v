`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [5:0] op,
    
    output RegDst,
    output Jump,
    output Branch,
    output MemtoReg,
    output [2:0] ALUop,
    output MemWrite,
    output ALUSrc,
    output RegWrite
    );
    
    localparam ADD=6'b000000, ADDI=6'b001000, LW=6'b100011, SW=6'b101011, BEQ=6'b000100, J=6'b000010;
    
    assign RegDst = (op==ADD)?  1:0 ;
    assign Jump = (op==J)?  1:0;
    assign Branch = (op==BEQ)? 1:0;
    assign MemtoReg = (op==LW)? 1:0;
    assign ALUop = (op==BEQ)? 3'b001:3'b000;    //BEQ指令作减法，其余指令作加法
    assign MemWrite = (op==SW)? 1:0;
    assign ALUSrc = (op==ADDI || op==LW || op==SW)? 1:0;
    assign RegWrite = (op==ADD || op==ADDI || op==LW)? 1:0;
    
    
endmodule
