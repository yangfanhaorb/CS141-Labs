`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
///////////////////////////////////////////////////////////

module twos_complement_test;

	// Inputs
	reg [31:0] X;
	reg if_do;

	// Outputs
	wire [31:0] Y;

	// Instantiate the Unit Under Test (UUT)
	twos_complement uut (
		.X(X), 
		.if_do(if_do),
		.Y(Y)
	);

	initial begin
		// Initialize Inputs
		if_do = 0;
		X = 0;
		#10;
		X = 10;
		#10;
		X=100;
		#10;
		X=1000;
		#10;
		if_do = 1;
		X = 0;
		#10;
		X = 10;
		#10;
		X=100;
		#10;
		X=X+X;
		#10;
		X = X+X;
		#10;
		$finish;

	end
      
endmodule

