`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 12:29:47
// Design Name: 
// Module Name: R_MEM_WB
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


module R_MEM_WB(
    input clk,
    input rst,
    
    input RegWrite,
    input MemtoReg,
    
    input [31:0] ReadData,
    input [31:0] ALUout,
    input [4:0] WriteReg, //记录需要执行写入操作的寄存器编号，之前需要选择这个信号来自rt还是rd
    
    output RegWrite_WB,
    output MemtoReg_WB,
    output [31:0] ReadData_WB,ALUout_WB,
    output [4:0] WriteReg_WB
    );
    
    reg RegWrite_reg, MemtoReg_reg;
    reg [31:0] ReadData_reg,ALUout_reg;
    reg [4:0] WriteReg_reg;
    
    initial begin
      RegWrite_reg=0; MemtoReg_reg=0;  
      ALUout_reg=0;   ReadData_reg=0; WriteReg_reg=0;
    end
    
    always@(posedge clk or posedge rst) begin
      if(rst) begin
         RegWrite_reg<=0; MemtoReg_reg<=0; 
         ALUout_reg<=0;   ReadData_reg<=0; WriteReg_reg<=0;
       end
      else begin
         RegWrite_reg<=RegWrite; MemtoReg_reg<=MemtoReg;   
         ALUout_reg<=ALUout;     ReadData_reg<=ReadData;  WriteReg_reg<=WriteReg;
       end
    end
    
    assign RegWrite_WB = RegWrite_reg;
    assign MemtoReg_WB = MemtoReg_reg;
    assign ALUout_WB = ALUout_reg;
    assign ReadData_WB = ReadData_reg;
    assign WriteReg_WB = WriteReg_reg;
    
    
endmodule
