`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    counter 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module counter(clk,rst,ena,count);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire clk, rst, ena;
	output reg [7:0] count;
	
	always @(posedge clk) begin
		if(rst) begin
			count <= 0;
		end
		else begin
			if(ena) begin
				count <= count + 8'd1;
			end
		end
	end


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
