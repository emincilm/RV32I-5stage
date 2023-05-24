`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 15:38:41
// Design Name: 
// Module Name: Reg2_MEM
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


module Reg2_MEM(
    input               clk,
    input               bubbleM,
    input               flushM,
    input       [31:0]  reg2_EX,
    output reg  [31:0]  reg2_MEM
    );
    
    initial begin
        reg2_MEM = 32'b0;
    end
    
    always @(posedge clk) begin
        if(!bubbleM)begin
            if(flushM)begin
                reg2_MEM <= 32'b0;
            end else begin
                reg2_MEM <= reg2_EX;
            end
        end
    end
endmodule
