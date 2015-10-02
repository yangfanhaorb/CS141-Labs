`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    twos_complement 
// Author(s): Fanhao Yang, Thomas Esch
//
//////////////////////////////////////////////////////////////////////////////////
module twos_complement(X,if_do,Y);

	//parameter definitions
	parameter N = 32;
	

	//port definitions - customize for different bit widths
	input  wire [N-1:0] X;
	input wire if_do;
	output wire [N-1:0] Y;
	
	assign Y = if_do? X : ~X;


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
