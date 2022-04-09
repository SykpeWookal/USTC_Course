`timescale 1ns / 1ps
module DBU_sim( );
    reg clk,rst;
    reg succ,step,m_rf,inc,dec;
    reg [2:0] sel;
    wire [11:0] led;
    wire [7:0] SSEG_AN,SSEG_CA;
    parameter PERIOD = 10,
               CYCLE = 100;
    DBU TEST (.clk(clk), .rst(rst), .succ(succ), .step(step), .m_rf(m_rf), .inc(inc), .dec(dec), .sel(sel), .led(led), .SSEG_AN(SSEG_AN), .SSEG_CA(SSEG_CA));
    
    initial
    begin
        clk = 1;
        repeat (2 * CYCLE)
            #(PERIOD/2) clk = ~clk;
        $finish;
    end
    
    initial
    begin
        rst = 1;succ = 1;step = 0;sel = 3'b000;inc = 0;dec = 0;m_rf = 0;    //连续运行，查看寄存器堆地址0的内容
        #PERIOD
        rst = 0;m_rf = 1;       //查看存储器地址0的内容
        #(PERIOD)
        inc = 1;                //查看存储器地址1的内容
        #(PERIOD)
        inc = 0;
        #(PERIOD)
        succ = 0;sel = 3'b001;      //改为按步运行，并选择查看pc1的数据
        #(PERIOD*8)
        sel = 3'b010;           //查看pc的数据
        #(PERIOD*8)
        sel = 3'b011;           //查看instr的数据
        #(PERIOD*8)
        sel = 3'b100;           //查看alu_a的数据
        #(PERIOD*8)
        sel = 3'b101;           //查看writedata的数据
        #(PERIOD*8)
        sel = 3'b110;           //查看alu_result的数据
        #(PERIOD*8)
        sel = 3'b111;           //查看read_data的数据
        #(PERIOD*8)
        sel = 3'b000;step = 1;  //回到查看运行结果
        #(PERIOD)
        inc = 1;m_rf = 0;step = 0;      //查看寄存器堆地址2的内容
        #(PERIOD*8)
        inc = 0;dec = 1;m_rf = 1;        //查看寄存器堆地址2的内容
        #(PERIOD)
        inc = 0;dec = 0;
    end
endmodule
