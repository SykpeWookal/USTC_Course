`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module SSEG_part(
  input clk,
  input [31:0] IO_DATA,
  input [31:0] PC,
  input SSEG_MODE,
  
  output reg [7:0] SSEG_CA,
  output reg  [7:0] SSEG_AN
    );
    
    localparam N = 18; //ʹ�õ�λ��100Mhz��ʱ�ӽ��з�Ƶ
     reg [N-1:0] regN; //��λ��Ϊ�����źţ���λΪ����������ʱ�ӽ��з�Ƶ
     reg [3:0] hex_in; //��ѡ�����ź�
     reg [3:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
    initial begin
      regN=0; hex_in=0; {hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7}=0;
    end
   //�߼�����
   always@(posedge clk)begin
      if(SSEG_MODE==0)
       {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}<=IO_DATA;
      else
       {hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0}<=PC;
   end
 
   always@(posedge clk)
   begin
     regN <= regN + 1;
   end
   
   always@(*) 
   begin
    case(regN[N-1:N-3])
           3'b000:begin
               SSEG_AN = 8'b11111110; //ѡ�е�1�������
               hex_in = hex0; //�������ʾ��������hex_in���ƣ���ʾhex0��������֣�
            end
           3'b001:begin
               SSEG_AN = 8'b11111101; //ѡ�еڶ��������
               hex_in = hex1;
            end
           3'b010:begin
             SSEG_AN = 8'b11111011; //ѡ�е�3�������
             hex_in = hex2;
            end
           3'b011:begin
             SSEG_AN = 8'b11110111; //ѡ�е�4�������
             hex_in = hex3;                 
            end
           3'b100:begin
               SSEG_AN = 8'b11101111; //ѡ�е�1�������
               hex_in = hex4; 
            end
           3'b101:begin
               SSEG_AN = 8'b11011111; //ѡ�е�1�������
               hex_in = hex5;
            end 
           3'b110:begin
               SSEG_AN = 8'b10111111; //ѡ�е�1�������
               hex_in = hex6; 
            end
           3'b111:begin
               SSEG_AN = 8'b01111111; //ѡ�е�1�������
               hex_in = hex7; 
            end
           default:;
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
                      4'h9: SSEG_CA[7:0] = 8'b00001001;  //����Ϊ����
                      
                      4'ha: SSEG_CA[7:0] = 8'b00010001;//A
                      4'hb: SSEG_CA[7:0] = 8'b11000001;//b
                      4'hc: SSEG_CA[7:0] = 8'b01100011;//C 
                      4'hd: SSEG_CA[7:0] = 8'b10000101;//d
                      4'he: SSEG_CA[7:0] = 8'b01100001;//E
                   default: SSEG_CA[7:0] = 8'b01110001;//F
           endcase
   end  
  
endmodule
