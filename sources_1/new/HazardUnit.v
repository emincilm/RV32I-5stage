`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 14:12:21
// Design Name: 
// Module Name: HazardUnit
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
module HarzardUnit(
    input  rst,
    input  miss,
    input       [4:0]   reg1_srcD, 
    input       [4:0]   reg2_srcD, 
    input       [4:0]   reg1_srcE, 
    input       [4:0]   reg2_srcE, 
    input       [4:0]   reg_dstE, 
    input       [4:0]   reg_dstM, 
    input       [4:0]   reg_dstW,
    input               br, 
    input               jalr, 
    input               jal,
    input               wb_select,
    input               reg_write_en_MEM,
    input               reg_write_en_WB,
    output reg          flushF, 
    output reg          bubbleF, 
    output reg          flushD, 
    output reg          bubbleD, 
    output reg          flushE,
    output reg          bubbleE, 
    output reg          flushM, 
    output reg          bubbleM, 
    output reg          flushW, 
    output reg          bubbleW,
    output reg [1:0]    op1_sel, 
    output reg [1:0]    op2_sel
    );
    
    
    // generate op1_sel
    always @ (*)begin 
        if (reg1_srcE == reg_dstM && reg_write_en_MEM == 1 && reg1_srcE != 0) begin
            // mem to ex forwarding, mem forwarding first
            op1_sel = 2'b01;
        end else if (reg1_srcE == reg_dstW && reg_write_en_WB == 1 && reg1_srcE != 0) begin
            // wb to ex forwarding
            op1_sel = 2'b10;
        end else begin
            op1_sel = 2'b00;
        end
    end

    // generate op2_sel
    always @ (*) begin 
        if (reg2_srcE == reg_dstM && reg_write_en_MEM == 1 && reg2_srcE != 0) begin
            // mem to ex forwarding, mem forwarding first
            op2_sel = 2'b01;
        end else if (reg2_srcE == reg_dstW && reg_write_en_WB == 1 && reg2_srcE != 0)begin
            // wb to ex forwarding
            op2_sel = 2'b10;
        end else begin
            op2_sel = 2'b00;
        end
    end

    // generate bubbleF and flushF
    always @ (*) begin
        if (rst) begin
            bubbleF = 0;
            flushF = 1;
        end else if (wb_select==1 && (reg1_srcD==reg_dstE || reg2_srcD==reg_dstE))begin//load-use
            bubbleF = 1;
            flushF = 0;
        end else if(miss)begin  //cache miss
            bubbleF = 1;
            flushF = 0;
        end else begin
            bubbleF = 0;
            flushF = 0;
        end
    end

    // generate bubbleD and flushD
    always @ (*) begin
        if (rst)begin
            bubbleD = 0;
            flushD = 1;
        end else if (wb_select==1 && (reg1_srcD==reg_dstE || reg2_srcD==reg_dstE))begin //load-use
            bubbleD = 1;
            flushD = 0;
        end else if(miss)begin//cache miss
            bubbleD = 1;
            flushD = 0;
        end else if (jalr || br) begin //jalr or br
            bubbleD = 0;
            flushD = 1;
        end else if(jal)begin   //jal
            bubbleD = 0;
            flushD = 1;
        end else begin
            bubbleD = 0;
            flushD = 0;
        end
    end

    // generate bubbleE and flushE
    always @ (*) begin
        if (rst) begin
            bubbleE = 0;
            flushE = 1;
        end else if (wb_select==1 && (reg1_srcD==reg_dstE || reg2_srcD==reg_dstE))begin //load-use
            bubbleE = 0;
            flushE = 1;
        end else if(miss) begin  //cache miss
            bubbleE = 1;
            flushE = 0;
        end else if (jalr || br) begin //jalr or br
            bubbleE = 0;
            flushE = 1;
        end else begin
            bubbleE = 0;
            flushE = 0;
        end
    end

    // generate bubbleM and flushM
    always @ (*) begin
        if (rst) begin
            bubbleM = 0;
            flushM = 1;
        end else if(miss) begin //cache miss
            bubbleM = 1;
            flushM = 0;
        end else begin
            bubbleM = 0;
            flushM = 0;
        end
    end

    // generate bubbleW and flushW
    always @ (*) begin
        if (rst) begin
            bubbleW = 0;
            flushW = 1;
        end else if(miss) begin   //cache miss
            bubbleW = 1;
            flushW = 0;
        end else begin
            bubbleW = 0;
            flushW = 0;
        end
    end
    
endmodule
