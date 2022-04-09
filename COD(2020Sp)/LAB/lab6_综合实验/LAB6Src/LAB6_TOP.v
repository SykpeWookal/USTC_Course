`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/01 21:54:16
// Design Name: 
// Module Name: LAB6_TOP
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


module LAB6_TOP(
    input clk,
    input rst,
    input ps2_clk,ps2_data,
    
    output [7:0] SSEG_CA,
    output [7:0] SSEG_AN
    );
    
    wire [31:0] IO_DATA_din,IO_DATA_dout ,PC;
    wire readIO_finished_in,readIO_finished_out, SSEG_MODE;
    wire  PRESS_0,PRESS_1,PRESS_2,PRESS_3,PRESS_4, PRESS_5,PRESS_6,PRESS_7,PRESS_8,
          PRESS_9,PRESS_A,PRESS_B,PRESS_C, PRESS_D, PRESS_E,PRESS_F,PRESS_ENTER;
    
    TOP UCPU (clk, rst, readIO_finished_out, IO_DATA_dout, PC);
    //以下为两个IO设备模块，即键盘输入与数码管输出模块//    
    KeyBoard_TOP UKEY (clk, rst, ps2_clk, ps2_data, PRESS_0, PRESS_1, PRESS_2,PRESS_3, PRESS_4, PRESS_5, PRESS_6, PRESS_7,
                       PRESS_8, PRESS_9, PRESS_A, PRESS_B, PRESS_C, PRESS_D, PRESS_E, PRESS_F, PRESS_ENTER);
    KeyBoard_IO UKEYIO (clk, PRESS_0, PRESS_1, PRESS_2,PRESS_3, PRESS_4, PRESS_5, PRESS_6, PRESS_7,
                       PRESS_8, PRESS_9, PRESS_A, PRESS_B, PRESS_C, PRESS_D, PRESS_E, PRESS_F, PRESS_ENTER,
                       IO_DATA_din, readIO_finished_in, SSEG_MODE);
    SSEG_part USSEG (clk, IO_DATA_dout, PC, SSEG_MODE, SSEG_CA, SSEG_AN);
        ////////////////////////////////////////////////
    BUS_CONTROL UBUS (IO_DATA_din,readIO_finished_in,IO_DATA_dout,readIO_finished_out);    
        
 endmodule
