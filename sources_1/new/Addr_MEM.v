`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 13:40:34
// Design Name: 
// Module Name: Addr_MEM
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


module Addr_MEM(
    input                   clk,
    input                   bubbleM,
    input                   flushM,
    input           [4:0]   reg_dest_EX,
    output  reg     [4:0]   reg_dest_MEM
    );
    
    initial begin
        reg_dest_MEM = 5'b0;
    end
    
    always @(posedge clk) begin
        if(!bubbleM)begin
            if(flushM)begin
                reg_dest_MEM <= 5'b0;
            end else begin
                reg_dest_MEM <= reg_dest_EX;
            end
        end
    end
endmodule
