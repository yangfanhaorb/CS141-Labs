`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// solutions for the pwm module: testbench
////////////////////////////////////////////////////////////////////////////////

module test_pwm;
	parameter DIV_COUNT = 2;
	parameter N = 8;

	// Inputs
	reg clk;
	reg rst;
	reg [N-1:0] din;

	// Outputs
	wire dout;

	// Instantiate the Unit Under Test (UUT)
	
	pwm #(.divider_count(DIV_COUNT), .N(N)) uut (
		.clk(clk), 
		.rst(rst), 
		.din(din), 
		.dout(dout)
	);
	
	always #5 clk = ~clk;
	
	integer i = 0;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		din = 0;

		repeat (2) @(posedge clk);
		rst = 0;
		
		for (i = 0; i < 256; i = i + 1) begin
			din = i;
			repeat (DIV_COUNT*(1 << N) + 1) @(posedge clk);
		end

		$finish;
	end
	
      
endmodule

