`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/23 22:18:58
// Design Name: 
// Module Name: Q1
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


module Q1(
   input  [2:0] a,b, 
   input  [1:0] fun, 
   output reg s, 
   output reg [2:0] y
 ); 
  
  always@(*) begin  
    case(fun)    
      2'b00: begin s = 0; y = a & b; end         
      2'b01: begin s = 0; y = a | b; end         
      2'b10: begin {s,y} = a + b; end         
      2'b11:  begin             //²¹³ä²¿·Ö         
        if(b[2]==1)begin
           if(b[1:0]==2'b00) begin
             y=a;s=0;
           end
           if(b[1:0]==2'b01) begin
             y=a<<2'b1;s=a[2];
           end
           if(b[1:0]==2'b10) begin
             y=a<<2;s=a[1];
           end
           if(b[1:0]==2'b11) begin
             y=a<<3;s=a[0];
           end
         end
        
        else begin
           if(b[1:0]==2'b00) begin
             y=a;s=0;
           end
           if(b[1:0]==2'b01) begin
             y=a>>1;s=a[0];
           end
           if(b[1:0]==2'b10) begin
             y=a>>2;s=a[1];
           end
           if(b[1:0]==2'b11) begin
             y=a>>3;s=a[2];
           end
        end
      end         
      default: begin s = 0; y = 0; end     
    endcase 
  end 

endmodule
