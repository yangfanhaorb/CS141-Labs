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
	
	wire [31:0] and_out, or_out, xor_out, nor_out, add_out, sub_out, slt_out, srl_out, sll_out, sra_out;
	
	//functional blocks
	
	//AND
	assign and_out = X & Y;

	//OR
	assign or_out = X | Y;
	
	//XOR
	assign xor_out = X ^ Y;
	
	//NOR
	assign nor_out = ~(X | Y);

	//ADD
	add_rca_32 OUTPUT_ADD (
		.X(X),
		.Y(Y),
		.sum(add_out),
		.overflow(add_overflow)
	);

	//SUB
	sub_func OUTPUT_SUB (
		.X(X),
		.Y(Y),
		.difference(sub_out)
	);
	
	//SRL
	
	SRL Shift_Right_Logical (.X(X) , .Y(Y) , .Z(srl_out));
	
	// xor32 implementation
	assign xor_out = X ^ Y;
	
	//output mux
	mux_16_1 #(.N(32)) OUTPUT_MUX (
    .in0(and_out), 
    .in1(or_out), 
    .in2(xor_out), 
    .in3(nor_out), 
    .in4(0), 
    .in5(0), 
    .in6(0), 
    .in7(0), 
    .in8(0), 
    .in9(0), 
    .in10(0), 
    .in11(0), 
    .in12(0), 
    .in13(0), 
    .in14(0), 
    .in15(0), 
    .S(op_code), 
    .Z(Z)
    );
	 
	 



endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
