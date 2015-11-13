`include "alu_defines.v"
`include "mips_defines.v"
`include "mips_multicycle_defines.v"
`include "mips_memory_space_defines.v"
`define VERBOSE
`default_nettype none
`timescale 1ns/1ps
/*
	a version of the mips multicycle module with von Nuemann architecture
*/
module mips_multicycle_vn(clk, rst, ena, mem_addr, mem_rd_data, mem_wr_data, mem_wr_ena, PC, full_register_file);

parameter N = 32;

input wire clk, rst, ena;

`include "mips_helper.v"

/* ---- instantiate main modules ---- */
// the following are signals that are critical for the operation of your CPU
//   note: these are all reg type so that you can easily drive combinational logic 
//         through always@(*) blocks.  Not all of these need to be sequential.
reg [3:0] state, next_state;  //state is register, next_state driven comb.
output reg [31:0] PC; //the program counter

//memory signals
output reg [N-1:0] mem_addr, mem_wr_data;
reg [N-1:0] mem_wr_addr, mem_rd_addr;
input wire [N-1:0] mem_rd_data;
output reg mem_wr_ena;

// the following are signals that should prove helpful in implementing your CPU
// but are not strictly required.  Feel free to modify/disregard these if your 
// particular implementation differs
reg [31:0]   next_PC, last_PC; //next_PC is comb., last_PC is a fairly useful register that stores the last succesful PC value
reg PC_ena; //enables the PC to be written
//non-architectural registers
reg IR_ena;
reg [31:0] IR; //holds the current instruction
reg [31:0] DR; //holds the value read out of the data memory
reg [31:0] reg_A, reg_B; //register file read data registers
reg [31:0] alu_last_result, exec_result; 
reg [31:0] instruction_count; // for debugging
reg [9:0] instruction_number;


/* the ALU */
reg  [N-1:0]  alu_src_a, alu_src_b;
wire [N-1:0] alu_result;
wire alu_equal, alu_zero, alu_overflow;
reg  [3:0] alu_op;
alu #(.N(N)) ALU (.x(alu_src_a), .y(alu_src_b), .z(alu_result), .op_code(alu_op), .zero(alu_zero), .equal(alu_equal), .overflow(alu_overflow));

/* register file */
reg reg_wr_ena;
reg [4:0] reg_rd_addr0, reg_rd_addr1, reg_wr_addr;
reg [N-1:0] reg_wr_data; 
wire [N-1:0] reg_rd_data0, reg_rd_data1;
output wire [32*32-1:0] full_register_file;

register_file #(.N(N)) REGISTER_FILE(
	.clk(clk), .rst(rst), .wr_ena(reg_wr_ena),
	.rd_addr0(reg_rd_addr0), .rd_addr1(reg_rd_addr1),
	.rd_data0(reg_rd_data0), .rd_data1(reg_rd_data1),
	.wr_addr(reg_wr_addr), .wr_data(reg_wr_data),
	.full_register_file(full_register_file)
	
);

/* hint: use always @(*) to do comb. logic based on the state and other registers, then have an always @(posedge clk) sequential block to drive all of the registers (architectural and non-architectural) */

/* here's an example structure to get you started... */
always @(*) begin
	case (state) 
		`S_FETCH1 : begin
			next_state = `S_FETCH2;
		end
		`S_FETCH1 : begin
			next_state = `S_EXECUTE;
		end
		/* implement other comb. logic to determine the next state (or other comb. values) here! */
		default: begin
			next_state = `S_FAILURE; //this helps us catch issues with our state machine
		end
	endcase
end

always @(posedge clk) begin
	if(rst) begin
		state <= `S_FETCH1;
		/* be sure to reset all registers to sane values here! */
	end
	else begin
		state <= next_state;
		case (state) 
			`S_FETCH1: begin
				/*control other registers here! */
				mem_rd_addr <= next_PC;
			end
			`S_FETCH2: begin
				/*control other registers here! */
				IR_ena <= 1;
				IR <= mem_rd_data;
			end
			`S_DECODE_AND_FILL: begin
				/*control other registers here! */
				IR_ena <= 0;
				;
			end
			default: begin
				/*always have a default case */
				next_state = `S_FAILURE;
>>>>>>> e60537c8da8be607140d191d012c18552d221321
			end
		endcase
	end
end


endmodule

`default_nettype wire