`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 10:50:30
// Design Name: 
// Module Name: _BTB
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


module _BTB #(parameter BTB_ADDR_LEN = 10)(
    input               clk,
    input               rst,
    input      [31:0]   PC,
    input      [31:0]   update_PC,
    input      [31:0]   update_target,
    input               update,
    output reg          btb_valid,
    output reg [31:0]   predict_target
    );

    localparam TAG_ADDR_LEN    = 32 - BTB_ADDR_LEN;     
    localparam BTB_SIZE        = 1 << BTB_ADDR_LEN;     

    reg [            31:0] target_addr [BTB_SIZE - 1:0];      
    reg [TAG_ADDR_LEN-1:0] tags        [BTB_SIZE - 1:0];      
    reg                    valid       [BTB_SIZE - 1:0];      

    wire [BTB_ADDR_LEN-1:0] btb_addr;
    wire [TAG_ADDR_LEN-1:0] tag_addr;
    assign {tag_addr, btb_addr} = PC;

    wire [BTB_ADDR_LEN-1:0] update_btb_addr;
    wire [TAG_ADDR_LEN-1:0] update_tag_addr;
    assign {update_tag_addr, update_btb_addr} = update_PC;

    always @ (*) begin             
        if(valid[btb_addr] && tags[btb_addr] == tag_addr)begin
            btb_valid = 1'b1;
            predict_target = target_addr[btb_addr];
        end else begin
            btb_valid = 1'b0;
            predict_target = PC + 4; 
        end
    end
    integer i;
    always@(negedge clk or posedge rst) begin 
        if(rst) begin
            for( i = 0; i < BTB_SIZE; i= i + 1)
            begin
                target_addr[i] <= 0;
                tags[i] <= 0;
                valid[i] <= 0;
            end
        end else if(update)begin
            tags[update_btb_addr] <= update_tag_addr;
            valid[update_btb_addr] <= 1'b1;
            target_addr[update_btb_addr] <= update_target;
        end
    end
endmodule
