`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.05.2023 18:23:54
// Design Name: 
// Module Name: NPC_Generator
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


module NPC_Generator(
    input               [31:0] predict_target,
    input               [31:0] jal_target,
    input               [31:0] jalr_target,
    input               [31:0] br_target,
    input                      jal,
    input                      jalr,
    input                      br,
    output reg          [31:0] NPC
    );
    
    always @(*) begin
        if(br)begin
            NPC = br_target;
        end else if (jalr) begin
            NPC = jalr_target;
        end else if (jal) begin
            NPC = jal_target;
        end else begin
            NPC = predict_target;
        end
    end
endmodule
