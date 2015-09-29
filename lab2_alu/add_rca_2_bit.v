`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  add_rca_2_bit
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module add_rca_2_bit(X,Y,sum,overflow);
	input wire [1:0] X, Y;
	output wire [1:0] sum;
	output wire overflow;
	wire co_1;

	full_adder adder_1 (
		.X  (X[0]),
		.Y  (Y[0]),
		.ci (0),
		.sum(sum[0]),
		.co (co_1)
	);

	full_adder adder_2 (
		.X  (X[1]),
		.Y  (Y[1]),
		.ci (co_1),
		.sum(sum[1]),
		.co (overflow),
	);
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire