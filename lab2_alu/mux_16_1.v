`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    mux_16to1 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module mux_16to1(A,B,C,D,E,F,G,H,I,J,K,L,M,O,P,Q,S,Z);

	//parameter definitions
	parameter N = 16;

	//port definitions - customize for different bit widths
	input  wire [N-1:0] A;
	input  wire [N-1:0] B;
	input  wire [N-1:0] C;
	input  wire [N-1:0] D;
	input  wire [N-1:0] E;
	input  wire [N-1:0] F;
	input  wire [N-1:0] G;
	input  wire [N-1:0] H;
	input  wire [N-1:0] I;
	input  wire [N-1:0] J;
	input  wire [N-1:0] K;
	input  wire [N-1:0] L;
	input  wire [N-1:0] M;
	input  wire [N-1:0] O;
	input  wire [N-1:0] P;
	input  wire [N-1:0] Q;
	input  wire[3:0] S;
	output wire [N-1:0] Z;
	
	wire [N-1:0] mux_0_out;
	wire [N-1:0] mux_1_out;
	wire [N-1:0] mux_2_out;
	wire [N-1:0] mux_3_out;
	
	mux_4to1 #(.N(N)) mux_0 (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.S(S[1:0]), 
		.Z(mux_0_out)
	);
	
	mux_4to1 #(.N(N)) mux_1 (
		.A(E), 
		.B(F), 
		.C(G), 
		.D(H), 
		.S(S[1:0]), 
		.Z(mux_1_out)
	);
	
	mux_4to1 #(.N(N)) mux_2 (
		.A(I), 
		.B(J), 
		.C(K), 
		.D(L), 
		.S(S[1:0]), 
		.Z(mux_2_out)
	);
	
	mux_4to1 #(.N(N)) mux_3 (
		.A(M), 
		.B(O), 
		.C(P), 
		.D(Q), 
		.S(S[1:0]), 
		.Z(mux_3_out)
	);
	
	mux_4to1 #(.N(N)) mux_4 (
		.A(mux_0_out), 
		.B(mux_1_out), 
		.C(mux_2_out), 
		.D(mux_3_out), 
		.S(S[3:2]), 
		.Z(Z)
	);


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
