`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 09:07:16
// Design Name: 
// Module Name: BranchPredictior
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
// Branch Target Buffer 

module BranchPredictor(
    input               clk,
    input               rst,
    input       [31:0]  PC,
    input       [31:0]  update_PC,
    input       [31:0]  real_target,
    input               real_taken,
    input               predict_wrong,
    input               is_branch,
    output reg          predict_taken,
    output reg [31:0]   predict_target
    );

    wire btb_valid;
    wire bht_result;
    wire update_btb;
    
    wire [31:0] btb_result;
    
    assign update_btb = predict_wrong & real_taken;

    always @(*) begin
        predict_taken = btb_valid & bht_result;
        if (predict_taken) begin
            predict_target = bht_result;
        end else begin
            predict_target = PC + 4;
        end
    end

     _BTB #(
        .BTB_ADDR_LEN (8)    
    ) btb_inst (
        .clk(clk), 
        .rst(rst),
        .PC(PC),                   
        .update_PC(update_PC),                               
        .update_target(real_target),                      
        .update(update_btb),                   
        .btb_valid(btb_valid),               
        .predict_target(btb_result)         
    );

    _BHT #(
        .BHT_ADDR_LEN (10)    
    ) bht_inst (
        .clk(clk), 
        .rst(rst),
        .PC(PC),                   
        .update_PC(update_PC),            
        .is_taken(real_taken),                    
        .is_branch(is_branch),                   
        .predict_taken(bht_result)              
    );
endmodule
