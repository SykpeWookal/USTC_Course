`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 20:02:25
// Design Name: 
// Module Name: take_edge_sim
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


module take_edge_sim();
     reg clk,rst,y; 
     wire p; 
      
     Take_edge TEST(clk,rst,y,p); 
     parameter PERIOD = 10, 
               CYCLE = 20; 
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
        y = 1; 
         
        #PERIOD 
        rst = 0; 
        y = 1; 
         
        #(PERIOD/2) 
        y = 0; 
         
        #(PERIOD/2) 
        y = 1; 
         
       #PERIOD 
        y = 1; 
         
        #(PERIOD/4) 
        y = 0; 
         
        #PERIOD 
        y = 1; 
    end 

endmodule
