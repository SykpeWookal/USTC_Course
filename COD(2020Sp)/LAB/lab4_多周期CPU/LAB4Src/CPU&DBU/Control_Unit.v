`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 09:53:58
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input clk,
    input rst,
    input [5:0] op,
    
    output PCWriteCond,
    output PCWrite,
    output IorD,
    //output MemRead
    output MemWrite,
    output MemtoReg,
    output IRWrite,
    output [1:0] PCSourse,
    output [2:0] ALUop,
    output [1:0] ALUSrcB,
    output ALUSrcA,
    output RegWrite,
    output RegDst
    
    );
    
    localparam [5:0] ADD=6'b000000, ADDI=6'b001000, LW=6'b100011, SW=6'b101011, BEQ=6'b000100, J=6'b000010;
    localparam [2:0] IF=3'b000,ID=3'b001,EX=3'b010,MEM=3'b011,WB=3'b100;
    
    reg [2:0] state,next_state;
    reg  PCWriteCond_reg, PCWrite_reg, IorD_reg, MemWrite_reg,  MemtoReg_reg, IRWrite_reg, ALUSrcA_reg, RegWrite_reg, RegDst_reg;
    reg [1:0] PCSourse_reg;
    reg [2:0] ALUop_reg;
    reg [1:0] ALUSrcB_reg;

    initial begin
       PCWriteCond_reg=0; PCWrite_reg=0; IorD_reg=0; MemWrite_reg=0;  MemtoReg_reg=0; IRWrite_reg=0; ALUSrcA_reg=0; RegWrite_reg=0; RegDst_reg=0;
       PCSourse_reg=0; ALUop_reg=0; ALUSrcB_reg=0;
       state=IF;
    end
    
    always@(*)begin //描述输出
      case(state)
         IF: begin   //执行pc<=pc+4， IR=Mem[pc] 关键信号用缩进表示。
            /*PCWriteCond_reg <= 0;*/
               PCWrite_reg <= 1;
               IorD_reg <= 0; 
            MemWrite_reg <= 0;  
          /*  MemtoReg_reg <= 0; */
               IRWrite_reg <= 1;  
               PCSourse_reg <= 2'b00;
               ALUop_reg <= 3'b000;
               ALUSrcB_reg <= 2'b01;
               ALUSrcA_reg <= 0;
            RegWrite_reg <= 0;
            /*RegDst_reg <= 0;*/
            
            next_state <= ID;
          end
          
         ID: begin  //译码阶段，完成A、B寄存器和ALUout寄存器的赋值
            PCWriteCond_reg <= 0;
            PCWrite_reg <= 0;
            IorD_reg <= 0; 
            MemWrite_reg <= 0;  
            MemtoReg_reg <= 0; 
            IRWrite_reg <= 0;  
            PCSourse_reg <= 2'b00;
               ALUop_reg <= 3'b000;
               ALUSrcB_reg <= 2'b11;
               ALUSrcA_reg <= 0;
            RegWrite_reg <= 0;
            RegDst_reg <= 0;
            
            next_state <= EX;
          end
          
         EX: begin
            if(op==ADD)begin
               /* PCWriteCond_reg <= 0;
                PCWrite_reg <= 0;
                IorD_reg <= 0; 
                MemWrite_reg <= 0;  
                MemtoReg_reg <= 0; 
                IRWrite_reg <= 0;  
                PCSourse_reg <= 2'b00;*/
                   ALUop_reg <= 3'b000;
                   ALUSrcB_reg <= 2'b00;
                   ALUSrcA_reg <= 1;
              /*  RegWrite_reg <= 0;
                RegDst_reg <= 0;*/
            
                next_state <= MEM;
             end
            else if(op==ADDI||op==LW||op==SW)begin
               /* PCWriteCond_reg <= 0;
                PCWrite_reg <= 0;
                IorD_reg <= 0; 
                MemWrite_reg <= 0;  
                MemtoReg_reg <= 0; 
                IRWrite_reg <= 0;  
                PCSourse_reg <= 2'b00;*/
                   ALUop_reg <= 3'b000;
                   ALUSrcB_reg <= 2'b10;
                   ALUSrcA_reg <= 1;
              /*  RegWrite_reg <= 0;
                RegDst_reg <= 0;*/
            
                next_state <= MEM;
             end
            else if(op==BEQ)begin
                   PCWriteCond_reg <= 1;
                PCWrite_reg <= 0;
                IorD_reg <= 0; 
                MemWrite_reg <= 0;  
                MemtoReg_reg <= 0; 
                IRWrite_reg <= 0;  
                   PCSourse_reg <= 2'b01;
                ALUop_reg <= 3'b000;
                   ALUSrcB_reg <= 2'b00;
                   ALUSrcA_reg <= 1;
                RegWrite_reg <= 0;
                RegDst_reg <= 0;
            
                next_state <= IF;
             end
            else if(op==J)begin
              /*  PCWriteCond_reg <= 0;*/
                   PCWrite_reg <= 1;
             /*   IorD_reg <= 0; 
                MemWrite_reg <= 0;  
                MemtoReg_reg <= 0; 
                IRWrite_reg <= 0;  */
                   PCSourse_reg <= 2'b10;
               /* ALUop_reg <= 3'b000;
                ALUSrcB_reg <= 2'b00;
                ALUSrcA_reg <= 0;
                RegWrite_reg <= 0;
                RegDst_reg <= 0;*/
            
                next_state <= IF;
             end
            else begin
                PCWriteCond_reg <= 0;   PCWrite_reg <= 0;   IorD_reg <= 0;          MemWrite_reg <= 0;  
                MemtoReg_reg <= 0;      IRWrite_reg <= 0;   PCSourse_reg <= 2'b00;  ALUop_reg <= 3'b000;
                ALUSrcB_reg <= 2'b00;   ALUSrcA_reg <= 0;   RegWrite_reg <= 0;      RegDst_reg <= 0;
                next_state <= IF;
             end
          end
          
         MEM: begin
            if(op==ADD||op==ADDI)begin
                /*PCWriteCond_reg <= 0;   PCWrite_reg <= 0;   IorD_reg <= 0;          MemWrite_reg <= 0;  */
                MemtoReg_reg <= 0;     /* IRWrite_reg <= 0;   PCSourse_reg <= 2'b00;  ALUop_reg <= 3'b000;*/
              /*  ALUSrcB_reg <= 2'b00;   ALUSrcA_reg <= 0;*/   RegWrite_reg <= 1;     
               if(op==ADD) RegDst_reg <= 1;
               else RegDst_reg <= 0;
               
                next_state <= IF;
             end
            else if(op==SW)begin
                PCWriteCond_reg <= 0;   PCWrite_reg <= 0;   IorD_reg <= 1;          MemWrite_reg <= 1;  
                MemtoReg_reg <= 0;      IRWrite_reg <= 0;   PCSourse_reg <= 2'b00;  ALUop_reg <= 3'b000;
                ALUSrcB_reg <= 2'b00;   ALUSrcA_reg <= 0;   RegWrite_reg <= 0;      RegDst_reg <= 0;
                next_state <= IF;
             end
            else if(op==LW)begin
              /*  PCWriteCond_reg <= 0;   PCWrite_reg <= 0;  */ IorD_reg <= 1;        /*  MemWrite_reg <= 0;  
                MemtoReg_reg <= 0;      IRWrite_reg <= 0;   PCSourse_reg <= 2'b00;  ALUop_reg <= 3'b000;
                ALUSrcB_reg <= 2'b00;   ALUSrcA_reg <= 0;   RegWrite_reg <= 0;      RegDst_reg <= 0;*/
                next_state <= WB;
             end
            else begin
                next_state <= IF;
             end
          end
          
         WB: begin
               RegDst_reg <= 0;RegWrite_reg <= 1;MemtoReg_reg <= 1;
               next_state <= IF;
          end
          
      default: next_state <= IF;
     endcase
    end
    
    
    
    //时钟边沿将次态赋给现态
    always@(posedge clk or posedge rst)begin
      if(rst) state<=IF;
      else state<=next_state;
    end
    
    
    
    //将寄存器型数据按线网型输出.
    assign PCWriteCond=PCWriteCond_reg;
    assign PCWrite=PCWrite_reg;
    assign IorD=IorD_reg;
    assign MemWrite=MemWrite_reg;
    assign MemtoReg=MemtoReg_reg;
    assign IRWrite=IRWrite_reg;
    assign ALUSrcA=ALUSrcA_reg;
    assign RegWrite=RegWrite_reg;
    assign RegDst=RegDst_reg;
    
    assign PCSourse=PCSourse_reg;
    assign ALUop=ALUop_reg;
    assign ALUSrcB=ALUSrcB_reg;
    

endmodule
