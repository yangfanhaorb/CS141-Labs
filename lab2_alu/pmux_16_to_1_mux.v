`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    pmux_16_to_1 
// Author(s): Thomas Esch
// Description: variable width input 16:1 mux, uses param_2_to_1_mux, param_4_to_1_mux
//
//
//////////////////////////////////////////////////////////////////////////////////
module pmux_16_to_1(in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,S,Z);

	//parameter definitions
	parameter width = 8; //default is 8 bit width
	
	//port definitions - customize for different bit widths
	input wire [(width-1) : 0 ] in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16;	// creates bus of appropriate width for inputs
	input wire [3:0] S; 					// select input
	output wire [(width-1) : 0 ] Z;	// creates bus of appropriate width for output
	
	
	//intermediate wire definitions
	wire [(width-1) : 0 ] mux_0_out;
	wire [(width-1) : 0 ] mux_1_out;
	wire [(width-1) : 0 ] mux_2_out;
	wire [(width-1) : 0 ] mux_3_out;
	wire [(width-1) : 0 ] mux_4_out;


	
	param_4_to_1_mux #(.width(width)) MUX_0 (.A(in1) , .B(in2) , .C(in3), .D(in4), .S(S[1:0]) , .Z(mux_0_out));
	param_4_to_1_mux #(.width(width)) MUX_1 (.A(in5) , .B(in6) , .C(in7), .D(in8), .S(S[1:0]) , .Z(mux_1_out));
	param_4_to_1_mux #(.width(width)) MUX_2 (.A(in9) , .B(in10) , .C(in11), .D(in12), .S(S[1:0]) , .Z(mux_2_out));
	param_4_to_1_mux #(.width(width)) MUX_3 (.A(in13) , .B(in14) , .C(in15), .D(in16), .S(S[1:0]) , .Z(mux_3_out));
	
	param_4_to_1_mux #(.width(width)) MUX_4 (.A(mux_0_out) , .B(mux_1_out) , .C(mux_2_out), .D(mux_3_out), .S(S[3:2]) , .Z(Z));
	


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
