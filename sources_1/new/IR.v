`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:02:22
// Design Name: 
// Module Name: IR_ID
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


module IR_ID(
    input clk,
    input bubbleD,
    input flushD,
    input [31:2] addr,
    output  [31:0] inst_ID
    );
    wire [31:0] inst_ID_raw;
    
    InstructionCache InstructionCache1(
        .clk(clk),
        .addr(addr),
        .data(inst_ID_raw)
    );
    
    reg bubble_ff = 1'b0;
    reg flush_ff = 1'b0;
    reg [31:0] inst_ID_old = 32'b0;
    
    always@(posedge clk)
    begin
        bubble_ff <= bubbleD;
        flush_ff <= flushD;
        if(!bubble_ff)  
            inst_ID_old <= inst_ID_raw;
    end
    
    assign inst_ID = bubble_ff ? inst_ID_old : (flush_ff ? 32'b0 : inst_ID_raw);
endmodule
