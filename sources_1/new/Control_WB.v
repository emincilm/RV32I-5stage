`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 16:47:42
// Design Name: 
// Module Name: Control_WB
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


module Control_WB(
    input       clk, 
    input       bubbleW, 
    input       flushW,
    input       reg_write_en_MEM,
    output reg  reg_write_en_WB
    );
    initial begin
    reg_write_en_WB = 1'b0;
    end
    always@(posedge clk)begin
        if (!bubbleW) begin
            if (flushW)begin
                reg_write_en_WB <= 5'b0;
            end else begin
                reg_write_en_WB <= reg_write_en_MEM;
            end
        end
     end
endmodule
