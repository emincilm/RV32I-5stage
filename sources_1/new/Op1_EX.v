`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:51:09
// Design Name: 
// Module Name: Op1_EX
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


module Op1_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input       [31:0]  reg1,
    output reg  [31:0]  reg1_EX
    );
    
    initial begin
        reg1_EX = 32'b0;
    end
    
    always@(posedge clk)begin
        if (!bubbleE)begin
            if (flushE)begin
                reg1_EX <= 0;
            end else begin
                reg1_EX <= reg1;
            end
        end
    end
endmodule
