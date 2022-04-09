`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 16:10:43
// Design Name: 
// Module Name: CPU_clock_sim
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
   parameter PERIOD = 5,      //时钟周期长度
               CYCLE = 50;  
  TOP test(clk,rst);
               
  initial
    begin
        clk = 0;rst=0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk = ~clk;
        $finish;
  end            
endmodule
