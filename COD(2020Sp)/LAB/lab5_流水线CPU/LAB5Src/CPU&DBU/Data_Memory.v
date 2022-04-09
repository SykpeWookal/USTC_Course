`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input clk,
    input [31:0] addr,
    input [31:0] writedata,
    //input mem_read,
    input mem_write,
    output [31:0] readdata,
    
    input [7:0] addr_DBU,
    output [31:0] READ_DATA_DBU
    );
    
    wire [7:0] mem_addr;
    wire [23:0] x;
    assign {x,mem_addr} = (addr>>2);
    DATA_MEM_256D_32bit DATAMEM ( .a(mem_addr), .d(writedata), .we(mem_write), .clk(clk), .spo(readdata), .dpra(addr_DBU), .dpo(READ_DATA_DBU));
    
endmodule
