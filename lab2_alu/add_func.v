`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    add_func 
// Author(s): Fanhao Yang, Thomas Esch
//
//////////////////////////////////////////////////////////////////////////////////
module add_func(X,Y,sum,overflow);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] sum;
	output wire overflow;
	
	wire ci = 0;
	
	add_rca_32_bit adder (
    .X(X), 
    .Y(Y), 
    .ci(ci), 
    .sum(sum), 
    .co(overflow)
    );

	
	


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
