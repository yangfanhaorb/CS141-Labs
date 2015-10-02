`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module mux_2to_1_test;

	// Inputs
	reg [15:0] X;
	reg [15:0] Y;
	reg S;

	// Outputs
	wire [15:0] Z;

	// Instantiate the Unit Under Test (UUT)
	mux_2to1 uut (
		.X(X), 
		.Y(Y), 
		.S(S), 
		.Z(Z)
	);

	initial begin
		// Initialize Inputs
		X = 16'b0000000000000000;
		Y = 16'b1111111100000000;
		S = 0;

		// Wait 100 ns for global reset to finish
		#10; // show the result for S = 0
		
		S = 1;
		#10; // show the result for S = 1
		
		$finish;

	end
      
endmodule

