`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2023 14:04:33
// Design Name: 
// Module Name: BranchDesicion
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
module BranchDecision(
    input       [31:0]  reg1,
    input       [31:0]  reg2,
    input       [2:0]   br_type,
    input               predict_taken,
    input       [31:0]  br_target,
    input       [31:0]  current_pc,
    output reg  [31:0]  target,
    output reg          taken,
    output reg          predict_wrong,
    output reg          is_branch
    );
    always @ (*) begin
        case(br_type)
            `NOBRANCH: begin 
                taken = 0;
                is_branch = 0;
            end
            `BEQ:  begin
                taken = (reg1 == reg2) ? 1 : 0;
                is_branch = 1;
            end
            `BNE:  begin
                taken = (reg1 == reg2) ? 0 : 1;
                is_branch = 1;
            end
            `BLTU: begin
                taken = (reg1 <  reg2) ? 1 : 0;
                is_branch = 1;
            end
            `BGEU: begin
                taken = (reg1 >= reg2) ? 1 : 0;
                is_branch = 1;
            end
            `BLT:  begin
                if (reg1[31]==0 && reg2[31]==1)
                    taken = 0;
                else if (reg1[31]==1 && reg2[31]==0)
                    taken = 1;
                else if (reg1[31]==1 && reg2[31]==1)
                    taken = (reg1 < reg2) ? 1 : 0;
                else
                    taken = (reg1 < reg2) ? 1 : 0;
                
                is_branch = 1;
            end
            `BGE:  begin
                if (reg1[31]==0 && reg2[31]==1)
                    taken = 1;
                else if (reg1[31]==1 && reg2[31]==0)
                    taken = 0;
                else if (reg1[31]==1 && reg2[31]==1)
                    taken = (reg1 >= reg2) ? 1 : 0;
                else
                    taken = (reg1 >= reg2) ? 1 : 0;
                
                is_branch = 1;
            end
            default: begin
                taken = 0;
                is_branch = 0;
            end
        endcase

        predict_wrong = taken ^ predict_taken;  

        if (taken)begin
            target = br_target;
        end else begin 
            target = current_pc + 4;
        end
    end
    
endmodule
