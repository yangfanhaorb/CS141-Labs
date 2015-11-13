`ifndef MIPS_DEFINES
`define MIPS_DEFINES

/* op codes */
`define MIPS_OP_RTYPE       6'b000000 //
//branches and jumps
`define MIPS_OP_J           6'b000010 //
`define MIPS_OP_JAL         6'b000011 //
`define MIPS_OP_BLTZ        6'b000001 //
`define MIPS_OP_BGEZ        6'b000001 //
`define MIPS_OP_BEQ         6'b000100 //
`define MIPS_OP_BNE         6'b000101 //
`define MIPS_OP_BLEZ        6'b000110 //
`define MIPS_OP_BGTZ        6'b000111 //
//immediates
`define MIPS_OP_ADDI        6'b001000 //
`define MIPS_OP_ADDIU       6'b001001 //
`define MIPS_OP_SLTI        6'b001010 //
`define MIPS_OP_SLTIU       6'b001011 //
`define MIPS_OP_ANDI        6'b001100 //
`define MIPS_OP_ORI         6'b001101 //
`define MIPS_OP_XORI        6'b001110 //
`define MIPS_OP_LUI         6'b001111 //
//special
`define MIPS_OP_MFC0        6'b010000 //
`define MIPS_OP_MTC0        6'b010000 //
//load stores...
`define MIPS_OP_LB          6'b100000 //
`define MIPS_OP_LH          6'b100001 //
`define MIPS_OP_LW          6'b100011 //
`define MIPS_OP_LBU         6'b100100 //
`define MIPS_OP_LHU         6'b100101 //
`define MIPS_OP_SB          6'b101000 //
`define MIPS_OP_SH          6'b101001 //
`define MIPS_OP_SW          6'b101011 //

/* funct codes for R-type instructions*/
`define MIPS_FUNCT_AND      6'b100100 //
`define MIPS_FUNCT_OR       6'b100101 //
`define MIPS_FUNCT_XOR      6'b100110 //
`define MIPS_FUNCT_NOR      6'b100111 //
`define MIPS_FUNCT_ADD      6'b100000 //
`define MIPS_FUNCT_ADDU     6'b100001 //
`define MIPS_FUNCT_SUB      6'b100010 //
`define MIPS_FUNCT_SUBU     6'b100011 //
`define MIPS_FUNCT_SLT      6'b101010 //
`define MIPS_FUNCT_SLTU     6'b101011 //
`define MIPS_FUNCT_SLL      6'b000000 //
`define MIPS_FUNCT_SRL      6'b000010 //
`define MIPS_FUNCT_SRA      6'b000011 //
`define MIPS_FUNCT_SLLV     6'b000100 //
`define MIPS_FUNCT_SRLV     6'b000110 //
`define MIPS_FUNCT_SRAV     6'b000111 //

`define MIPS_FUNCT_JR       6'b001000 //
`define MIPS_FUNCT_JALR     6'b001001 //

`define MIPS_FUNCT_SYSCALL  6'b001100 //
`define MIPS_FUNCT_BREAK    6'b001101 //
`define MIPS_FUNCT_MFHI     6'b010000 //
`define MIPS_FUNCT_MTHI     6'b010001 //
`define MIPS_FUNCT_MFLO     6'b010010 //
`define MIPS_FUNCT_MTLO     6'b010011 //

`define MIPS_FUNCT_MULT     6'b011000 //
`define MIPS_FUNCT_MULTU    6'b011001 //
`define MIPS_FUNCT_DIV      6'b011010 //
`define MIPS_FUNCT_DIVU     6'b011011 //

/* instruction types (for internal use) */
`define MIPS_TYPE_WIDTH	      3
`define MIPS_TYPE_R           3'd0
`define MIPS_TYPE_J           3'd1
`define MIPS_TYPE_I           3'd2
`define MIPS_TYPE_M           3'd3
`define MIPS_TYPE_B           3'd4
`define MIPS_TYPE_UNSUPPORTED 3'd5

`endif
