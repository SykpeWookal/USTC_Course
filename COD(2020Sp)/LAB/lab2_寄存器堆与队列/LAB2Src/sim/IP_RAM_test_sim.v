`timescale 1ns / 1ps

module IP_RAM_test_sim( );
    reg clk,en,we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout_dist,dout_blk;
    parameter PERIOD = 10,
              CYCLE = 18;
              
    IP_RAM_test TEST(clk,addr,en,we,din,dout_dist,dout_blk);
    
    
   initial
    begin
        clk = 0;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk = ~clk;
        $finish;
    end
    
    initial begin
        en = 1;
        we = 0;
        addr = 4'b0000;
        din = 8'b00000000;
        
        #PERIOD
        addr = 4'b0001;
        
        #PERIOD
        addr = 4'b0010;
        
        #PERIOD
        we = 1;
        addr = 4'b0010;
        din = 8'b10100101;
    end
    
endmodule
