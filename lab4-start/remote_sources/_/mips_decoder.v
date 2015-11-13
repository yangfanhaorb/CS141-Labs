`timescale 1ns/1ps
`default_nettype none

`include "mips_defines.v"

module mips_decoder(
	instruction,sign_extended_immediate, immediate, sign_extended_shifted_immediate,op_code, funct,shamt,rd,rt,rs,jump_address,type, PC
);

input  wire [31:0] instruction, PC;

output wire [31:0] sign_extended_immediate, sign_extended_shifted_immediate;

output wire [5:0] op_code, funct;
output wire [4:0] shamt;
output wire [4:0] rd, rt, rs;

output wire [15:0] immediate;

output wire [31:0] jump_address;

output reg  [`MIPS_TYPE_WIDTH-1:0] type;

//r-type decode
assign op_code = instruction[31:26];
assign rs      = instruction[25:21];
assign rt      = instruction[20:16];
assign rd      = instruction[15:11];
assign shamt   = instruction[10:6];
assign funct   = instruction[5:0];
//j-type decode
assign jump_address = {PC[31:28], instruction[25:0], 2'b00};
assign sign_extended_immediate = {{16{instruction[15]}}, instruction[15:0]};
//assign sign_extended_shifted_immediate = {instruction[29:0], 2'b00};
assign sign_extended_shifted_immediate = {{14{instruction[15]}}, instruction[15:0], 2'b0};
//figure out instruction type
always @(*) begin
	if (op_code === `MIPS_OP_RTYPE) begin
		type = `MIPS_TYPE_R;
	end
	else if (op_code[5:1] == 5'b00001) begin
		type = `MIPS_TYPE_J;
	end
	else if (op_code[5:3] == 3'b001) begin
		type = `MIPS_TYPE_I;
	end
	else if (op_code[5:4] == 2'b10) begin
		type = `MIPS_TYPE_M;
	end
	else if (op_code[5:2] == 4'b0001) begin
		type = `MIPS_TYPE_B;
	end
	else begin
		type = `MIPS_TYPE_UNSUPPORTED;
	end
end

endmodule
