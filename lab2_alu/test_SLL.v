`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:27:51 10/01/2015
// Design Name:   SLL
// Module Name:   C:/Users/cs141/Documents/GitHub/CS141-Labs/lab2_alu/test_SLL.v
// Project Name:  lab2_alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SLL
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_SLL;
// Inputs
	reg [31:0] X;
	reg [31:0] Y;

	// Outputs
	wire [31:0] Z;

	// Instantiate the Unit Under Test (UUT)
	SRL uut (
		.X(X), 
		.Y(Y), 
		.Z(Z)
	);
	
	integer i = 0;

	initial begin
		// Initialize Inputs
		X = 32'b11111111111111111111111111111111;
		Y = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		for (i= 0; i < 6; i = i+1) begin
			#10;
			Y = 0;
			Y[i] = 1;
			
		end
		#10;
		Y=0;
		Y='d6;
		#10;
		
	end
      
endmodule
