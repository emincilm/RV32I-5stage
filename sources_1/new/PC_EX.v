`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 13:12:45
// Design Name: 
// Module Name: PC_EX
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


module PC_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input      [31:0]   PC_ID,
    input               predict_taken_ID,
    output reg [31:0]   PC_EX,
    output reg          predict_taken_EX
    );
    
    initial begin
        PC_EX = 32'b0;
        predict_taken_EX = 1'b0;
    end
    
    always @(posedge clk) begin
        if(!bubbleE)begin
            if(flushE)begin
                PC_EX <= 32'b0;
                predict_taken_EX <= 1'b0;
            end else begin
                PC_EX <= PC_ID;
                predict_taken_EX <= predict_taken_ID;
            end
        end
    end
endmodule
