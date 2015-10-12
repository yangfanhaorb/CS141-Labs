`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:08:53 10/01/2015
// Design Name:   register
// Module Name:   /home/avinash/Dropbox/cs141-f15/prelab3_project/test_register.v
// Project Name:  prelab3_project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_register;

	// Inputs
	reg clk;
	reg [7:0] d;
	reg rst;
	reg ena;

	// Outputs
	wire [7:0] q;

	// Instantiate the Unit Under Test (UUT)
	register uut (
		.clk(clk), 
		.d(d), 
		.q(q), 
		.rst(rst), 
		.ena(ena)
	);
	
	//run the clock
	always #5 clk = ~clk;
	
	integer i = 0;
	initial begin
		// Initialize Inputs
		clk = 0;
		d = 0;
		rst = 1;
		ena = 0;
		
		@(posedge clk) rst = 0;
		
		ena = 1;
		
		for(i = 0; i < 17; i = i + 1) begin
			@(negedge clk) d = i;
		end
		ena = 0;
		for(i = 18; i < 28; i = i + 1) begin
			@(negedge clk) d = i;
		end
		ena = 1;
		for(i = 29; i < 64; i = i + 1) begin
			@(negedge clk) d = i;
		end
		
		repeat (2) @(posedge clk);
		$finish;
	end
      
endmodule

