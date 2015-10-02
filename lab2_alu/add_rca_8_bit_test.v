`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module add_rca_8_bit_test;

	// Inputs
	reg [7:0] X;
	reg [7:0] Y;
	reg ci;

	// Outputs
	wire [7:0] sum;
	wire co;

	// Instantiate the Unit Under Test (UUT)
	add_rca_8_bit uut (
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
			for (i=0;i<256;i=i+1) begin
				for (j=0;j<256;j=j+1) begin
					r = $random % 256;
					if (r === 0) begin
						X = i;
						Y = j;
						ci = k;
						#10;
					end
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
		if (X+Y+ci !== sum+co*256) begin
			$display("ERROR: X = %b, Y = %b, ci = %b, sum = %b, co = %b", X, Y, ci, sum, co);
			error = error + 1;
		end
	end
      
endmodule

