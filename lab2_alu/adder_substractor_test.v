`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// 
////////////////////////////////////////////////////////////////////////////////

module adder_substractor_test;

	// Inputs
	reg [31:0] X;
	reg [31:0] Y;
	reg add_or_substract;

	// Outputs
	wire [31:0] out;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	adder_substractor uut (
		.X(X), 
		.Y(Y), 
		.add_or_substract(add_or_substract), 
		.out(out), 
		.overflow(overflow)
	);


	integer i,j,k,r;
	integer error = 0;
	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		add_or_substract = 0;
		for (k=0;k<2;k=k+1) begin
			add_or_substract = k;
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

	end
	
	always @(X,Y,add_or_substract) begin
		#5;
		if (add_or_substract === 0) begin
			if (X-Y !== out) begin
				$display("ERROR: X = %b, Y = %b, add_or_substract = %b, out = %b, overflow = %b", X, Y, add_or_substract, out, overflow);
				error = error + 1;
			end
		end
		if (add_or_substract === 1) begin
			if (X+Y !== out) begin
				$display("ERROR: X = %b, Y = %b, add_or_substract = %b, out = %b, overflow = %b", X, Y, add_or_substract, out, overflow);
				error = error + 1;
			end
		end
	end
      
endmodule

