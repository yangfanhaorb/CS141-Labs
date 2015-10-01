`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    mux_4to1 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module mux_4to1(A,B,C,D,S,Z);

	//parameter definitions
	parameter N = 16;

	//port definitions - customize for different bit widths
	input  wire [N-1:0] A;
	input  wire [N-1:0] B;
	input  wire [N-1:0] C;
	input  wire [N-1:0] D;
	input  wire [1:0] S;
	output wire [N-1:0] Z;
	
	wire [N-1:0] mux_0_out;
	wire [N-1:0] mux_1_out;
	
	
	mux_2to1 #(.N(N)) mux_0 (
		.X(A), 
		.Y(B), 
		.S(S[0]), 
		.Z(mux_0_out)
	);
	
	mux_2to1 #(.N(N)) mux_1 (
		.X(C), 
		.Y(D), 
		.S(S[0]), 
		.Z(mux_1_out)
	);
	
	mux_2to1 #(.N(N)) mux_2 (
		.X(mux_0_out), 
		.Y(mux_1_out), 
		.S(S[1]), 
		.Z(Z)
	);


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
