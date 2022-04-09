`timescale 1ns / 1ps
module testbench_sort( );
    reg clk,rst;
    reg [3:0] x0,x1,x2,x3;
    wire [3:0] s0,s1,s2,s3;
    wire done;
    parameter PERIOD = 10,      //时钟周期长度
               CYCLE = 30;      //时钟个数
    sort #(4) SORT(s0,s1,s2,s3,done,x0,x1,x2,x3,clk,rst);
    
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
        x0 = 3;
        x1 = 7;
        x2 = 6;
        x3 = 1;
        
        #(PERIOD*8)
        x0 = 10;
        x1 = 8;
        x2 = 15;
        x3 = 4;
        
        #(PERIOD*8)
        x0 = 2;
        x1 = 9;
        x2 = 4;
        x3 = 6;
    end
endmodule
