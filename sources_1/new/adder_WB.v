`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 16:45:17
// Design Name: 
// Module Name: adder_WB
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


module adder_WB(
    input               clk, 
    input               bubbleW, 
    input               flushW,
    input       [4:0]   reg_dest_MEM,
    output reg  [4:0]   reg_dest_WB
    );

    initial begin
    reg_dest_WB = 5'b0;
    end
    always@(posedge clk)begin
        if (!bubbleW) begin
            if (flushW)begin
                reg_dest_WB <= 5'b0;
            end else begin
                reg_dest_WB <= reg_dest_MEM;
            end
        end
     end
endmodule
