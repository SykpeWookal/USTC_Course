`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
// Design Name: 
// Module Name: MUX_4
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


module MUX_4
   #(parameter N = 32)
   (
    input [N-1:0] in_0,
    input [N-1:0] in_1,
    input [N-1:0] in_2,
    input [N-1:0] in_3,
    
    input [1:0] sel,
    output [N-1:0] out
    );
    
    assign out = sel[1]? (sel[0]? in_3:in_2):(sel[0]? in_1:in_0);
    
endmodule
