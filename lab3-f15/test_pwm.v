`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:44:06 10/08/2015
// Design Name:   pwm
// Module Name:   C:/Users/cs141/Documents/GitHub/CS141-Labs/lab3-f15/test_pwm.v
//
////////////////////////////////////////////////////////////////////////////////

module test_pwm;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] din;

	// Outputs
	wire dout;

	always #5 clk = ~clk;

	// Instantiate the Unit Under Test (UUT)
	pwm uut (
		.clk(clk), 
		.rst(rst), 
		.din(din), 
		.dout(dout)
	);

	initial begin
	
		// Initialize Inputs
		clk = 0;
		rst = 1;
		din = 30;

		// Wait 100 ns for global reset to finish
		//#100;
        
		// Add stimulus here
		repeat (5) @(posedge clk);
		rst = 0;
		repeat (124) @(posedge clk);
		rst = 1;
		din = 100;
		repeat (4) @(posedge clk);
		rst = 0;
		repeat (1024) @(posedge clk);
		rst =1;
		din = 200;
		repeat (3) @(posedge clk);
		rst = 0;
		repeat (1024) @(posedge clk);
		rst =1;
		din = 35;
		repeat (3) @(posedge clk);
		rst = 0;
		repeat (1024) @(posedge clk);
		rst =1;
		din = 0;
		repeat (3) @(posedge clk);
		rst = 0;
		repeat (1024) @(posedge clk);
		rst =1;
		din = 255;
		repeat (3) @(posedge clk);
		rst = 0;
		repeat (1024) @(posedge clk);
		rst =1;
		
		

		$finish;
	end
      
endmodule

