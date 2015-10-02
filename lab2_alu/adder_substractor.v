`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    adder_substractor 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module adder_substractor(X,Y,add_or_substract,out,overflow);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	input  wire add_or_substract;
	output wire [31:0] out;
	output wire overflow;
	
	wire [31:0] Y_prime;
	wire ci,co;
	
	assign ci = ~add_or_substract;
	
	twos_complement inverter (
    .X(Y), 
	 .if_do(add_or_substract),
    .Y(Y_prime)
    );
	
	add_rca_32_bit adder (
    .X(X), 
    .Y(Y_prime), 
    .ci(ci), 
    .sum(out), 
    .co(co)
    );
	 
	 assign overflow = ~(X[31]^Y_prime[31])&(out[31]^X[31]);
	


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
