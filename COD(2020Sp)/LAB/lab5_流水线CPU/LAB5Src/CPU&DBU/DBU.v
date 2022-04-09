`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/14 19:52:42
// Design Name: 
// Module Name: DBU
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


module DBU(   //已经修改流水线DBU,TOP已匹配
  input clk,
  input rst,
  input succ,  //这个信号只要为1，对CPU来说立刻就能执行完程序
  input step,
  input [2:0] sel0,
  input sel1,
  input m_rf,
  input inc,
  input dec,
  
  output[15:0] led,
  output reg [7:0] SSEG_CA,//数码管输出部分
  output reg  [7:0] SSEG_AN
    );
    
  wire stepEdge,incEdge,decEdge;   //取边沿后的step,inc,dec
  Take_edge step_edge (.clk(clk), .rst(rst), .in(step), .out(stepEdge));
  Take_edge inc_edge (.clk(clk), .rst(rst), .in(inc), .out(incEdge));
  Take_edge dec_edge (.clk(clk), .rst(rst), .in(dec), .out(decEdge));
   
  wire clk_DBU; reg clkdbu_reg;
  
  
  always@(*)begin   //描述succ
    if(succ) clkdbu_reg<=clk;
    else clkdbu_reg<=stepEdge;
  end
   assign clk_DBU=clkdbu_reg;
  
  
  reg [8:0] m_rf_addr_reg; wire [8:0] m_rf_addr;
  initial m_rf_addr_reg=0;
  always@(posedge clk)begin   //描述 m_rf_addr
    if(rst) m_rf_addr_reg<=0;
    else begin
       if(incEdge) m_rf_addr_reg<=m_rf_addr_reg+1;
       else if(decEdge) m_rf_addr_reg<=m_rf_addr_reg-1;
       else m_rf_addr_reg<=m_rf_addr_reg;
    end
  end
   assign m_rf_addr = m_rf_addr_reg;
   
   
 ////////////////////////////////////////////////////////////////////////
  localparam N = 18; //使用低位对100Mhz的时钟进行分频
     reg [N-1:0] regN; //高位作为控制信号，低位为计数器，对时钟进行分频
     reg [3:0] hex_in; //段选控制信号
     reg [3:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
     initial hex0=0; initial hex1=0;initial hex2=0; initial hex3=0;
     initial hex4=0; initial hex5=0;initial hex6=0; initial hex7=0;
     initial regN=0;
 /////////////////////////////////////////////////////////////////////////
 
  wire [31:0] rf_data,m_data;
 /* wire [31:0] pc_out_DBU;//传入和传出pc的内容
  wire [31:0] IR_DBU;//指令存储器输出的数据
  wire [31:0] MD_DBU;//寄存器堆读口1的数据
  wire [31:0] rf_A_DBU;//寄存器堆读口2的数据
  wire [31:0] rf_B_DBU;//ALU的运算结果
  wire [31:0] aluout_DBU;*/
  
  wire [31:0] PC_OUT_DBU;
  wire [31:0] IR_ID_NPC_DBU;
  wire [31:0] IR_ID_INS_DBU;
  wire [31:0] ID_EX_DBU;
  wire [31:0] EX_MEM_DBU;
  wire [31:0] MEM_WB_DBU;
  
  wire RegWrite,MemtoReg,MemWrite,ALUSrc,RegDst,Branch,Jump;
  wire RegWrite_EX,MemtoReg_EX,MemWrite_EX,ALUSrc_EX,RegDst_EX;
  wire [2:0] ALUop,ALUop_EX;
  wire RegWrite_MEM,MemtoReg_MEM,MemWrite_MEM;
  wire RegWrite_WB,MemtoReg_WB;
  
  TOP test (clk_DBU, rst, m_rf_addr, m_data, rf_data, PC_OUT_DBU, IR_ID_NPC_DBU, IR_ID_INS_DBU, ID_EX_DBU, EX_MEM_DBU, 
      MEM_WB_DBU, RegWrite,MemtoReg,MemWrite,ALUSrc,RegDst,Branch,Jump, RegWrite_EX,MemtoReg_EX,MemWrite_EX,ALUSrc_EX,RegDst_EX,
      ALUop,ALUop_EX, RegWrite_MEM,MemtoReg_MEM,MemWrite_MEM, RegWrite_WB,MemtoReg_WB );
 
  reg [15:0]led_reg;
  assign led=led_reg;
  initial led_reg=0;
  
  always@(*)begin
    case(sel0)
     3'b000: begin//查看CPU运行结果
        led_reg = {2'b0,m_rf_addr<<2};
        if(m_rf) begin   //查看存储器
           {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=m_data;
        end
        else begin     //查看寄存器堆
           {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=rf_data;
        end
      end
     3'b001: begin
        led_reg=0;
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=PC_OUT_DBU;
      end
     3'b010: begin
        led_reg={RegWrite,MemtoReg,MemWrite,ALUop,ALUSrc,RegDst,Branch,Jump,6'b0};
        if(sel1==0)
          {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=IR_ID_NPC_DBU;
        else
          {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=IR_ID_INS_DBU;
      end
     3'b011: begin
        led_reg={RegWrite_EX,MemtoReg_EX,ALUop_EX,MemWrite_EX,ALUSrc_EX,RegDst_EX, 8'b0};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=ID_EX_DBU;
      end
     3'b100: begin
        led_reg={RegWrite_MEM,MemtoReg_MEM,MemWrite_MEM, 13'b0};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=EX_MEM_DBU;
      end
     3'b101: begin
        led_reg={RegWrite_WB,MemtoReg_WB,14'b0};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=MEM_WB_DBU;
      end
     3'b110: begin
        led_reg=0;
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=0;
      end
     3'b111: begin
        led_reg=0;
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=0;
      end
     default: ;
    endcase
  end
  
  
  
  //数码管部分
 
  always@(posedge clk)begin
      regN <= regN + 1;
   end
  
  //数码管输出 
   always@(*) 
   begin
    case(regN[N-1:N-3])
           3'b000:begin
               SSEG_AN = 8'b11111110; //选中第1个数码管
               hex_in = hex0; //数码管显示的数字由hex_in控制，显示hex0输入的数字；
            end
           3'b001:begin
               SSEG_AN = 8'b11111101; //选中第2个数码管
               hex_in = hex1; 
            end
           3'b010:begin
             SSEG_AN = 8'b11111011; //选中第3个数码管
             hex_in = hex2;
            end
           3'b011:begin
             SSEG_AN = 8'b11111011; //选中第4个数码管
             hex_in = hex3;
            end
           3'b100:begin
               SSEG_AN = 8'b11101111; //选中第5个数码管
               hex_in = hex4; 
            end
           3'b101:begin
               SSEG_AN = 8'b11011111; //选中第6个数码管
               hex_in = hex5;
            end 
           3'b110:begin
               SSEG_AN = 8'b10111111; //选中第7个数码管
               hex_in = hex6; 
            end
           3'b111:begin
               SSEG_AN = 8'b01111111; //选中第8个数码管
               hex_in = hex7; 
            end
           default: SSEG_AN=8'b11111111;
      endcase   
   end 

   //数码管输出部分
   always@(*)begin
       case(hex_in)
                      4'h0: SSEG_CA[7:0] = 8'b00000011; //共阳极数码管
                      4'h1: SSEG_CA[7:0] = 8'b10011111;
                      4'h2: SSEG_CA[7:0] = 8'b00100101;
                      4'h3: SSEG_CA[7:0] = 8'b00001101;
                      4'h4: SSEG_CA[7:0] = 8'b10011001;
                      4'h5: SSEG_CA[7:0] = 8'b01001001;
                      4'h6: SSEG_CA[7:0] = 8'b01000001;
                      4'h7: SSEG_CA[7:0] = 8'b00011111;
                      4'h8: SSEG_CA[7:0] = 8'b00000001;
                      4'h9: SSEG_CA[7:0] = 8'b00001001;
                      4'ha: SSEG_CA[7:0] = 8'b00010000;
                      4'hb: SSEG_CA[7:0] = 8'b00000000;
                      4'hc: SSEG_CA[7:0] = 8'b01100010;    
                      4'hd: SSEG_CA[7:0] = 8'b00000010;
                      4'he: SSEG_CA[7:0] = 8'b01100000;
                   default: SSEG_CA[7:0] = 8'b01110000;
           endcase
   end  
  
endmodule
