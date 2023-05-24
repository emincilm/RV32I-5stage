`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 15:41:25
// Design Name: 
// Module Name: Control_MEM
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


module Control_MEM(
    input  clk, 
    input               bubbleM, 
    input               flushM,
    input               wb_select_EX,
    input       [2:0]   load_type_EX,
    input               reg_write_en_EX,
    input       [3:0]   cache_write_en_EX,
    input               cache_read_en_EX,
    output reg          wb_select_MEM,
    output reg  [2:0]   load_type_MEM,
    output reg          reg_write_en_MEM,
    output reg  [3:0]   cache_write_en_MEM,
    output reg          cache_read_en_MEM
    );

    initial 
    begin
        wb_select_MEM = 1'b0;
        load_type_MEM = 3'b0;
        reg_write_en_MEM = 1'b0;
        cache_write_en_MEM = 4'b0;
        cache_read_en_MEM = 1'b0;
    end
    
    always@(posedge clk)begin
        if (!bubbleM)begin
            if (flushM)begin
                    wb_select_MEM       = 1'b0;
                    load_type_MEM       = 3'b0;
                    reg_write_en_MEM    = 1'b0;
                    cache_write_en_MEM  = 4'b0;
                    cache_read_en_MEM   = 1'b0;
            end else begin
                wb_select_MEM <= wb_select_EX;
                load_type_MEM <= load_type_EX;
                reg_write_en_MEM <= reg_write_en_EX;
                cache_write_en_MEM <= cache_write_en_EX;
                cache_read_en_MEM <= cache_read_en_EX;
            end
        end
      end
endmodule
