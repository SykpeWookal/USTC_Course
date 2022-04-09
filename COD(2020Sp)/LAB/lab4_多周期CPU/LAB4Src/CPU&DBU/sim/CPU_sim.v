`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 19:35:09
// Design Name: 
// Module Name: CPU_sim
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


module CPU_clock_sim();
   reg clk,rst;
   parameter PERIOD = 10,      //ʱ�����ڳ���
               CYCLE = 150;  
  TOP test(clk,rst);
               
  initial
    begin
        clk = 0;rst=0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk = ~clk;
        $finish;
  end            
endmodule
