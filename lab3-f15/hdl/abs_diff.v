`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    abs_diff 
// Author(s): Avinash Uttamchandani
// Description: a module that computes the absolute value of the difference between two numbers
//
//
//////////////////////////////////////////////////////////////////////////////////
module abs_diff(x,y,z);

	//parameter definitions
	parameter N = 8;

	//port definitions - customize for different bit widths
	input  wire [N-1:0] x;
	input  wire [N-1:0] y;
	output wire [N-1:0] z;
	
	wire [N:0] diff; //added one more bit to ensure overflows didn't mess things up
	assign diff = x - y;
	//mux between diff and it's two's complement to ensure that the value returned is always positive
	assign z = diff[N] ? 
		~diff + 1 //diff was negative
		:
		diff; //diff was positive

endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
