`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 16:25:31
// Design Name: 
// Module Name: DIY_RAM
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

module DIY_RAM             //16x8λ���˿�RAM
    (input clk,             //ʱ��(��������Ч)
     input en,we,           //ʹ�ܣ�дʹ��
     input [3:0] addr,      //��ַ
     input [7:0] din,       //��������
     output [7:0] dout      //�������
    );
    reg [3:0] addr_reg;
    reg [7:0] mem[15:0];
    
    //��ʼ��RAM������
   /* initial
        $readmemb("init.txt",mem);*/
    
    assign dout = mem[addr_reg];
    
    always @(posedge clk)begin
        if(en)begin
            addr_reg <= addr;
            if(we)
                mem[addr] <= din;
        end
    end
endmodule