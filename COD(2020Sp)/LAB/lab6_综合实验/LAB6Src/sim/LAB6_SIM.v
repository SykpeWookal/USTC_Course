`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/02 17:10:23
// Design Name: 
// Module Name: LAB6_SIM
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


module LAB6_SIM();
  reg clk, rst, ps2_clk, ps2_data;
  wire [7:0] SSEG_CA,SSEG_AN;
  parameter PERIOD = 5,      //ʱ�����ڳ���
             CYCLE = 150;  
  LAB6_TOP test(clk,rst,ps2_clk, ps2_data,SSEG_CA,SSEG_AN);
               
  initial begin
        clk = 0;
        repeat (500 * CYCLE)
            #(PERIOD/5) clk = ~clk;
        
  end
  initial begin
    rst=1; #(1) rst=0;
  end
  
  initial begin
        ps2_clk = 1;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
        #(PERIOD*2)
        repeat (22)
            #(PERIOD) ps2_clk = ~ps2_clk;
  end

  initial begin //��һλ2
          ps2_data=0;
    #(10) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�1E��Ӧ����2
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�1E��Ӧ����2
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
        //�ڶ�λ0��������45
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
      //����λ0��ͬ��
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
      //����λ8��������3E
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�3E��Ӧ����8
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�3E��Ӧ����8
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
     //��������0
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    ////////���ϵ���λ0
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    ///////���ϵ���λ0
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=1;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8λ���ݣ�45��Ӧ����0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
     //���ϵ�7λ0
     
     //��8λ��3������26
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�26��Ӧ����3
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8λ���ݣ�F0
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
    #(20) ps2_data=0;  //��ʼλ
    #(10) ps2_data=0;  //���ݿ�ʼ
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8λ���ݣ�26��Ӧ����3
    #(10) ps2_data=0; //У��λ 
    #(10) ps2_data=1; //��ֹλ
    
  end

endmodule
