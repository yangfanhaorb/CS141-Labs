`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:18:14 10/01/2015
// Design Name:   counter
// Module Name:   /home/avinash/Dropbox/cs141-f15/prelab3_project/test_counter.v
// Project Name:  prelab3_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_counter;

	// Inputs
	reg clk;
	reg rst;
	reg ena;

	// Outputs
	wire [7:0] count;
	
	always #5 clk = ~clk;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.clk(clk), 
		.rst(rst), 
		.ena(ena), 
		.count(count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		ena = 1;
		
		repeat (2) @(posedge clk);
		rst = 0;
		
		repeat (8) @(posedge clk);
		
		@(negedge clk) ena = 0;
		repeat (7) @(posedge clk); 
		
		@(negedge clk) ena = 1;
		
		repeat (300) @(posedge clk);

		$finish;
	end
      
endmodule

