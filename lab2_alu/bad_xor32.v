`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    bad_xor32 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module bad_xor32(X,Y,Z);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] Z;
	
	assign Z = X & ~Y; //this is not an xor!!!


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
