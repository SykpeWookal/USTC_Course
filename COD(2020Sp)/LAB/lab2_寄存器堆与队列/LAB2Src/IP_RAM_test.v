`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 16:27:33
// Design Name: 
// Module Name: IP_RAM_test
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


module IP_RAM_test(
    input clk,
    input [3:0] addr, 	
    input en,	
    input we,		//Ð´Ê¹ÄÜ
    input [7:0] din,
    output [7:0] dout_dist,dout_blk
    );
    
    dist_mem_16depth_8bit dist_test (.a(addr), .d(din), .clk(clk), .we(we), .spo(dout_dist));
    blk_mem_16depth_8bit  blk_test  (.addra(addr), .clka(clk), .dina(din), .douta(dout_blk), .ena(en), .wea(we));
    
endmodule
