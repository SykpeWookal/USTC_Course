`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/24 09:52:37
// Design Name: 
// Module Name: sort
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


module sort
 #(parameter N = 4)
 (
   output [N-1:0] s0,s1,s2,s3,
   output done,
   input [N-1:0] x0,x1,x2,x3,
   input clk,rst
  );
  
  wire [N-1:0] r0,r1,r2,r3,i0,i1,i2,i3,a,b;//a,b送入ALU相减
  wire zf,of,sf;
  wire [3:0] en;
  wire [5:0] muxsign;
  REGISTER #(N) R0(i0,en[0],clk,rst,r0);
  REGISTER #(N) R1(i1,en[1],clk,rst,r1);
  REGISTER #(N) R2(i2,en[2],clk,rst,r2);
  REGISTER #(N) R3(i3,en[3],clk,rst,r3);
  
  MUX_2 #(N) MUX4(r0,r2,muxsign[4],a);
  MUX_2 #(N) MUX5(r1,r3,muxsign[5],b);
  MUX_2 #(N) MUX0(x0,r1,muxsign[0],i0);
  MUX_2 #(N) MUX1(a,x1,muxsign[1],i1);
  MUX_2 #(N) MUX2(b,x2,muxsign[2],i2);
  MUX_2 #(N) MUX3(r2,x3,muxsign[3],i3);
  
  ALU #(N) subcf( ,zf, ,of,sf,a,b,3'b001);
  
  
  //control unit
  reg [2:0] current_state,next_state;
  localparam [2:0] LOAD=3'b000,CX01_1=3'b001,CX12_1=3'b010,CX23_1=3'b011,CX01_2=3'b100,CX12_2=3'b101,CX01_3=3'b110,HLT=3'b111;
  initial current_state=LOAD;
  initial next_state=LOAD;
  
  reg [5:0] muxsign_reg;
  reg [3:0] en_reg;
  reg done_reg;
  //描述各信号量
  always@(*)begin
      muxsign_reg<=6'b000000;en_reg<=4'b0000;done_reg<=0;
    case(current_state)
      LOAD:begin
         muxsign_reg<=6'b001110;
         en_reg<=4'b1111;
        end
      CX01_1:begin
         muxsign_reg<=6'b001101;en_reg<={1'b0,1'b0,~(of^sf^zf),~(of^sf^zf)};
        end
      CX12_1:begin
         muxsign_reg<=6'b010001;en_reg<={1'b0,of^sf^zf,of^sf^zf,1'b0};
        end
      CX23_1:begin
         muxsign_reg<=6'b110001;en_reg<={~(of^sf^zf),~(of^sf^zf),1'b0,1'b0};
        end
      CX01_2:begin
         muxsign_reg<=6'b000001;en_reg<={1'b0,1'b0,~(of^sf^zf),~(of^sf^zf)};
        end
      CX12_2:begin
         muxsign_reg<=6'b010001;en_reg<={1'b0,of^sf^zf,of^sf^zf,1'b0};
        end
      CX01_3:begin
         muxsign_reg<=6'b000001;en_reg<={1'b0,1'b0,~(of^sf^zf),~(of^sf^zf)};
        end
      HLT:begin
         done_reg<=1;
        end
      default: ;
    endcase
  end
  
  always@(*)begin
    case(current_state)
      LOAD:next_state<=CX01_1;
      CX01_1:next_state<=CX12_1;
      CX12_1:next_state<=CX23_1;
      CX23_1:next_state<=CX01_2;
      CX01_2:next_state<=CX12_2;
      CX12_2:next_state<=CX01_3;
      CX01_3:next_state<=HLT;
      HLT:next_state<=HLT;
      default: next_state<=HLT ;
    endcase
  end
  
  //时钟边缘更改状态
  always@(posedge clk)begin
   if(rst==1) current_state<=LOAD;
   else  current_state<=next_state;
  end
  
  assign done=done_reg;
  assign muxsign=muxsign_reg;
  assign en=en_reg;
  assign s0 = r0;
  assign s1 = r1;
  assign s2 = r2;
  assign s3 = r3;
  
endmodule
