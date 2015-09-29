`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  add_rca_8_bit
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module add_rca_8_bit(X,Y,sum,overflow);
	input wire [7:0] X, Y;
	output wire [7:0] sum;
	output wire overflow;
	wire co_1, co_2, co_3;

	add_rca_2_bit adder_1 (
		.X  (X[1:0]),
		.Y  (Y[1:0]),
		.ci (0),
		.sum(sum[1:0]),
		.co (co_1)
	);

	add_rca_2_bit adder_2 (
		.X  (X[3:2]),
		.Y  (Y[3:2]),
		.ci (co_1),
		.sum(sum[3:2]),
		.co (co_2)
	);

	add_rca_2_bit adder_3 (
		.X  (X[5:4]),
		.Y  (Y[5:4]),
		.ci (co_2),
		.sum(sum[5:4]),
		.co (co_3)
	);

	add_rca_2_bit adder_4 (
		.X  (X[7:6]),
		.Y  (Y[7:6]),
		.ci (co_3),
		.sum(sum[7:6]),
		.co (overflow)
	);
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire