`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  half_adder
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module half_adder(X,Y,sum,co);
	input wire X, Y;
	output wire sum, co;

	assign sum = X ^ Y;
	assign co = X & Y;
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire