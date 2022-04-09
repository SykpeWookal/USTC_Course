`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input [31:0] pc,   
    output [5:0] op,   
    output [4:0] rs, rt, rd,  
    output [15:0] addr_immediate,
    output [27:0] jumpaddr_28bit //最高两位补0
    );
    
    wire [31:0] instruction;
    wire [7:0] addr;
    assign addr=pc[9:2];
    
    INS_MEM_256d_32b INSMEM ( .a(addr),  .spo(instruction) );
    
    assign op=instruction[31:26];
    assign rs=instruction[25:21];
    assign rt=instruction[20:16];
    assign rd=instruction[15:11];
    assign addr_immediate=instruction[15:0];
    assign jumpaddr_28bit={2'b00,instruction[25:0]};
    
endmodule
