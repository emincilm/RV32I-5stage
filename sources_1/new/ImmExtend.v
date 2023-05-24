`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:41:04
// Design Name: 
// Module Name: ImmExtend
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

`include "Parameters.vh" 
module ImmExtend(
    input      [31:7]   inst,
    input      [2:0]    imm_type,
    output reg [31:0]   imm
    );
    `include "Parameters.vh"
    always@(*)begin
        case(imm_type)
            // Parameters.v defines all immediate type
            `ITYPE:     imm = {{21{inst[31]}}, inst[30:20]};
            `STYPE:     imm = {{21{inst[31]}}, inst[30:25], inst[11:7]};
            `BTYPE:     imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            `UTYPE:     imm = {inst[31:12], 12'd0};
            `JTYPE:     imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            default:    imm = 32'b0;
        endcase
    end
endmodule
