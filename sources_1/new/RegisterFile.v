`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 11:18:54
// Design Name: 
// Module Name: RegisterFile
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

module RegisterFile (
    input clk,
    input rst,
    input write_en,
    input [4:0] addr1,
    input [4:0] addr2,
    input [4:0] wb_addr,
    output [31:0] wb_data,
    output [31:0] reg1,
    output [31:0] reg2
    );

    reg [31:0] memory [1:1023];     //x0 == 0
    integer i;

    initial begin
        for (i=1; i < 1024; i = i + 1) begin
            memory[i][31:0] <= 32'b0;
        end
    end

    // write in clk negedge, reset in rst posedge
    // if write register in clk posedge,
    // new wb data also write in clk posedge,
    // so old wb data will be written to output register
    always @(negedge clk or posedge rst) begin
        if (rst) begin
            for (i=1; i < 1024; i = i + 1) begin
            memory[i][31:0] <= 32'b0;
            end
        end else if (write_en && (wb_addr != 5'b0)) begin
            memory[wb_addr] <= wb_data;
        end
    end
    
    // read data changes when address changes
    assign reg1 = (addr1 == 5'b0) ? 32'h0 : memory[addr1];
    assign reg2 = (addr2 == 5'b0) ? 32'h0 : memory[addr2];
endmodule
