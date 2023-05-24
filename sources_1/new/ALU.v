`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 13:53:46
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

module ALU(
    input       [31:0]      op1,
    input       [31:0]      op2,
    input       [3:0]       ALU_func,
    output reg  [31:0]      ALU_out
    );
   
    `include "Parameters.vh"
   
    always @ (*) begin
        case(ALU_func)
            `ADD: ALU_out = op1 + op2;
            `SUB: ALU_out = op1 - op2;
            `XOR: ALU_out = op1 ^ op2;
            `OR:  ALU_out = op1 | op2;
            `AND: ALU_out = op1 & op2;
            `SLL: ALU_out = op1 << op2[4:0];
            `SRL: ALU_out = op1 >> op2[4:0];
            `SRA: ALU_out = {{32{op1[31]}}, op1[31:0]} >> op2[4:0];
            `SLT: begin
                if (op1[31]==0 && op2[31]==1)begin
                    ALU_out = 0;
                end else if (op1[31]==1 && op2[31]==0)begin
                    ALU_out = 1;
                end else if (op1[31]==1 && op2[31]==1)begin 
                    ALU_out = (op1 < op2) ? 1 : 0;
                end else begin
                    ALU_out = (op1 < op2) ? 1 : 0;
                    end
                end
            `SLTU: ALU_out = (op1 < op2) ? 32'd1 : 32'd0;
            `LUI:  ALU_out = op2;
            `OP1:  ALU_out = op1;
            `OP2:  ALU_out = op2;
            `NAND: ALU_out = (~op1) & op2; //CSRRC
            default: ALU_out = 32'b0;
        endcase
    end
endmodule
