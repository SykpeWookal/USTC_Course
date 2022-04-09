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


module DBU(
  input clk,
  input rst,
  input succ,  //这个信号只要为1，对CPU来说立刻就能执行完程序
  input step,
  input [2:0] sel,
  input m_rf,
  input inc,
  input dec,
  
  output[11:0] led,
  output reg [7:0] SSEG_CA,//数码管输出部分
  output reg  [7:0] SSEG_AN
    );
    
  wire stepEdge,incEdge,decEdge;   //取边沿后的step,inc,dec
  Take_edge step_edge (.clk(clk), .rst(rst), .in(step), .out(stepEdge));
  Take_edge inc_edge (.clk(clk), .rst(rst), .in(inc), .out(incEdge));
  Take_edge dec_edge (.clk(clk), .rst(rst), .in(dec), .out(decEdge));
   
  wire clk_DBU; reg clkdbu_reg;
  
  always@(posedge clk)begin   //描述succ
    if(succ) clkdbu_reg<=clk;
    else clkdbu_reg<=stepEdge;
  end
   assign clk_DBU=clkdbu_reg;
  
  reg [7:0] m_rf_addr_reg; wire [7:0] m_rf_addr;
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
  wire [31:0] pc_in,pc_out;//传入和传出pc的内容
  wire [31:0] instr;//指令存储器输出的数据
  wire [31:0] rf_rd1;//寄存器堆读口1的数据
  wire [31:0] rf_rd2;//寄存器堆读口2的数据
  wire [31:0] alu_y;//ALU的运算结果
  wire [31:0] m_rd;
  wire Jump,Branch,RegDst,RegWrite,MemtoReg,MemWrite;
  wire [2:0] ALUop;
  wire ALUSrc,ALUZero;
  
  TOP test (clk_DBU, rst, m_rf_addr, m_data,rf_data, pc_in, pc_out, instr, rf_rd1, rf_rd2, alu_y, m_rd, Jump,Branch,RegDst,RegWrite,MemtoReg,MemWrite,ALUop,ALUSrc,ALUZero);
 
  reg [11:0]led_reg;
  assign led=led_reg;
  initial led_reg=0;
  
  always@(*)begin
    case(sel)
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
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=pc_in;
      end
     3'b010: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=pc_out;
      end
     3'b011: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=instr;
      end
     3'b100: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=rf_rd1;
      end
     3'b101: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=rf_rd2;
      end
     3'b110: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=alu_y;
      end
     3'b111: begin
        led_reg={Jump,Branch,RegDst,RegWrite,1'b0,MemtoReg,MemWrite,ALUop[2],ALUop[1],ALUop[0],ALUSrc,ALUZero};
        {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=m_rd;
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
