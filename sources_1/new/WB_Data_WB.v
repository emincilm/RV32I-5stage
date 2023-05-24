`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 17:38:05
// Design Name: 
// Module Name: WB_Data_WB
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


module WB_Data_WB(
    input           clk, 
    input           rst, 
    input           bubbleW, 
    input           flushW,
    input           wb_select,
    input   [2:0]   load_type,
    output          miss,       //cache miss??
    input           read_en,     //?cache??
    input   [3:0]   write_en,  //?cache??, ?????byte
    input   [31:0]  addr,
    input   [31:0]  in_data,
    output  [31:0]  data_WB
    );

    wire [31:0] data_raw;
    wire [31:0] data_WB_raw;

    //data cache
    DataCache DataCache1(
        .clk(clk),
        .rst(rst),
        .miss(miss),
        .wr_en(write_en << addr[1:0]),          //??????, ??????byte
        .rd_req(read_en),
        .addr(addr),
        .wr_data(in_data << (8 * addr[1:0])),   //sb?sw???????????????????????????????
        .rd_data(data_raw)
    );

    //??miss??
    reg miss_old;
    always@(posedge clk)
    begin
        if(rst)
            miss_old <= 1'b0;
        else 
            miss_old <= miss;
    end
    reg [31:0] miss_count;
    always@(posedge clk)
    begin
        if(rst)
            miss_count <= 32'd0;
        else if(miss & ~miss_old)   //?????
            miss_count <= miss_count + 32'd1;
    end
    //??hit??
    reg [31:0] hit_count;
    always@(posedge clk)
    begin
        if(rst)
            hit_count <= 32'd0;
        //?miss??????
        else if(~miss & ~miss_old & (read_en|(|write_en)))
            hit_count <= hit_count + 32'd1;
    end

    // Add flush and bubble support
    // if chip not enabled, output output last read result
    // else if chip clear, output 0
    // else output values from cache

    reg bubble_ff = 1'b0;
    reg flush_ff = 1'b0;
    reg wb_select_old = 0;
    reg [31:0] data_WB_old = 32'b0;
    reg [31:0] addr_old;
    reg [2:0] load_type_old;

    DataExtend DataExtend1(
        .data(data_raw),
        .addr(addr_old[1:0]),
        .load_type(load_type_old),
        .dealt_data(data_WB_raw)
    );

    always@(posedge clk)
    begin
        bubble_ff <= bubbleW;
        flush_ff <= flushW;
        data_WB_old <= data_WB;
        addr_old <= addr;
        wb_select_old <= wb_select;
        load_type_old <= load_type;
    end

    assign data_WB = bubble_ff ? data_WB_old :
                                 (flush_ff ? 32'b0 : 
                                             (wb_select_old ? data_WB_raw :
                                                              addr_old));
endmodule
