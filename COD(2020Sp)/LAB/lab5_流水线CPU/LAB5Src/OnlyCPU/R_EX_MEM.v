`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 12:29:47
// Design Name: 
// Module Name: R_EX_MEM
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


module R_EX_MEM(
    input clk,
    input rst,
    
    input RegWrite,
    input MemtoReg,
    input MemWrite,
    
    input [31:0] ALUout,
    input [31:0] WriteData,
    input [4:0] WriteReg, //记录需要执行写入操作的寄存器编号，之前需要选择这个信号来自rt还是rd
    
    output RegWrite_MEM,
    output MemtoReg_MEM,
    output MemWrite_MEM,
    output [31:0] ALUout_MEM,WriteData_MEM,
    output [4:0] WriteReg_MEM
    );
    
    reg RegWrite_reg, MemtoReg_reg, MemWrite_reg;
    reg [31:0] ALUout_reg, WriteData_reg;
    reg [4:0] WriteReg_reg;
    
    initial begin
      RegWrite_reg=0; MemtoReg_reg=0;  MemWrite_reg=0;
      ALUout_reg=0;   WriteData_reg=0; WriteReg_reg=0;
    end
    
    always@(posedge clk or posedge rst) begin
      if(rst) begin
         RegWrite_reg<=0; MemtoReg_reg<=0;  MemWrite_reg<=0;
         ALUout_reg<=0;   WriteData_reg<=0; WriteReg_reg<=0;
       end
      else begin
         RegWrite_reg<=RegWrite; MemtoReg_reg<=MemtoReg;    MemWrite_reg<=MemWrite;
         ALUout_reg<=ALUout;     WriteData_reg<=WriteData;  WriteReg_reg<=WriteReg;
       end
    end
    
    assign RegWrite_MEM = RegWrite_reg;
    assign MemtoReg_MEM = MemtoReg_reg;
    assign MemWrite_MEM = MemWrite_reg;
    assign ALUout_MEM = ALUout_reg;
    assign WriteData_MEM = WriteData_reg;
    assign WriteReg_MEM = WriteReg_reg;
    
endmodule
