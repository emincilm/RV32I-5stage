`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 13:17:21
// Design Name: 
// Module Name: Reg2_EX
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


module Reg2_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input       [31:0]  reg2,
    output reg  [31:0]  reg2_EX
    );
    
    initial begin
        reg2_EX = 32'b0;
    end
    
    always @(posedge clk) begin
        if(!bubbleE) begin
            if(flushE)begin
                reg2_EX <= 32'b0;
            end else begin
                reg2_EX <= reg2;
            end
        end
    end
    
endmodule
