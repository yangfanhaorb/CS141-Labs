`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    add_func 
// Author(s): Fanhao Yang, Thomas Esch
//
//////////////////////////////////////////////////////////////////////////////////
module sub_func(X,Y,diff,overflow);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] dif;
	output wire overflow;
	
	wire if_do = 0; //this here means we will invert, because this follows op_code[0] for substraction, which is 0
	wire Y_prime;
	
	twos_complement inverter (
    .X(Y), 
	 .if_do(if_do),
    .Y(Y_prime)
    );
	
	add_rca_32_bit adder (
    .X(X), 
    .Y(Y_prime), 
    .ci(ci), 
    .sum(sum), 
    .co(overflow)
    );

	
	


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire