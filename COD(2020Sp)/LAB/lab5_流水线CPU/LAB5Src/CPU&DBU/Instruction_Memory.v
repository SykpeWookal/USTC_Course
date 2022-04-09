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
    output [31:0] instruction 
    );
    
    wire [7:0] addr;
    assign addr=pc[9:2];
    
    INS_MEM_256D_32bit INSMEM ( .a(addr),  .spo(instruction) );
    
endmodule
