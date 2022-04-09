`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 12:34:10
// Design Name: 
// Module Name: FIFO
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


module FIFO(
    input clk, rst,		//时钟（上升沿有效）、异步复位（高电平有效）
    input [7:0] din,    //入队列数据
    input en_in, 		//入队列使能，高电平有效
    input en_out,		//出队列使能，高电平有效
    output [7:0] dout, 	//出队列数据
    output [4:0] count,	//队列数据计数
       output [1:0] s
    );
   
    
   wire  en_in_edge,  en_out_edge,  mem_en;
   wire [7:0] mem_out;
   wire [3:0] addr;
  
   Take_edge IN  (clk,rst,en_in,en_in_edge);
   Take_edge OUT (clk,rst,en_out,en_out_edge);
   dist_mem_16depth_8bit MEM (.a(addr), .d(din), .clk(clk), .we(mem_en), .spo(mem_out));
   
    reg [1:0] current_state,next_state;
    localparam [1:0] WAIT=2'b00,INQ=2'b01,OUTQ=2'b10,CLEAR=2'b11;
    reg [3:0] rear;//记录队尾编号 
    reg [3:0] addr_reg;  reg mem_en_reg; reg [4:0] count_reg;
    reg [7:0] dout_reg;
  initial current_state=WAIT;
  initial next_state=WAIT;  
  initial rear=0;
  initial count_reg=0;
  initial dout_reg=0;
  
  //描述次态
always @(*) begin 
  if(rst) next_state=CLEAR;
  else 
  begin
    case (current_state)
      WAIT:begin        //优先处理入队
          if (en_in_edge) next_state = INQ; 
          else if(en_out_edge) next_state =  OUTQ; 
          else next_state = WAIT;
        end
      INQ : begin
         if(en_out_edge) next_state = OUTQ; else  next_state = WAIT;
        end
      OUTQ:begin
         if (en_in_edge) next_state = INQ;  else  next_state = WAIT;
        end
      default: next_state = WAIT;
    endcase
  end
end
   
   reg x;
  //描述输出：
  always @(posedge clk) begin 
    case (current_state)
      WAIT:begin       
          dout_reg<=0;
          mem_en_reg<=0;
          count_reg<=count_reg;
        end
      INQ : begin    //入队
         dout_reg<=0;
         if(count_reg<5'b01111) begin
            mem_en_reg<=1;
               if({1'b0,rear}+count_reg>5'b01111)
                   {x,addr_reg} <= {1'b0,rear}+count_reg-5'b01111; //写的位置
               else 
                   {x,addr_reg} <= {1'b0,rear}+count_reg;
            count_reg<=count_reg+1;
          end
         else  mem_en_reg<=0;
        end
      OUTQ: begin   //出队
         mem_en_reg<=0;
         if(count_reg>0) begin
            count_reg<=count_reg-1;
            addr_reg<=rear;
              if(rear==4'b1111)
                  rear<=0;
              else rear<=rear+1;
            dout_reg<=mem_out;
          end
         else ;
        end
      CLEAR: begin
         dout_reg<=0;
         count_reg<=0;
         mem_en_reg<=0;
        end
      default: ;
    endcase
 end
   
   
  //状态变化
always @(posedge clk, posedge rst)
  if (rst) current_state <= CLEAR;
  else current_state <= next_state; 
  

 assign count=count_reg;
 assign mem_en=mem_en_reg;
 assign dout=dout_reg;
 assign addr=addr_reg;
 
  assign s=current_state;
 
endmodule
