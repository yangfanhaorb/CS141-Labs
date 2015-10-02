`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    comparator 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module comparator(diff,slt,equal);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] diff;
	output wire [31:0] slt;
	output wire equal;
	
	assign slt = diff[31];
	assign equal = ~(|diff);

endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
