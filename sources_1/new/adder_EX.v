`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:13:42
// Design Name: 
// Module Name: adder_EX
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


module adder_EX(
    input               clk,
    input               bubbleE,
    input               flushE,
    input      [4:0]    reg1_src_ID,
    input      [4:0]    reg2_src_ID,
    input      [4:0]    reg_dest_ID,
    output reg [4:0]    reg1_src_EX,
    output reg [4:0]    reg2_src_EX,
    output reg [4:0]    reg_dest_EX
    );

    initial begin
        reg1_src_EX = 0;
        reg2_src_EX = 0;
        reg_dest_EX = 0;
    end

    always @(posedge clk ) begin
        if(!bubbleE)begin
          if (flushE) begin
            reg1_src_EX <= 0;
            reg2_src_EX <= 0;
            reg_dest_EX <= 0;
          end else begin
            reg1_src_EX <= reg1_src_ID;
            reg2_src_EX <= reg2_src_ID;
            reg_dest_EX <= reg_dest_ID;
          end
        end
    end
endmodule
