//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    alu_defines 
// Author(s): Avinash Uttamchandani
// Description: contain a written set of defines for the ALU op codes
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU_DEFINES
`define ALU_DEFINES

`define ALU_OP_AND 4'b0000
`define ALU_OP_OR  4'b0001
`define ALU_OP_XOR 4'b0010
`define ALU_OP_NOR 4'b0011
`define ALU_OP_ADD 4'b0101
`define ALU_OP_SUB 4'b0110
`define ALU_OP_SLT 4'b0111
`define ALU_OP_SRL 4'b1000
`define ALU_OP_SLL 4'b1001
`define ALU_OP_SRA 4'b1010

`endif
