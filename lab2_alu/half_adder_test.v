`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module half_adder_test;

	// Inputs
	reg X;
	reg Y;

	// Outputs
	wire sum;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	half_adder uut (
		.X(X), 
		.Y(Y), 
		.sum(sum), 
		.co(co)
	);

	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		#10;
		X = 0;
		Y = 1;
		#10;
		X = 1;
		Y = 0;
		#10;
		X = 1;
		Y = 1;
		#10;
		
		$finish;
		
        
		// Add stimulus here

	end
      
endmodule

