`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 15:55:00
// Design Name: 
// Module Name: KeyBoard_TOP
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


module KeyBoard_TOP(
    input clk,
    input rst,
    input ps2_clk,ps2_data,
    
	output  PRESS_0,
	output  PRESS_1,
	output  PRESS_2,
	output  PRESS_3,
	output  PRESS_4,
	output  PRESS_5,
	output  PRESS_6,
	output  PRESS_7,
	output  PRESS_8,
	output  PRESS_9,
	output  PRESS_A,
	output  PRESS_B,
	output  PRESS_C,
	output  PRESS_D,
	output  PRESS_E,
	output  PRESS_F,
	output  PRESS_ENTER
    );
    
    wire [23:0] key;
    KeyBoard_detection UKEYDET (clk, rst, ps2_clk, ps2_data, key);
              
    reg press0,press1,press2,press3,press4,press5,press6,press7,press8,press9,pressA,pressB,pressC,pressD,pressE,pressF,pressenter;
       initial begin
        press0=0;press1=0;press2=0;press3=0;press4=0;press5=0;press6=0;press7=0;
        press8=0;press9=0;pressA=0;pressB=0;pressC=0;pressD=0;pressE=0;pressF=0;
        pressenter=0;
       end
       
    always@(posedge clk) begin
     if(rst==1) begin
       ;
     end
     
     else begin
      
      if((key[23:16]==8'h45)&&(key[15:8]<8'hF0))//´ýÈ¡±ßÑØ      0¼ü
        press0<=1;
      else if((key[23:16]==8'h45)&&(key[15:8]==8'hF0))
        press0<=0;
      else;
      
      if((key[23:16]==8'h16)&&(key[15:8]<8'hF0)) // 1
        press1<=1;
      else if((key[23:16]==8'h16)&&(key[15:8]==8'hF0))
        press1<=0;
      else;
      
      if((key[23:16]==8'h1E)&&(key[15:8]<8'hF0)) // 2
        press2<=1;
      else if((key[23:16]==8'h1E)&&(key[15:8]==8'hF0))
        press2<=0;
      else;
      
      if((key[23:16]==8'h26)&&(key[15:8]<8'hF0)) // 3
        press3<=1;
      else if((key[23:16]==8'h26)&&(key[15:8]==8'hF0))
        press3<=0;
      else;
      
      if((key[23:16]==8'h25)&&(key[15:8]<8'hF0)) // 4
        press4<=1;
      else if((key[23:16]==8'h25)&&(key[15:8]==8'hF0))
        press4<=0;
      else;
      
      if((key[23:16]==8'h2E)&&(key[15:8]<8'hF0)) // 5
        press5<=1;
      else if((key[23:16]==8'h2E)&&(key[15:8]==8'hF0))
        press5<=0;
      else;
      
      if((key[23:16]==8'h36)&&(key[15:8]<8'hF0)) // 6
        press6<=1;
      else if((key[23:16]==8'h36)&&(key[15:8]==8'hF0))
        press6<=0;
      else;
      
      if((key[23:16]==8'h3D)&&(key[15:8]<8'hF0)) // 7
        press7<=1;
      else if((key[23:16]==8'h3D)&&(key[15:8]==8'hF0))
        press7<=0;
      else;
      
      if((key[23:16]==8'h3E)&&(key[15:8]<8'hF0)) // 8
        press8<=1;
      else if((key[23:16]==8'h3E)&&(key[15:8]==8'hF0))
        press8<=0;
      else;
      
      if((key[23:16]==8'h46)&&(key[15:8]<8'hF0)) // 9
        press9<=1;
      else if((key[23:16]==8'h46)&&(key[15:8]==8'hF0))
        press9<=0;
      else;
      
      if((key[23:16]==8'h1C)&&(key[15:8]<8'hF0)) // A
        pressA<=1;
      else if((key[23:16]==8'h1C)&&(key[15:8]==8'hF0))
        pressA<=0;
      else;
      
      if((key[23:16]==8'h32)&&(key[15:8]<8'hF0)) // B
        pressB<=1;
      else if((key[23:16]==8'h32)&&(key[15:8]==8'hF0))
        pressB<=0;
      else;
      
      if((key[23:16]==8'h21)&&(key[15:8]<8'hF0)) // C
        pressC<=1;
      else if((key[23:16]==8'h21)&&(key[15:8]==8'hF0))
        pressC<=0;
      else;
      
      if((key[23:16]==8'h23)&&(key[15:8]<8'hF0)) // D
        pressD<=1;
      else if((key[23:16]==8'h23)&&(key[15:8]==8'hF0))
        pressD<=0;
      else;
      
      if((key[23:16]==8'h24)&&(key[15:8]<8'hF0)) // E
        pressE<=1;
      else if((key[23:16]==8'h24)&&(key[15:8]==8'hF0))
        pressE<=0;
      else;
      
      if((key[23:16]==8'h2B)&&(key[15:8]<8'hF0)) // F
        pressF<=1;
      else if((key[23:16]==8'h2B)&&(key[15:8]==8'hF0))
        pressF<=0;
      else;
    
      if((key[23:16]==8'h5A)&&(key[15:8]<8'hF0)) // F
        pressenter<=1;
      else if((key[23:16]==8'h5A)&&(key[15:8]==8'hF0))
        pressenter<=0;
      else;
    end
   end
   
   assign PRESS_ENTER = pressenter;
   
  reg press0_r1,press0_r2; 
    always@(posedge clk)     
      press0_r1 <= press0; 
    always@(posedge clk)     
      press0_r2 <= press0_r1;     
    assign PRESS_0 = press0_r1 & (~press0_r2); 
    
  reg press1_r1,press1_r2; 
    always@(posedge clk)      
      press1_r1 <= press1; 
    always@(posedge clk)     
      press1_r2 <= press1_r1;  
    assign PRESS_1 = press1_r1 & (~press1_r2);
    
  reg press2_r1,press2_r2; 
    always@(posedge clk)      
      press2_r1 <= press2; 
    always@(posedge clk)     
      press2_r2 <= press2_r1;  
    assign PRESS_2 = press2_r1 & (~press2_r2);
    
  reg press3_r1,press3_r2; 
    always@(posedge clk)      
      press3_r1 <= press3; 
    always@(posedge clk)     
      press3_r2 <= press3_r1;  
    assign PRESS_3 = press3_r1 & (~press3_r2);
    
  reg press4_r1,press4_r2; 
    always@(posedge clk)      
      press4_r1 <= press4; 
    always@(posedge clk)     
      press4_r2 <= press4_r1;  
    assign PRESS_4 = press4_r1 & (~press4_r2);
    
  reg press5_r1,press5_r2; 
    always@(posedge clk)      
      press5_r1 <= press5; 
    always@(posedge clk)     
      press5_r2 <= press5_r1;  
    assign PRESS_5 = press5_r1 & (~press5_r2);
    
  reg press6_r1,press6_r2; 
    always@(posedge clk)      
      press6_r1 <= press6; 
    always@(posedge clk)     
      press6_r2 <= press6_r1;  
    assign PRESS_6 = press6_r1 & (~press6_r2);
    
  reg press7_r1,press7_r2; 
    always@(posedge clk)      
      press7_r1 <= press7; 
    always@(posedge clk)     
      press7_r2 <= press7_r1;  
    assign PRESS_7 = press7_r1 & (~press7_r2);
    
  reg press8_r1,press8_r2; 
    always@(posedge clk)      
      press8_r1 <= press8; 
    always@(posedge clk)     
      press8_r2 <= press8_r1;  
    assign PRESS_8 = press8_r1 & (~press8_r2);
    
  reg press9_r1,press9_r2; 
    always@(posedge clk)      
      press9_r1 <= press9; 
    always@(posedge clk)     
      press9_r2 <= press9_r1;  
    assign PRESS_9 = press9_r1 & (~press9_r2);
    
  reg pressA_r1,pressA_r2; 
    always@(posedge clk)      
      pressA_r1 <= pressA; 
    always@(posedge clk)     
      pressA_r2 <= pressA_r1;  
    assign PRESS_A = pressA_r1 & (~pressA_r2);
    
  reg pressB_r1,pressB_r2; 
    always@(posedge clk)      
      pressB_r1 <= pressB; 
    always@(posedge clk)     
      pressB_r2 <= pressB_r1;  
    assign PRESS_B = pressB_r1 & (~pressB_r2);
    
  reg pressC_r1,pressC_r2; 
    always@(posedge clk)      
      pressC_r1 <= pressC; 
    always@(posedge clk)     
      pressC_r2 <= pressC_r1;  
    assign PRESS_C = pressC_r1 & (~pressC_r2);
    
  reg pressD_r1,pressD_r2; 
    always@(posedge clk)      
      pressD_r1 <= pressD; 
    always@(posedge clk)     
      pressD_r2 <= pressD_r1;  
    assign PRESS_D = pressD_r1 & (~pressD_r2);
    
  reg pressE_r1,pressE_r2; 
    always@(posedge clk)      
      pressE_r1 <= pressE; 
    always@(posedge clk)     
      pressE_r2 <= pressE_r1;  
    assign PRESS_E = pressE_r1 & (~pressE_r2);
    
  reg pressF_r1,pressF_r2; 
    always@(posedge clk)      
      pressF_r1 <= pressF; 
    always@(posedge clk)     
      pressF_r2 <= pressF_r1;  
    assign PRESS_F = pressF_r1 & (~pressF_r2);
    
endmodule
