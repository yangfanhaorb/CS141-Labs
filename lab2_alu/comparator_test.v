`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module comparator_test;

	// Inputs
	reg [31:0] diff;

	// Outputs
	wire [31:0] slt;
	wire equal;

	// Instantiate the Unit Under Test (UUT)
	comparator uut (
		.diff(diff), 
		.slt(slt), 
		.equal(equal)
	);

	initial begin
		// Initialize Inputs
		diff = 0;
		#10;
		diff = -100;
		#10;
		diff = 100;
		#10;
		$finish;
        
		// Add stimulus here

	end
      
endmodule

