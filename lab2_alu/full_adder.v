`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:  full_adder
// Author(s): Fanhao Yang, Thomas Esch
//////////////////////////////////////////////////////////////////////////////////

module full_adder(X,Y,ci,sum,co);
	input wire X, Y, ci;
	output wire sum, co;
	wire sum_1, co_1, co_2;

	half_adder adder1(.X(X), .Y(Y), .sum(sum_1), .co (co_1));
	half_adder adder2(.X(ci), .Y(sum_1), .sum(sum), .co (co_2));
	assign co = co_1 | co_2;
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire