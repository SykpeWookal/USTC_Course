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
   // input Ext_en, ����ѡ������չ�������չ
    output [31:0] out
    );
    assign out[15:0] = immediate;  // ��16λ�洢������
    assign out[31:16] =immediate[15]?  16'hffff : 16'h0000;
   
   // assign out[31:16] = Ext_en? (immediate[15]? 16'hffff : 16'h0000) : 16'h0000; //�˾����ʵ������չ�ͷ�����չ��ѡ�� 
    
endmodule
