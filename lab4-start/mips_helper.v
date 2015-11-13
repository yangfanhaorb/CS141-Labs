
function [200:0] op_code_string;
	input [5:0] op_code;
	begin
		case(op_code) 
			//r types
			`MIPS_OP_RTYPE       : op_code_string = "r-type";
			//branches and jumps
			`MIPS_OP_J           : op_code_string = "j";
			`MIPS_OP_JAL         : op_code_string = "jal";
			`MIPS_OP_BLTZ        : op_code_string = "bltz";
			`MIPS_OP_BGEZ        : op_code_string = "bgez";
			`MIPS_OP_BEQ         : op_code_string = "beq";
			`MIPS_OP_BNE         : op_code_string = "bne";
			`MIPS_OP_BLEZ        : op_code_string = "blez";
			`MIPS_OP_BGTZ        : op_code_string = "bgtz";
			//immediates
			`MIPS_OP_ADDI        : op_code_string = "addi";
			`MIPS_OP_ADDIU       : op_code_string = "addiu";
			`MIPS_OP_SLTI        : op_code_string = "slti";
			`MIPS_OP_SLTIU       : op_code_string = "sltiu";
			`MIPS_OP_ANDI        : op_code_string = "andi";
			`MIPS_OP_ORI         : op_code_string = "ori";
			`MIPS_OP_XORI        : op_code_string = "xori";
			`MIPS_OP_LUI         : op_code_string = "lui";
			//special
			`MIPS_OP_MFC0        : op_code_string = "mfc0";
			`MIPS_OP_MTC0        : op_code_string = "mtc0";
			//load stores...
			`MIPS_OP_LB          : op_code_string = "lb";
			`MIPS_OP_LH          : op_code_string = "lh";
			`MIPS_OP_LW          : op_code_string = "lw";
			`MIPS_OP_LBU         : op_code_string = "lbu";
			`MIPS_OP_LHU         : op_code_string = "lhu";
			`MIPS_OP_SB          : op_code_string = "sb";
			`MIPS_OP_SH          : op_code_string = "sh";
			`MIPS_OP_SW          : op_code_string = "sw";
			default              : op_code_string = "unknown op";
		endcase
	end
endfunction

function [200:0] funct_code_string;
	input [5:0] funct_code;
	begin
		case(funct_code) 
			`MIPS_FUNCT_AND      : funct_code_string = "and"; //
			`MIPS_FUNCT_OR       : funct_code_string = "or"; //
			`MIPS_FUNCT_XOR      : funct_code_string = "xor"; //
			`MIPS_FUNCT_NOR      : funct_code_string = "nor"; //
			`MIPS_FUNCT_ADD      : funct_code_string = "add"; //
			`MIPS_FUNCT_ADDU     : funct_code_string = "addu"; //
			`MIPS_FUNCT_SUB      : funct_code_string = "sub"; //
			`MIPS_FUNCT_SUBU     : funct_code_string = "subu"; //
			`MIPS_FUNCT_SLT      : funct_code_string = "slt"; //
			`MIPS_FUNCT_SLTU     : funct_code_string = "sltu"; //
			`MIPS_FUNCT_SLL      : funct_code_string = "sll"; //
			`MIPS_FUNCT_SRL      : funct_code_string = "srl"; //
			`MIPS_FUNCT_SRA      : funct_code_string = "sra"; //
			`MIPS_FUNCT_SLLV     : funct_code_string = "sllv"; //
			`MIPS_FUNCT_SRLV     : funct_code_string = "srlv"; //
			`MIPS_FUNCT_SRAV     : funct_code_string = "srav"; //

			`MIPS_FUNCT_JR       : funct_code_string = "jr"; //
			`MIPS_FUNCT_JALR     : funct_code_string = "jalr"; //

			`MIPS_FUNCT_SYSCALL  : funct_code_string = "syscall"; //
			`MIPS_FUNCT_BREAK    : funct_code_string = "break"; //
			`MIPS_FUNCT_MFHI     : funct_code_string = "mfhi"; //
			`MIPS_FUNCT_MTHI     : funct_code_string = "mthi"; //
			`MIPS_FUNCT_MFLO     : funct_code_string = "mflo"; //
			`MIPS_FUNCT_MTLO     : funct_code_string = "mtlo"; //

			`MIPS_FUNCT_MULT     : funct_code_string = "mult"; //
			`MIPS_FUNCT_MULTU    : funct_code_string = "multu"; //
			`MIPS_FUNCT_DIV      : funct_code_string = "div"; //
			`MIPS_FUNCT_DIVU     : funct_code_string = "divu"; //
			default              : funct_code_string = "unknown funct";
		endcase
	end
endfunction

