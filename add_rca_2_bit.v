`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  add_rca_2_bit
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module add_rca_2_bit(X,Y,ci,sum,co);
	input wire [1:0] X, Y;
	input wire ci;
	output wire [1:0] sum;
	output wire co;
	wire co_int_1;

	full_adder adder_1 (
		.X  (X[0]),
		.Y  (Y[0]),
		.ci (ci),
		.sum(sum[0]),
		.co (co_int_1)
	);

	full_adder adder_2 (
		.X  (X[1]),
		.Y  (Y[1]),
		.ci (co_int_1),
		.sum(sum[1]),
		.co (co)
	);
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire