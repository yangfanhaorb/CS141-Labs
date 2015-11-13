`include "mips_defines.v"
`include "mips_multicycle_defines.v"
`include "alu_defines.v"
`default_nettype none
`timescale 1ns/1ps

module mips_alu_op_decode(instruction_type, op_code, funct_code, alu_src_b_sw, alu_op);

input wire [`MIPS_TYPE_WIDTH-1:0] instruction_type;
input wire [5:0] op_code, funct_code;
output reg [`ALU_OP_WIDTH-1:0] alu_op;
output reg [`ALU_SRC_B_SW_WIDTH-1:0] alu_src_b_sw;

always @(*) begin
	case(instruction_type)
		`MIPS_TYPE_R : begin
			alu_src_b_sw = `ALU_SRC_B_SW_REG_B;
			case (funct_code)
				`MIPS_FUNCT_AND  :	alu_op = `ALU_OP_AND;
				`MIPS_FUNCT_OR   :	alu_op = `ALU_OP_OR ;
				`MIPS_FUNCT_XOR  :	alu_op = `ALU_OP_XOR;	
				`MIPS_FUNCT_NOR  :	alu_op = `ALU_OP_NOR;
				`MIPS_FUNCT_ADD  :	alu_op = `ALU_OP_ADD;
				`MIPS_FUNCT_ADDU :	alu_op = `ALU_OP_ADD;
				`MIPS_FUNCT_SUB  :	alu_op = `ALU_OP_SUB;
				`MIPS_FUNCT_SUBU :	alu_op = `ALU_OP_SUB;
				`MIPS_FUNCT_SLL  :	alu_op = `ALU_OP_SLL;
				`MIPS_FUNCT_SLLV :	alu_op = `ALU_OP_SLL;
				`MIPS_FUNCT_SRL  :	alu_op = `ALU_OP_SRL;
				`MIPS_FUNCT_SRLV :	alu_op = `ALU_OP_SRL;
				`MIPS_FUNCT_SRA  :	alu_op = `ALU_OP_SRA;
				`MIPS_FUNCT_SRAV :	alu_op = `ALU_OP_SRA;
				default          :	alu_op = `ALU_OP_ADD;
			endcase
		end
		`MIPS_TYPE_I : begin
			alu_src_b_sw = `ALU_SRC_B_SW_SEI;
			case (op_code)
				`MIPS_OP_ADDI, `MIPS_OP_ADDIU : alu_op = `ALU_OP_ADD;
				`MIPS_OP_SLTI, `MIPS_OP_SLTIU : alu_op = `ALU_OP_SLT;
				`MIPS_OP_ANDI                 : alu_op = `ALU_OP_AND;
				`MIPS_OP_ORI                  : alu_op = `ALU_OP_OR;
				`MIPS_OP_XORI                 : alu_op = `ALU_OP_XOR;
				default                       : alu_op = `ALU_OP_ADD;
			endcase
		end
		`MIPS_TYPE_M : begin
			alu_op = `ALU_OP_ADD;
			alu_src_b_sw = `ALU_SRC_B_SW_SEI;
		end
		/* ---------------- EXEC J ---------------- */
		`MIPS_TYPE_J : begin
			alu_src_b_sw = `ALU_SRC_B_SW_REG_B;
			alu_op = `ALU_OP_ADD;
		end
		/* ---------------- EXEC B ---------------- */
		`MIPS_TYPE_B : begin
			alu_op = `ALU_OP_ADD;
			alu_src_b_sw = `ALU_SRC_B_SW_REG_B;
		end
	endcase
end
endmodule

`default_nettype wire
