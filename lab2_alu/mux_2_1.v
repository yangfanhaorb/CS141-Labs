`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    mux_2to1 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module mux_2to1(X,Y,S,Z);

	//parameter definitions
	parameter N = 16;

	//port definitions - customize for different bit widths
	input  wire[(N-1):0] X;
	input  wire[(N-1):0] Y;
	input  wire S;
	output wire[(N-1):0] Z;
	
	assign Z = S ? Y : X;


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
