`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module mux_4to1_test;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] C;
	reg [15:0] D;
	reg [1:0] S;

	// Outputs
	wire [15:0] Z;

	// Instantiate the Unit Under Test (UUT)
	mux_4to1 uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.S(S), 
		.Z(Z)
	);
	
	integer i = 0;
	initial begin
		// Initialize Inputs
		A = 16'b0000000000000000;
		B = 16'b0000000011111111;
		C = 16'b1111111100000000;
		D = 16'b1111111111111111;
		S = 0;

		// Wait 100 ns for global reset to finish
		#10; //test when S = 0 
		for (i=1;i<4;i=i+1) begin
			S = i;
			#10; //test when S = 1...4
		end
		
		$finish;

	end
      
endmodule

