`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:48:04
// Design Name: 
// Module Name: Imm_EX
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


module Imm_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input       [31:0]  imm_in,
    output reg  [31:0]  imm_out
    );
    
    initial begin
        imm_out = 32'b0;
    end
    
    always@(posedge clk)begin
        if (!bubbleE)begin
            if (flushE)begin
                imm_out <= 0;
            end else begin
                imm_out <= imm_in;
            end
        end
    end
endmodule
