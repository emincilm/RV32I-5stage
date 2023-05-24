`timescale 1ns / 1ps

`ifndef CONST_VALUES
`define CONST_VALUES
// ALU_func[3:0]
    `define SLL     4'b0000
    `define SRL     4'b0001
    `define SRA     4'b0010
    `define ADD     4'b0011
    `define SUB     4'b0100
    `define XOR     4'b0101
    `define OR      4'b0110
    `define AND     4'b0111
    `define SLT     4'b1000
    `define SLTU    4'b1001
    `define LUI     4'b1010
    `define OP1     4'b1011
    `define OP2     4'b1100
    `define NAND    4'b1101
// br_type[2:0]
    `define NOBRANCH    3'b000
    `define BEQ         3'b001
    `define BNE         3'b010
    `define BLT         3'b011
    `define BLTU        3'b100
    `define BGE         3'b101
    `define BGEU        3'b110
// imm_type[2:0]
    `define RTYPE  3'b000
    `define ITYPE  3'b001
    `define STYPE  3'b010
    `define BTYPE  3'b011
    `define UTYPE  3'b100
    `define JTYPE  3'b101  
// load_type[2:0]  six kind of ways to save values to Register
    `define NOREGWRITE  3'b000	        //	Do not write Register
    `define LB          3'b001			//	load 8bit from Mem then signed extended to 32bit
    `define LH          3'b010			//	load 16bit from Mem then signed extended to 32bit
    `define LW          3'b011			//	write 32bit to Register
    `define LBU         3'b100			//	load 8bit from Mem then unsigned extended to 32bit
    `define LHU         3'b101			//	load 16bit from Mem then unsigned extended to 32bit
// instruction encode
    // U-Type
    `define U_LUI 7'b0110111
    `define U_AUIPC 7'b0010111
    // J-Type
    `define J_JAL   7'b1101111
    `define J_JALR  7'b1100111
    // B-Type
    `define B_TYPE  7'b1100011
    `define B_BEQ   3'b000
    `define B_BNE   3'b001
    `define B_BLT   3'b100
    `define B_BGE   3'b101
    `define B_BLTU  3'b110
    `define B_BGEU  3'b111
    // I-Type (not contain CSR)
    // I-Type-Load
    `define I_LOAD  7'b0000011
    `define I_LB    3'b000
    `define I_LH    3'b001
    `define I_LW    3'b010
    `define I_LBU   3'b100
    `define I_LHU   3'b101
    // I-Type-Arithmetic
    `define I_ARI       7'b0010011
    `define I_ADDI      3'b000
    `define I_SLTI      3'b010
    `define I_SLTIU     3'b011
    `define I_XORI      3'b100
    `define I_ORI       3'b110
    `define I_ANDI      3'b111
    `define I_SLLI      3'b001
    `define I_SR        3'b101
    `define I_SRAI      7'b0100000
    `define I_SRLI      7'b0000000
    // S-Type
    `define S_TYPE  7'b0100011
    `define S_SB    3'b000
    `define S_SH    3'b001
    `define S_SW    3'b010
    // R-Type
    `define R_TYPE  7'b0110011
    `define R_AS    3'b000
    `define R_ADD   7'b0000000
    `define R_SUB   7'b0100000
    `define R_SLL   3'b001
    `define R_SLT   3'b010
    `define R_SLTU  3'b011
    `define R_XOR   3'b100
    `define R_SR    3'b101
    `define R_SRL   7'b0000000
    `define R_SRA   7'b0100000
    `define R_OR    3'b110
    `define R_AND   3'b111
    // I-CSR
    `define I_CSR       7'b1110011
    `define I_CSRRC     3'b011
    `define I_CSRRCI    3'b111
    `define I_CSRRS     3'b010
    `define I_CSRRSI    3'b110
    `define I_CSRRW     3'b001
    `define I_CSRRWI    3'b101

`endif

