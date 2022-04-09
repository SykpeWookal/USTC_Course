`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/06 12:37:44
// Design Name: 
// Module Name: Take_edge
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


module Take_edge
  (
    input clk,rst,
    input  in,
    output out
    );
    
  reg [1:0] current_state,next_state;
  localparam [1:0] S0=2'b00,S1=2'b01,S2=2'b10;
  initial current_state=S0;
  initial next_state=S0;  
    
//state logic
always @(posedge clk, posedge rst)
  if (rst) current_state <= S0;
  else current_state <= next_state; 

//next state logic
always @(*) begin 
  next_state = current_state;
  case (current_state)
    S0: if (in) next_state = S1; else next_state = S0;
    S1: if (in) next_state = S2; else next_state = S0;
    S2: if (in) next_state = S2; else next_state = S0;
    default: next_state = S0;
  endcase
end

//output logic
  assign  out = (current_state==S1);  
    
endmodule


/*module Take_edge
  (
    input clk,rst,
    input  in,
    output out
    );

reg button_r1,button_r2; 
  always@(posedge clk)     
    button_r1 <= in;
  always@(posedge clk)  
   button_r2 <= button_r1; 
   
   assign out = button_r1 & (~button_r2); 
    
endmodule*/