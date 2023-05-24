`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 15:23:09
// Design Name: 
// Module Name: CSR_EX
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


module CSR_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input       [11:0]  CSR_addr_ID,
    input       [31:0]  CSR_zimm_ID,
    input               CSR_zimm_or_reg_ID,
    input               CSR_write_en_ID,
    output reg  [11:0]  CSR_addr_EX,
    output reg  [31:0]  CSR_zimm_EX,
    output reg          CSR_zimm_or_reg_EX,
    output reg          CSR_write_en_EX
    );
    
    initial begin
        CSR_addr_EX             = 12'b0;       
        CSR_zimm_EX             = 32'b0;       
        CSR_zimm_or_reg_EX      = 1'b0;
        CSR_write_en_EX         = 1'b0;
    end
    
    always@(posedge clk) begin
        if (!bubbleE)begin   //not stall
            if (flushE)begin
                CSR_addr_EX <= 0;
                CSR_zimm_EX <= 0;
                CSR_zimm_or_reg_EX <= 0;
                CSR_write_en_EX <= 0;
            end else begin
                CSR_addr_EX <= CSR_addr_ID;
                CSR_zimm_EX <= CSR_zimm_ID;
                CSR_zimm_or_reg_EX <= CSR_zimm_or_reg_ID;
                CSR_write_en_EX <= CSR_write_en_ID;
            end
        end
    end
endmodule
