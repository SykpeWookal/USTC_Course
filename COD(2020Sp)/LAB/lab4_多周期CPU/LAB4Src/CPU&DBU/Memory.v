`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
// Design Name: 
// Module Name: Memory
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


module Memory(
    input clk,   //ʱ��ģ��
    input [8:0] mem_addr,
    input MemWrite,
    input [31:0] WriteData,
    output [31:0] MemData,
    
    input  [8:0] m_rf_addr_DBU,
    output [31:0] m_data_DBU
    
    );
    
    MEM_512D_32Bit MEM(.a(mem_addr), .clk(clk), .d(WriteData), .we(MemWrite), .spo(MemData), .dpra(m_rf_addr_DBU), .dpo(m_data_DBU));
    
endmodule
