`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:04:58
// Design Name: 
// Module Name: PC_ID
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


module PC_ID(
    input               clk,
    input               bubbleD,
    input               flushD,
    input      [31:0]   PC_IF,
    input               predict_taken,
    output reg [31:0]   PC_ID,
    output reg          predict_taken_ID
    );
    
    initial begin
        PC_ID = 0;
        predict_taken_ID = 0;
    end

    always @(posedge clk ) begin
        if (!bubbleD) begin
            PC_ID            <= 0;
            predict_taken_ID <= 0;
        end else begin
            PC_ID <= PC_IF;
            predict_taken_ID <= predict_taken;
        end
    end
    
endmodule
