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
  input succ,  //����ź�ֻҪΪ1����CPU��˵���̾���ִ�������
  input step,
  input [2:0] sel,
  input m_rf,
  input inc,
  input dec,
  
  output[11:0] led,
  output reg [7:0] SSEG_CA,//������������
  output reg  [7:0] SSEG_AN
    );
    
  wire stepEdge,incEdge,decEdge;   //ȡ���غ��step,inc,dec
  Take_edge step_edge (.clk(clk), .rst(rst), .in(step), .out(stepEdge));
  Take_edge inc_edge (.clk(clk), .rst(rst), .in(inc), .out(incEdge));
  Take_edge dec_edge (.clk(clk), .rst(rst), .in(dec), .out(decEdge));
   
  wire clk_DBU; reg clkdbu_reg;
  
  always@(posedge clk)begin   //����succ
    if(succ) clkdbu_reg<=clk;
    else clkdbu_reg<=stepEdge;
  end
   assign clk_DBU=clkdbu_reg;
  
  reg [7:0] m_rf_addr_reg; wire [7:0] m_rf_addr;
  initial m_rf_addr_reg=0;
  always@(posedge clk)begin   //���� m_rf_addr
    if(rst) m_rf_addr_reg<=0;
    else begin
       if(incEdge) m_rf_addr_reg<=m_rf_addr_reg+1;
       else if(decEdge) m_rf_addr_reg<=m_rf_addr_reg-1;
       else m_rf_addr_reg<=m_rf_addr_reg;
    end
  end
   assign m_rf_addr = m_rf_addr_reg;
   
   
 ////////////////////////////////////////////////////////////////////////
  localparam N = 18; //ʹ�õ�λ��100Mhz��ʱ�ӽ��з�Ƶ
     reg [N-1:0] regN; //��λ��Ϊ�����źţ���λΪ����������ʱ�ӽ��з�Ƶ
     reg [3:0] hex_in; //��ѡ�����ź�
     reg [3:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
     initial hex0=0; initial hex1=0;initial hex2=0; initial hex3=0;
     initial hex4=0; initial hex5=0;initial hex6=0; initial hex7=0;
     initial regN=0;
 /////////////////////////////////////////////////////////////////////////
 
  wire [31:0] rf_data,m_data;
  wire [31:0] pc_in,pc_out;//����ʹ���pc������
  wire [31:0] instr;//ָ��洢�����������
  wire [31:0] rf_rd1;//�Ĵ����Ѷ���1������
  wire [31:0] rf_rd2;//�Ĵ����Ѷ���2������
  wire [31:0] alu_y;//ALU��������
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
     3'b000: begin//�鿴CPU���н��
        led_reg = {2'b0,m_rf_addr<<2};
        if(m_rf) begin   //�鿴�洢��
           {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}=m_data;
        end
        else begin     //�鿴�Ĵ�����
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
  
  
  
  //����ܲ���
 
  always@(posedge clk)begin
      regN <= regN + 1;
   end
  
  //�������� 
   always@(*) 
   begin
    case(regN[N-1:N-3])
           3'b000:begin
               SSEG_AN = 8'b11111110; //ѡ�е�1�������
               hex_in = hex0; //�������ʾ��������hex_in���ƣ���ʾhex0��������֣�
            end
           3'b001:begin
               SSEG_AN = 8'b11111101; //ѡ�е�2�������
               hex_in = hex1; 
            end
           3'b010:begin
             SSEG_AN = 8'b11111011; //ѡ�е�3�������
             hex_in = hex2;
            end
           3'b011:begin
             SSEG_AN = 8'b11111011; //ѡ�е�4�������
             hex_in = hex3;
            end
           3'b100:begin
               SSEG_AN = 8'b11101111; //ѡ�е�5�������
               hex_in = hex4; 
            end
           3'b101:begin
               SSEG_AN = 8'b11011111; //ѡ�е�6�������
               hex_in = hex5;
            end 
           3'b110:begin
               SSEG_AN = 8'b10111111; //ѡ�е�7�������
               hex_in = hex6; 
            end
           3'b111:begin
               SSEG_AN = 8'b01111111; //ѡ�е�8�������
               hex_in = hex7; 
            end
           default: SSEG_AN=8'b11111111;
      endcase   
   end 

   //������������
   always@(*)begin
       case(hex_in)
                      4'h0: SSEG_CA[7:0] = 8'b00000011; //�����������
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
