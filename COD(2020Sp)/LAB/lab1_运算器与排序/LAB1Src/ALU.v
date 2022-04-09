`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/22 20:55:59
// Design Name: 
// Module Name: ALU
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


module ALU
 #(parameter WIDTH=32)
 (
    output  [WIDTH-1:0]y,
    output  zf,
    output  cf,
    output  of,
    output  sf,  //最高位符号标志
    input [WIDTH-1:0]a,b,
    input [2:0] m
  );
  
  reg cf_reg,of_reg,zf_reg,sf_reg;
  reg [WIDTH-1:0] y_reg;
  
  always@(*) begin
    case(m)
      3'b000: begin //a+b
        {cf_reg,y_reg}<=a+b;
        of_reg<=(~a[WIDTH-1]&~b[WIDTH-1]&y_reg[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~y_reg[WIDTH-1]);
        zf_reg<=~|y_reg;
        sf_reg = y_reg[WIDTH-1];
        end 
      3'b001: begin //a-b
        {cf_reg,y_reg}<=a-b;
        of_reg<=(~a[WIDTH-1]&b[WIDTH-1]&y_reg[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~y_reg[WIDTH-1]);
        zf_reg<=~|y_reg;
        sf_reg = y_reg[WIDTH-1];
        end 
      3'b010: begin //a&b
        y_reg<=a&b;
        cf_reg<=0;
        of_reg<=0;
        zf_reg<=0;
        sf_reg = y_reg[WIDTH-1];
        end 
      3'b011: begin //a|b
        y_reg<=a|b;
        cf_reg<=0;
        of_reg<=0;
        zf_reg<=0;
        sf_reg = y_reg[WIDTH-1];
        end 
      3'b100: begin //a^b
        y_reg<=a^b;
        cf_reg<=0;
        of_reg<=0;
        zf_reg<=0;
        sf_reg = y_reg[WIDTH-1];
        end 
     default: begin
       y_reg<=0;
       cf_reg<=0;
       of_reg<=0;
       zf_reg<=0;
       sf_reg = y_reg[WIDTH-1];
        end
    endcase
  end
  
  assign y=y_reg;
  assign cf=cf_reg;
  assign of=of_reg;
  assign zf=zf_reg;
  assign sf=sf_reg;
   
endmodule
