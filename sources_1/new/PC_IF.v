`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 18:19:06
// Design Name: 
// Module Name: PC_IF
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


module PC_IF(
    input                  clk,
    input                  bubbleF,
    input                  flushF,
    input           [31:0] NPC,
    output reg      [31:0] PC
    );
    initial begin
    PC <= 0;    
    end
    always @(posedge clk) begin
        if(!bubbleF)begin
            if(flushF)begin
                PC <= 0;
            end else begin
                PC <= NPC;
            end
        end
    end
    
endmodule
