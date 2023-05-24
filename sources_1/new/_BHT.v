`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 09:22:14
// Design Name: 
// Module Name: _BHT
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


module _BHT #(parameter BHT_ADDR_LEN = 10)(
    input clk,
    input rst,
    input [31:0] PC,
    input [31:0] update_PC,
    input is_taken,
    input is_branch,
    output predict_taken
    );
   localparam TAG_ADDR_LEN = 32 - BHT_ADDR_LEN;
    localparam BHT_SIZE     = 1 << BHT_ADDR_LEN;

    reg [1:0] branch_history[BHT_SIZE - 1:0];
    // PC 
    wire [BHT_ADDR_LEN-1:0] bht_addr;
    assign bht_addr = PC[BHT_ADDR_LEN-1:0];
    // update_pC
    wire [BHT_ADDR_LEN-1:0] update_bht_addr;
    assign update_bht_addr = update_PC[BHT_ADDR_LEN-1:0];

    
    localparam STRONGLY_NOT_TAKEN = 2'b00;
    localparam WEAKLY_NOT_TAKEN   = 2'b01; 
    localparam WEAKLY_TAKEN       = 2'b10;
    localparam STRONGLY_TAKEN     = 2'b11;

    assign predict_taken = branch_history[bht_addr][1] ? 1 : 0;
integer i;
     always@(negedge clk or posedge rst) begin 
        if(rst)begin
            for(i = 0; i < BHT_SIZE; i=i + 1)begin
                branch_history[i] <= WEAKLY_TAKEN;  
            end
        end else if(is_branch)  begin
            case (branch_history[update_bht_addr])
                STRONGLY_NOT_TAKEN: begin
                    if(is_taken) branch_history[update_bht_addr] <= WEAKLY_NOT_TAKEN;
                    else branch_history[update_bht_addr] <= STRONGLY_NOT_TAKEN;
                end
                WEAKLY_NOT_TAKEN: begin
                    if(is_taken) branch_history[update_bht_addr] <= WEAKLY_TAKEN;
                    else branch_history[update_bht_addr] <= STRONGLY_NOT_TAKEN;
                end
                WEAKLY_TAKEN:begin
                    if(is_taken) branch_history[update_bht_addr] <= STRONGLY_TAKEN;
                    else branch_history[update_bht_addr] <= WEAKLY_NOT_TAKEN;
                end
                STRONGLY_TAKEN:begin
                    if(is_taken) branch_history[update_bht_addr] <= STRONGLY_TAKEN;
                    else branch_history[update_bht_addr] <= WEAKLY_TAKEN;
                end
            endcase
        end
    end
endmodule
