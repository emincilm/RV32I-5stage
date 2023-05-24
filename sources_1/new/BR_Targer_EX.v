`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:45:16
// Design Name: 
// Module Name: BR_Targer_EX
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


module BR_Target_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input       [31:0]  address,
    output reg  [31:0]  address_EX
    );
    initial begin
        address_EX = 32'b0;
    end
    
    always@(posedge clk) begin
        if (!bubbleE) begin
            if (flushE) begin
                address_EX <= 0;
            end else begin
                address_EX <= address;
            end
        end
    end
endmodule
