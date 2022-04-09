`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/10 17:56:25
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
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input [2:0] ALUop,
    //output zero,
    output [WIDTH-1:0] result
    );
  
  reg [31:0] res;
  always@(*) begin
    if(ALUop==3'b000) begin
      res=in0+in1;
    end
  end
  
//  assign zero=(in0==in1)?  1:0 ;
  assign result=res;

endmodule
