`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
////////////////////////////////////////////////////////////////////////////////

module mux_16to1_test;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] C;
	reg [15:0] D;
	reg [15:0] E;
	reg [15:0] F;
	reg [15:0] G;
	reg [15:0] H;
	reg [15:0] I;
	reg [15:0] J;
	reg [15:0] K;
	reg [15:0] L;
	reg [15:0] M;
	reg [15:0] O;
	reg [15:0] P;
	reg [15:0] Q;
	reg [3:0] S;

	// Outputs
	wire [15:0] Z;

	// Instantiate the Unit Under Test (UUT)
	mux_16to1 uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.E(E), 
		.F(F), 
		.G(G), 
		.H(H), 
		.I(I), 
		.J(J), 
		.K(K), 
		.L(L), 
		.M(M), 
		.O(O), 
		.P(P), 
		.Q(Q), 
		.S(S), 
		.Z(Z)
	);

	integer i = 0;
	initial begin
		// Initialize Inputsn
		A = 16'b0000000000000000;
		B = 16'b0000000000001111;
		C = 16'b0000000011110000;
		D = 16'b0000000011111111;
		E = 16'b0000111100000000;
		F = 16'b0000111100001111;
		G = 16'b0000111111110000;
		H = 16'b0000111111111111;
		I = 16'b1111000000000000;
		J = 16'b1111000000001111;
		K = 16'b1111000011110000;
		L = 16'b1111000011111111;
		M = 16'b1111111100000000;
		O = 16'b1111111100001111;
		P = 16'b1111111111110000;
		Q = 16'b1111111111111111;

		for (i=0;i<16;i=i+1) begin
			S = i;
			#10; //test when S = 1...16
		end
		
		$finish;
		
	end
      
endmodule

