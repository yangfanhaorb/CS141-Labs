`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    register 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module register(clk,d,q, rst, ena);

	//parameter definitions
	parameter N = 8;

	//port definitions - customize for different bit widths
	input  wire clk, rst, ena;
	input  wire [N-1:0] d;
	output reg  [N-1:0] q; //reg type means that you can put in an always block
	
	always @(posedge clk) begin
		if(rst) begin
			q <= 0;
		end
		else begin
			if(ena) begin
				q <= d;  //non-blocking-assignment operator - in english the "becomes" operator
				// q "becomes" d @ the posedge of the clock
			end
		end		
	end

endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
