`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:

////////////////////////////////////////////////////////////////////////////////

module add_rca_32_bit_test;

	// Inputs
	reg [31:0] X;
	reg [31:0] Y;
	reg ci;

	// Outputs
	wire co;
	wire [31:0] sum;

	// Instantiate the Unit Under Test (UUT)
	add_rca_32_bit uut (
		.X(X), 
		.Y(Y), 
		.ci(ci), 
		.sum(sum), 
		.co(co)
	);

	integer i,j,k,r;
	integer error = 0;
	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		ci = 0;
		for (k=0;k<2;k=k+1) begin
			ci = k;
			for (i=0;i<16;i=i+1) begin
				r = $random;
				X = r;
				for (j=0;j<16;j=j+1) begin
					r = $random;
					Y = r;
					#10;
				end
			end
		end
		
		if (error > 0) begin
			$display("TEST FAILURE!!!  TEST FAILED with %d ERRORS", error);
		end
		else begin
			$display("!!! TEST SUCCESS !!!");
		end
		
		$finish;
	end;
	
	always @(X,Y,ci) begin
		#1;
		if (X+Y+ci !== sum+(co<<32)) begin
			$display("ERROR: X = %b, Y = %b, ci = %b, sum = %b, co = %b", X, Y, ci, sum, co);
			error = error + 1;
		end
	end
      
endmodule

