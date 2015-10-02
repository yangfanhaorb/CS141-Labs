`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    param_2_to_1_mux 
// Author(s): Thomas Esch
// Description: 2:1 mux with variable input size
//
//
//////////////////////////////////////////////////////////////////////////////////
module param_2_to_1_mux(X,Y,S,Z);

	//parameter definitions
	parameter N = 8 ; //default of 8 bit bus
	
	

	//port definitions - customize for different bit widths
	input wire [(N-1) : 0 ] X, Y;	// creates bus of appropriate width for inputs
	
	input wire S;	// select input
	
	output wire [(N-1) : 0 ] Z;    // creates bus of appropriate width for inputs
	
	//Implementation
	assign Z = S ? Y : X;

endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
