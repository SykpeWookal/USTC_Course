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

module DIY_RAM             //16x8位单端口RAM
    (input clk,             //时钟(上升沿有效)
     input en,we,           //使能，写使能
     input [3:0] addr,      //地址
     input [7:0] din,       //输入数据
     output [7:0] dout      //输出数据
    );
    reg [3:0] addr_reg;
    reg [7:0] mem[15:0];
    
    //初始化RAM的内容
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