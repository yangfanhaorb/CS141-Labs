`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:49:45 10/01/2015
// Design Name:   flip_flop
// Module Name:   /home/avinash/Dropbox/cs141-f15/prelab3_project/test_flip_flop.v
// Project Name:  prelab3_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: flip_flop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_flip_flop;

	// Inputs
	reg clk,rst, ena;
	reg d;

	// Outputs
	wire q;

	// Instantiate the Unit Under Test (UUT)
	flip_flop uut (
		.clk(clk), .rst(rst), .ena(ena),
		.d(d), 
		.q(q)
	);
	
	//create a clock
	always #5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		d = 0;
		rst = 1;
		ena = 0;
		
		repeat (2) @(posedge clk);
		
		rst = 0;
		ena = 1;
		repeat (2) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (3) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		ena = 0;
		repeat (2) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (3) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		ena  = 1;
		repeat (2) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (3) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;
		repeat (1) @(negedge clk) d = ~d;

		repeat (4) @(posedge clk);
		
		$finish;

	end
      
endmodule

