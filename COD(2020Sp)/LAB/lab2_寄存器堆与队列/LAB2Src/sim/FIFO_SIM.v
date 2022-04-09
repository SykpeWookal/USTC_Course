`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 15:11:32
// Design Name: 
// Module Name: FIFO_SIM
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


module FIFO_SIM();
  reg clk,rst;
  reg [7:0] din;
  reg en_in,en_out;
  wire [7:0] dout;
  wire [4:0] count;
  wire [1:0] state;
  
  parameter PERIOD = 10,      //时钟周期长度
               CYCLE = 30;      //时钟个数
    FIFO TEST (clk,rst,din,en_in,en_out,dout,count,state);
    
  initial
    begin
        clk = 0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk = ~clk;
        $finish;
  end
  
  initial
    begin
        rst = 1;
        #PERIOD rst = 0;
        
        #(PERIOD*8) rst = 1;
        #PERIOD rst = 0;
        
        #(PERIOD*8) rst = 1;
        #PERIOD rst = 0;
    end

  initial
    begin
      din=8'b01010011;
      en_in=0;en_out=0;
      #(PERIOD)
        en_in=1;
      #(PERIOD)
        en_in=0;
      #(PERIOD)
        en_in=1;
      #(PERIOD)
        en_in=0;
      #(PERIOD)
        en_out=1;
      #(PERIOD)
        en_out=0;
      #(PERIOD*9)
        en_in=1;
      #(PERIOD)
        en_in=0;
      #(PERIOD*3)
        en_in=1;
      #(PERIOD)
        en_in=0;
      #(PERIOD*3)
        en_in=1;
      #(PERIOD)
        en_in=0;
      #(PERIOD)
        en_out=1;
      #(PERIOD)
        en_out=0;
    end
endmodule
