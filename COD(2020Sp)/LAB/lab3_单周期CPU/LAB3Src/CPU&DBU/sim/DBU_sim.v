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
        rst = 1;succ = 1;step = 0;sel = 3'b000;inc = 0;dec = 0;m_rf = 0;    //�������У��鿴�Ĵ����ѵ�ַ0������
        #PERIOD
        rst = 0;m_rf = 1;       //�鿴�洢����ַ0������
        #(PERIOD)
        inc = 1;                //�鿴�洢����ַ1������
        #(PERIOD)
        inc = 0;
        #(PERIOD)
        succ = 0;sel = 3'b001;      //��Ϊ�������У���ѡ��鿴pc1������
        #(PERIOD*8)
        sel = 3'b010;           //�鿴pc������
        #(PERIOD*8)
        sel = 3'b011;           //�鿴instr������
        #(PERIOD*8)
        sel = 3'b100;           //�鿴alu_a������
        #(PERIOD*8)
        sel = 3'b101;           //�鿴writedata������
        #(PERIOD*8)
        sel = 3'b110;           //�鿴alu_result������
        #(PERIOD*8)
        sel = 3'b111;           //�鿴read_data������
        #(PERIOD*8)
        sel = 3'b000;step = 1;  //�ص��鿴���н��
        #(PERIOD)
        inc = 1;m_rf = 0;step = 0;      //�鿴�Ĵ����ѵ�ַ2������
        #(PERIOD*8)
        inc = 0;dec = 1;m_rf = 1;        //�鿴�Ĵ����ѵ�ַ2������
        #(PERIOD)
        inc = 0;dec = 0;
    end
endmodule
