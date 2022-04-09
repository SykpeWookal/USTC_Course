`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/04 15:34:42
// Design Name: 
// Module Name: Register_File
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


module Register_File
  #(parameter WIDTH=32)
   (
    input clk,                 //clock
    input [4:0] ra0,           //���˿�0��ַ
    output [WIDTH-1:0] rd0,    //���˿�0����
    input [4:0] ra1,           //���˿�1��ַ
    output [WIDTH-1:0] rd1,   //���˿�1����
    input [4:0] wa,           //д�˿ڵ�ַ
    input we,                 //дʹ�ܣ��ߵ�ƽ��Ч
    input [WIDTH-1:0] wd      //д�˿�����
    );    //�첽�� ͬ��д
    
    reg [WIDTH-1:0] register[31:0];
    
     always @(posedge clk)begin
        if(we)begin
            register [wa] <= wd;
        end
    end
    
    assign rd0 = register[ra0];
    assign rd1 = register[ra1];


endmodule


