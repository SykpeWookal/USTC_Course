`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/01 08:10:38
// Design Name: 
// Module Name: BUS_CONTROL
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


module BUS_CONTROL(
    //input clk,  //����ϵͳ100MHzʱ��
    
    input [31:0] IO_DATA_din,  //�Ӽ��̽��յ���32λmipsָ��
	input readIO_finished_in, //��־�Ƿ��Ѿ���IO��ȡ�����������ݣ���Ϊ1���򽫴���������CPUָ��洢��
                              //din0-din16���߿��������յ�I/O�ź�
	
	//output keyboard_en,
	output [31:0] IO_DATA_dout,//�Ӽ��̽��յ���32λmipsָ��
	//output PC_EN,
	output readIO_finished_out //��־�Ƿ��Ѿ���IO��ȡ�����������ݣ���Ϊ1���򽫴���������CPUָ��洢��
    );
 
    
  assign   IO_DATA_dout = IO_DATA_din;
  assign   readIO_finished_out = readIO_finished_in;
    
endmodule
