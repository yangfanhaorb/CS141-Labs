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
reg shift; // for logic with shifts


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

// control signals
reg [1:0] op_code_type; 
reg branching;

// IR decode
wire [4:0] rs, rt, rd;
wire [5:0] shamt;
reg [15:0] immi;
reg [31:0] sign_extended_immi;

reg [31:0] jPC;
wire [31:0] jaddr;
wire [27:0] newtest;

wire[31:0] sign_ext_wire;
assign sign_ext_wire = sign_extended_immi;

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
			alu_src_a = next_PC;
			alu_src_b = 32'd4;
			alu_op = `ALU_OP_ADD;
			mem_rd_addr = next_PC;
			mem_wr_ena =0;
			reg_wr_ena = 0;
			branching = 0;
			reg_wr_data = alu_last_result;
		end
		`S_FETCH2 : begin
			next_state = `S_DECODE;
			reg_wr_data = alu_last_result;
		end
		`S_DECODE : begin
		
			reg_wr_data = alu_last_result;
			//next_state = `S_EXECUTE;
		
			case (IR[31:26])
				`MIPS_OP_J: begin
					next_state = `S_FETCH1;
				end
				`MIPS_OP_BEQ: begin
					next_state = `S_EXECUTE;
					alu_op = `ALU_OP_ADD;
					alu_src_a = next_PC;
					alu_src_b = sign_extended_immi<<2;
				end
				`MIPS_OP_BNE: begin
					next_state = `S_EXECUTE;
					alu_op = `ALU_OP_ADD;
					alu_src_a = next_PC;
					alu_src_b = sign_extended_immi<<2;
				end
				
				default: next_state = `S_EXECUTE;
			endcase
			
			
		end
		`S_EXECUTE : begin
		
		
			reg_wr_data = alu_last_result;
			//ALU CONTROL
			case (op_code_type)
				`OP_CODE_TYPE_R: begin
					case (IR[5:0])
						`MIPS_FUNCT_AND: alu_op = `ALU_OP_AND;
						`MIPS_FUNCT_OR: alu_op = `ALU_OP_OR;
						`MIPS_FUNCT_XOR: alu_op = `ALU_OP_XOR;
						`MIPS_FUNCT_NOR: alu_op = `ALU_OP_NOR;
						`MIPS_FUNCT_SLL: alu_op = `ALU_OP_SLL;
						`MIPS_FUNCT_SRL: alu_op = `ALU_OP_SRL;
						`MIPS_FUNCT_SRA: alu_op = `ALU_OP_SRA;
						`MIPS_FUNCT_SLT: alu_op = `ALU_OP_SLT;
						`MIPS_FUNCT_ADD: alu_op = `ALU_OP_ADD;
						`MIPS_FUNCT_SUB: alu_op = `ALU_OP_SUB;
					endcase
				end
				`OP_CODE_TYPE_I: begin
					case (IR[31:26])
						`MIPS_OP_ANDI: alu_op = `ALU_OP_AND;
						`MIPS_OP_ORI: alu_op = `ALU_OP_OR;
						`MIPS_OP_XORI: alu_op = `ALU_OP_XOR;
						`MIPS_OP_SLTI: alu_op = `ALU_OP_SLT;
						`MIPS_OP_ADDI: alu_op = `ALU_OP_ADD;
						`MIPS_OP_LW: alu_op = `ALU_OP_ADD;
						`MIPS_OP_SW: alu_op = `ALU_OP_ADD;
					endcase
				end
				//`OP_CODE_TYPE_BRANCH: begin
					//alu_op = `ALU_OP_SUB;
				//end
			endcase 
			case (IR[31:26]) 
				`MIPS_OP_RTYPE: begin
						if (IR[5:0]==`MIPS_FUNCT_JR)begin
							next_state = `S_FETCH1;
						end
						else begin
							next_state = `S_MEMORY;
						end
					end
				`MIPS_OP_BEQ: begin
					next_state = `S_FETCH1;
					alu_op = `ALU_OP_SUB;
				end
				`MIPS_OP_BNE: begin
					next_state = `S_FETCH1;
					alu_op = `ALU_OP_SUB;
				end
				default: next_state = `S_MEMORY;
			endcase
				
			
			// alu src control
			case (op_code_type)
				`OP_CODE_TYPE_R: begin 
					// alu src mux for shift
					if ((IR[5:0]==`MIPS_FUNCT_SLL) | (IR[5:0]==`MIPS_FUNCT_SRL) | (IR[5:0]==`MIPS_FUNCT_SRA)) begin
						alu_src_a = reg_B;
						alu_src_b = IR[10:6];
					end
					else begin
						alu_src_a = reg_A;
						alu_src_b = reg_B;
					end
				end
				
				`OP_CODE_TYPE_I: begin
					alu_src_a = reg_A;
					alu_src_b = sign_extended_immi;
					mem_rd_addr = alu_result;
				end
				`OP_CODE_TYPE_J: begin
					if (IR[31:26] ==`MIPS_OP_JAL) begin
						alu_src_a = last_PC;
						alu_src_b = 32'd4;
					end
				end
				`OP_CODE_TYPE_BRANCH: begin
						alu_src_a = reg_A;
						alu_src_b = reg_B;
						if (IR[31:26] ==`MIPS_OP_BEQ) begin
							if (alu_result == 32'd0) begin
								branching = 1;
							end
						end
						else if (IR[31:26] ==`MIPS_OP_BNE) begin
							if (alu_result != 32'd0) begin
								branching = 1;
							end
						end
				end
				
			endcase
			
			
		end
		`S_MEMORY : begin
		
			reg_wr_data = alu_last_result;
			case (IR[31:26])
				`MIPS_OP_LW: next_state = `S_WRITEBACK;
				default: next_state = `S_FETCH1;
			endcase

			case (IR[31:26])
				`MIPS_OP_SW: begin
					mem_wr_addr = alu_result;
					mem_wr_data = reg_B;
					mem_wr_ena =1;
				end
				`MIPS_OP_LW: begin
					reg_wr_ena = 0;
				end
				
				default: begin
					reg_wr_ena = 1;
				end
			endcase
				
			
		end
		
		`S_WRITEBACK: begin
			next_state = `S_FETCH1;
			reg_wr_data = DR;
			reg_wr_ena = 1;
		end
		
		/* implement other comb. logic to determine the next state (or other comb. values) here! */  
		default: begin
			next_state = `S_FAILURE; //this helps us catch issues with our state machine
		end
	endcase
end

	assign rs = IR[25:21];
	assign rt = IR[20:16];
	assign rd = IR[15:11];
	assign shamt = IR[10:6];
	//assign jaddr = (PC[31:28] || (IR[25:0] << 2));
	
	assign newtest =(IR[25:0] << 2);
	assign jaddr = (next_PC[31:28] | newtest);
	

always @(*) begin
	//REGISTER DECODER
	
	
	reg_rd_addr0 = IR[25:21]; //rs
	reg_rd_addr1 = IR[20:16]; //rt
	if (state==`S_WRITEBACK) begin
		reg_wr_addr = IR[20:16]; //rt
	end
	else begin
		case (op_code_type)
			`OP_CODE_TYPE_R: begin
					reg_wr_addr = IR[15:11]; //rd
			end
			`OP_CODE_TYPE_I: begin
				reg_wr_addr = IR[20:16]; //rt
			end
			`OP_CODE_TYPE_J: begin
				reg_wr_addr = 32'd31; //ra
			end
			
			
		endcase
		
	end
	
	
	immi = IR[15:0]; //immi
	if (immi[15]==0) begin
		sign_extended_immi = 32'h00000000 | immi;
	end
	else begin
		sign_extended_immi = 32'hffff0000 | immi;
	end
	
	
	
	
	//OP CODE TYPE CONTROL
	case (IR[31:26])
		`MIPS_OP_RTYPE: op_code_type = `OP_CODE_TYPE_R;
		`MIPS_OP_ANDI: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_ORI: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_XORI: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_SLTI: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_ADDI: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_LW: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_SW: op_code_type = `OP_CODE_TYPE_I;
		`MIPS_OP_J: op_code_type = `OP_CODE_TYPE_J;
		`MIPS_OP_JAL: op_code_type = `OP_CODE_TYPE_J;
		`MIPS_OP_BEQ: op_code_type = `OP_CODE_TYPE_BRANCH;
		`MIPS_OP_BNE: op_code_type = `OP_CODE_TYPE_BRANCH;
	endcase
	
	//MEM CONTROL
	if (mem_wr_ena==0) begin
		mem_addr = mem_rd_addr;
	end
	else begin
		mem_addr = mem_wr_addr;
	end
end




always @(posedge clk) begin
	if(rst) begin
		state <= `S_FETCH1;
		next_PC <= 32'h00400000;
		/* be sure to reset all registers to sane values here! */
	end
	else begin
		state <= next_state;
		case (state) 
			`S_FETCH1: begin
				/*control other registers here! */
				
				last_PC <= next_PC;
				
				
				
			end
			`S_FETCH2: begin
				/*control other registers here! */
				IR <= mem_rd_data;
				
				
				next_PC <= alu_result;
			
				
			end
			`S_DECODE: begin
				/*control other registers here! */
				if (op_code_type == `OP_CODE_TYPE_J) begin
					next_PC <= jaddr;
				end
				else if ((op_code_type == `OP_CODE_TYPE_R)&(IR[5:0]==`MIPS_FUNCT_JR))begin
					next_PC <= reg_rd_data0;
				end
				else if (op_code_type == `OP_CODE_TYPE_BRANCH) begin
					alu_last_result <= alu_result;
				end
				reg_A <= reg_rd_data0;
				reg_B <= reg_rd_data1;
				
				
				
						
			end
			`S_EXECUTE: begin
				/*control other registers here! */
				alu_last_result <= alu_result;
				
				if (branching) begin
					next_PC <= alu_last_result;
				end
				
				
			end
			`S_MEMORY: begin
				/*control other registers here! */
				DR <= mem_rd_data;
				
			end
			
			`S_WRITEBACK: begin
				
				
			
			end
			
			default: begin
				/*always have a default case */
				//next_state = `S_FAILURE;
			end
		endcase
	end
end


endmodule

`default_nettype wire
