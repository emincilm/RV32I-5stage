`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 17:41:04
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb( );
    
    reg clk = 1'b1;
    reg rst = 1'b1;
    
    always  #2 clk = ~clk;
    initial #8 rst = 1'b0;
    
    RV32ICore RV32ICore_tb_inst
    (
        .CPU_CLK(clk),
        .CPU_RST(rst)
    );
endmodule
