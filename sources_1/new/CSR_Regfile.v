`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 15:30:37
// Design Name: 
// Module Name: CS_Regfile
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


module CSR_Regfile #(parameter CSR_ADDR_LEN = 4)(
    input clk,
    input rst,
    input CSR_write_en,
    input [11:0] CSR_write_addr,
    input [11:0] CSR_read_addr,
    input [31:0] CSR_data_write,
    output [31:0] CSR_data_read
    );
    
    localparam CSR_SIZE = 1 << CSR_ADDR_LEN;
    localparam UNUSED_ADDR_LEN = 12 - CSR_ADDR_LEN;
    
    reg [31:0] CSR[CSR_SIZE-1 : 0];
    integer i;

    wire [CSR_ADDR_LEN-1   : 0] write_addr;
    wire [UNUSED_ADDR_LEN-1: 0] unused_write_addr;
    assign {unused_write_addr, write_addr} = CSR_write_addr;

    wire [CSR_ADDR_LEN-1   : 0] read_addr;
    wire [UNUSED_ADDR_LEN-1: 0] unused_read_addr;
    assign {unused_read_addr, read_addr} = CSR_read_addr;

    // init CSR file
    initial
    begin
        for(i = 0; i < CSR_SIZE; i = i + 1) 
            CSR[i][31:0] <= 32'b0;
    end

    // write in clk posedge, so read data will be the old one
    always@(posedge clk or posedge rst) 
    begin 
        if (rst)
            for (i = 0; i < CSR_SIZE; i = i + 1) 
                CSR[i][31:0] <= 32'b0;
        else if(CSR_write_en)
            CSR[write_addr] <= CSR_data_write;   
    end

    // read CSR file
    assign CSR_data_read = CSR[read_addr];
endmodule
