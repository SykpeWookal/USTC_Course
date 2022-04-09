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
  parameter PERIOD = 5,      //时钟周期长度
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

  initial begin //第一位2
          ps2_data=0;
    #(10) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，1E对应键盘2
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，1E对应键盘2
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
        //第二位0，键盘码45
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
      //第三位0，同上
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
      //第四位8，键盘码3E
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，3E对应键盘8
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，3E对应键盘8
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
     //连续三个0
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    ////////以上第五位0
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    ///////以上第六位0
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=1;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;  //8位数据，45对应键盘0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
     //以上第7位0
     
     //第8位，3键盘码26
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，26对应键盘3
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=1;  //8位数据，F0
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
    #(20) ps2_data=0;  //起始位
    #(10) ps2_data=0;  //数据开始
    #(10) ps2_data=1;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;
    #(10) ps2_data=1;
    #(10) ps2_data=0;
    #(10) ps2_data=0;  //8位数据，26对应键盘3
    #(10) ps2_data=0; //校验位 
    #(10) ps2_data=1; //终止位
    
  end

endmodule
