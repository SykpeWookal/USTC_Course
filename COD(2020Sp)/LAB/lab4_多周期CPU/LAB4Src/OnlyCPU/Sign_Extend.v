`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
// Design Name: 
// Module Name: Sign_Extend
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


module Sign_Extend(
    input [15:0] immediate,
   // input Ext_en, 用于选择零扩展或符号扩展
    output [31:0] out
    );
    assign out[15:0] = immediate;  // 后16位存储立即数
    assign out[31:16] =immediate[15]?  16'hffff : 16'h0000;
   
   // assign out[31:16] = Ext_en? (immediate[15]? 16'hffff : 16'h0000) : 16'h0000; //此句可以实现零扩展和符号扩展的选择 
    
endmodule
