`include "alu_defines.v"

`default_nettype none
`timescale 1ns/1ps

module alu(x,y,op_code, z, equal, zero, overflow);

	parameter N = 32;
	input wire [(N-1):0] x, y;
	input wire [3:0] op_code;
	output reg [(N-1):0] z;
	output wire equal, zero, overflow;
	wire signed [31:0] x_s, y_s;
	assign x_s = x;
	assign y_s = y;
	
	always @(*) begin
		case (op_code)
			`ALU_OP_AND : z = x & y;
			`ALU_OP_OR  : z = x | y;
			`ALU_OP_XOR : z = x ^ y;
			`ALU_OP_NOR : z = ~(x | y);
			`ALU_OP_SLT : z = {31'b0, x_s < y_s}; 
			`ALU_OP_SLL : z = x << y;
			`ALU_OP_SRL : z = x >> y;
			`ALU_OP_ADD : z = x + y;
			`ALU_OP_SUB : z = x - y;
			`ALU_OP_SRA : z = x_s >>> y_s;
			default : z = 0;
		endcase
	end
	assign equal = (x === y);
	assign zero = (z === 32'd0);

endmodule


`default_nettype wire
