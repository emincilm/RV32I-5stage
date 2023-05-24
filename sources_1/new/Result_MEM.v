`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 15:35:53
// Design Name: 
// Module Name: Result_MEM
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


module Result_MEM(
    input               clk,
    input               bubbleM,
    input               flushM,
    input       [31:0]  result,
    output reg  [31:0]  result_MEM
    );
    initial begin
        result_MEM = 32'b0;
    end
    
    always @(posedge clk) begin
        if(!bubbleM)begin
            if(flushM)begin
                result_MEM <= 32'b0;
            end else begin
                result_MEM <= result;
            end
        end
    end
endmodule
