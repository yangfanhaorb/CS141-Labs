`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    param_8_to_1_mux 
// Author(s): Thomas Esch
// Description: 8:1 mux with variable input size, uses param_2_to_1_mux, param_4_to_1_mux
//
//
//////////////////////////////////////////////////////////////////////////////////
module param_4_to_1_mux(A,B,C,D,S,Z);

	//parameter definitions
	parameter width = 8; //default is 8 bit width
	
	//port definitions - customize for different bit widths
	input wire [(width-1) : 0 ] A,B,C,D;	// creates bus of appropriate width for inputs
	input wire [2:0] S; 					// select input
	output wire [(width-1) : 0 ] Z;	// creates bus of appropriate width for output
	
	
	//intermediate wire definitions
	wire [(width-1) : 0 ] mux_0_out;
	wire [(width-1) : 0 ] mux_1_out;
	wire mux_2_out; 
	
	param_4_to_1_mux #(.N(width)) MUX_0 (.X(A) , .Y(B) , .S(S[1:0]) , .Z(mux_0_out));
	param_4_to_1_mux #(.N(width)) MUX_1 (.X(C) , .Y(D) , .S(S[1:0]) , .Z(mux_1_out));
	param_2_to_1_mux #(.N(width)) MUX_2 (.X(mux_0_out) , .Y(mux_1_out) , .S(S[2]) , .Z(Z));
	
	//assign Z = mux_0_out;
	

endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
