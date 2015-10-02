`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module full_adder_test;

	// Inputs
	reg X;
	reg Y;
	reg ci;

	// Outputs
	wire sum;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.X(X), 
		.Y(Y), 
		.ci(ci), 
		.sum(sum), 
		.co(co)
	);
	
	integer i;
	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		ci = 0;
		
		for (i=0;i<8;i=i+1) begin
			X = i[2];
			Y = i[1];
			ci = i[0];
			#10;
		end
		$finish;

	end
      
endmodule

