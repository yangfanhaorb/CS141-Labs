`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module add_rca_2_bit_test;

	// Inputs
	reg [1:0] X;
	reg [1:0] Y;
	reg ci;
	reg [2:0] Z;

	// Outputs
	wire [1:0] sum;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	add_rca_2_bit uut (
		.X(X), 
		.Y(Y),
		.ci(ci),
		.sum(sum), 
		.co(co)
	);

	integer i,j,k;
	integer error = 0;
	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		ci = 0;
		for (k=0;k<2;k=k+1) begin
			for (i=0;i<4;i=i+1) begin
				for (j=0;j<4;j=j+1) begin
					X = i;
					Y = j;
					ci = k;
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
      
	end
	
	always @(X,Y,ci) begin
		#1;
		if (X+Y+ci !== sum+co*4) begin
			$display("ERROR: X = %b, Y = %b, ci = %b, sum = %b, co = %b", X, Y, ci, sum, co);
			error = error + 1;
		end
	end
      
endmodule

