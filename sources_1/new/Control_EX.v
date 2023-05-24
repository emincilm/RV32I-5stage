`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 13:24:23
// Design Name: 
// Module Name: Control_EX
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


module Control_EX(
    input               clk, 
    input               bubbleE, 
    input               flushE,
    input               jalr_ID,
    input       [3:0]   ALU_func_ID,
    input       [2:0]   br_type_ID,
    input               load_npc_ID,
    input               wb_select_ID,
    input       [2:0]   load_type_ID,
    input               reg_write_en_ID,
    input       [3:0]   cache_write_en_ID,
    input               cache_read_en_ID,
    input               op1_src_ID, op2_src_ID, 
    output reg          jalr_EX,
    output reg  [3:0]   ALU_func_EX,
    output reg  [2:0]   br_type_EX,
    output reg          load_npc_EX,
    output reg          wb_select_EX,
    output reg  [2:0]   load_type_EX,
    output reg          reg_write_en_EX,
    output reg  [3:0]   cache_write_en_EX,
    output reg          cache_read_en_EX,
    output reg          op1_src_EX, 
    output reg          op2_src_EX
    );
    
    initial begin
        jalr_EX = 1'b0;
        ALU_func_EX = 4'b0;
        br_type_EX = 3'b0;
        load_npc_EX = 1'b0;
        wb_select_EX = 1'b0;
        load_type_EX = 2'b0;
        reg_write_en_EX = 1'b0;
        cache_write_en_EX = 3'b0;
        cache_read_en_EX = 1'b0;
        op1_src_EX = 1'b0;
        op2_src_EX = 1'b0;
    end
    
    always @(posedge clk ) begin
        if (!bubbleE) begin
            if (flushE) begin
                jalr_EX = 1'b0;
                ALU_func_EX = 4'b0;
                br_type_EX = 3'b0;
                load_npc_EX = 1'b0;
                wb_select_EX = 1'b0;
                load_type_EX = 2'b0;
                reg_write_en_EX = 1'b0;
                cache_write_en_EX = 3'b0;
                cache_read_en_EX = 1'b0;
                op1_src_EX = 1'b0;
                op2_src_EX = 1'b0;
            end else begin
                jalr_EX <= jalr_ID;
                ALU_func_EX <= ALU_func_ID;
                br_type_EX <= br_type_ID;
                load_npc_EX <= load_npc_ID;
                wb_select_EX <= wb_select_ID;
                load_type_EX <= load_type_ID;
                reg_write_en_EX <= reg_write_en_ID;
                cache_write_en_EX <= cache_write_en_ID;
                cache_read_en_EX <= cache_read_en_ID;
                op1_src_EX <= op1_src_ID;
                op2_src_EX <= op2_src_ID;
            end
        end
    end
    
    
    
endmodule
