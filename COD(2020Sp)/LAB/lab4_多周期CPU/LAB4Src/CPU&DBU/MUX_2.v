`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 11:15:13
// Design Name: 
// Module Name: MUX_2
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


module MUX_2
   #(parameter N = 32)
   (
    input [N-1:0] in_0,
    input [N-1:0] in_1,
    input sel,
    output [N-1:0] out
    );
    
    assign out = sel? in_1:in_0;
endmodule
