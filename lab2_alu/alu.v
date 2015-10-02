`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    alu 
// Author(s): [[your name here]]
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
`include "alu_defines.v"

module alu(X,Y,Z,op_code, equal, overflow, zero);

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] Z;
	input  wire [3:0] op_code;
	
	output wire equal, overflow, zero;
	wire overflow_placeholder;
	
	wire [31:0] and_out, or_out, xor_out, nor_out, add_or_sub_out, sub_out, slt_out, srl_out, sll_out, sra_out;

	
	//functional blocks
	
	//AND
	assign and_out = X & Y;

	//OR
	assign or_out = X | Y;
	
	//XOR
	assign xor_out = X ^ Y;
	
	//NOR
	assign nor_out = ~(X | Y);

	//ADD OR SUB
	adder_substractor OUTPUT_ADD (
		.X(X),
		.Y(Y),
		.add_or_substract(op_code[0]),
		.out(add_or_sub_out),
		.overflow(overflow)
	);

	//SUB JUST FOR SLT
	adder_substractor OUTPUT_SUB (
		.X(X),
		.Y(Y),
		.add_or_substract(0),
		.out(sub_out),
		.overflow(overflow_placeholder)
	);
	
	
	//SLT
	comparator OUTPUT_SLT (
		.diff(sub_out),
		.slt(slt_out),
		.equal(equal)
	);
	
	//SRL
	
	SRL Shift_Right_Logical (.X(X) , .Y(Y) , .Z(srl_out));
	
	//SLL
	
	SLL Shift_Left_Logical (.X(X) , .Y(Y) , .Z(sll_out));
	
	//SRA
	
	SRA Shift_Right_ARM (.X(X) , .Y(Y) , .Z(sra_out));
	
	// xor32 implementation
	assign xor_out = X ^ Y;
	
	//output mux
	pmux_16_to_1 #(.width(32)) OUTPUT_MUX (
    .in1(and_out), 
    .in2(or_out), 
    .in3(xor_out), 
    .in4(nor_out), 
    .in5(0), 
    .in6(add_or_sub_out), 
    .in7(add_or_sub_out), 
    .in8(slt_out), 
    .in9(srl_out), 
    .in10(sll_out), 
    .in11(sra_out), 
    .in12(0), 
    .in13(0), 
    .in14(0), 
    .in15(0), 
    .in16(0), 
    .S(op_code), 
    .Z(Z)
    );
	 
	 



endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
