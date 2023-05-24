`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 16:22:01
// Design Name: 
// Module Name: DataExtend
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
module DataExtend(
    input       [31:0]  data,
    input       [1:0]   addr,
    input       [2:0]   load_type,
    output reg  [31:0]  dealt_data
    );
    
    always @ (*) begin
        if (load_type == `NOREGWRITE)begin
            dealt_data = data;
        end else if (load_type == `LHU) begin
            case(addr)
                2'b00: dealt_data = {16'b0, data[15:0]};
                2'b10: dealt_data = {16'b0, data[31:16]};
                default: dealt_data = 32'b0;
            endcase
        end else if (load_type == `LBU) begin
            case(addr)
                2'b00: dealt_data = {24'b0, data[7:0]};
                2'b01: dealt_data = {24'b0, data[15:8]};
                2'b10: dealt_data = {24'b0, data[23:16]};
                2'b11: dealt_data = {24'b0, data[31:24]};
                default: dealt_data = 32'b0;
            endcase
        end else if (load_type == `LW)begin
            dealt_data = data;
        end else if (load_type == `LH)begin
            case(addr)
                2'b00: dealt_data = {{16{data[15]}}, data[15:0]};
                2'b10: dealt_data = {{16{data[31]}}, data[31:16]};
                default: dealt_data = 32'b0;
            endcase
        end else if (load_type == `LB)begin
            case(addr)
                2'b00: dealt_data = {{24{data[7]}},  data[7:0]};
                2'b01: dealt_data = {{24{data[15]}}, data[15:8]};
                2'b10: dealt_data = {{24{data[23]}}, data[23:16]};
                2'b11: dealt_data = {{24{data[31]}}, data[31:24]};
                default: dealt_data = 32'b0;
            endcase
        end else begin
            dealt_data = 32'b0;
        end

    end
endmodule
