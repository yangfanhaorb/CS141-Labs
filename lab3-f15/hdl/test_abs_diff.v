`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:59:01 10/01/2015
// Design Name:   abs_diff
// Module Name:   /home/avinash/src/cs141/labs/lab3/lab3-f15/hdl/test_abs_diff.v
// Project Name:  lab3-f15
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: abs_diff
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_abs_diff;

	// Inputs
	reg [7:0] x;
	reg [7:0] y;

	// Outputs
	wire [7:0] z;

	// Instantiate the Unit Under Test (UUT)
	abs_diff #(.N(8)) uut (
		.x(x), 
		.y(y), 
		.z(z)
	);

	initial begin
		x = 0; y = 0; #10; $display("x = %d, y = %d, z = |x-y| = %d", x, y, z);
		x = 7; y = 2; #10; $display("x = %d, y = %d, z = |x-y| = %d", x, y, z);
		x = 2; y = 7; #10; $display("x = %d, y = %d, z = |x-y| = %d", x, y, z);
		$finish;
	end
      
endmodule

