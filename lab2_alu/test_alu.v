`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:   CS141
// Engineer:  Avinash Uttamchandani
//
////////////////////////////////////////////////////////////////////////////////

`include "alu_defines.v"

module test_alu;

	// Inputs
	reg [31:0] X;
	reg [31:0] Y;
	reg [3:0] op_code;

	// Outputs
	wire [31:0] Z;
	wire equal;
	wire overflow;
	wire zero;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.X(X), 
		.Y(Y), 
		.Z(Z), 
		.op_code(op_code), 
		.equal(equal), 
		.overflow(overflow), 
		.zero(zero)
	);

	integer i, j, k;
	integer error = 0;
	
	//test vector ROM (read only memory)
	reg [31:0] TEST_VECTOR [0:1023];
	integer TEST_VECTOR_LENGTH = 6;
	
	initial begin
		// Initialize Inputs
		X = 0;
		Y = 0;
		op_code = 0;
		
		//initialize my test vector
		$readmemh("test_vector.mem", TEST_VECTOR,  0, TEST_VECTOR_LENGTH);
		
		for( k = 0; k < 16; k = k + 1) begin
			op_code = k;
			
			//test vector
			for(i = 0; i < TEST_VECTOR_LENGTH; i = i + 1) begin
				for(j = 0; j < TEST_VECTOR_LENGTH; j = j + 1) begin
					#10;
					X = TEST_VECTOR[i];
					Y = TEST_VECTOR[j];
				end
			end
		end
		#10;
		
		if (error > 0) begin
			$display("TEST FAILURE!!!  TEST FAILED with %d ERRORS", error);
		end
		else begin
			$display("!!! TEST SUCCESS !!!");
		end
		$finish;
	
	end
	
	//a checker
	always @(X,Y,op_code) begin
		#1;
		case (op_code)
			`ALU_OP_AND : begin
				//only executes when the op code is 0000 (AND)
				if( Z !== (X & Y) ) begin
					$display("ERROR: AND:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			end
			`ALU_OP_XOR : begin
				//only execute if the op code is xor
				if (Z !== (X ^ Y) ) begin
					$display("ERROR: XOR:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			end
			// ADD IN YOUR OWN OP CODE CHECKERS HERE!!!
			
			`ALU_OP_OR : begin
				if (Z !== (X | Y) ) begin
					$display("ERROR: OR:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
				
			end
			`ALU_OP_NOR: begin
				if (Z !== ~(X | Y) ) begin
					$display("ERROR: NOR:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
				
			end
			`ALU_OP_ADD: begin
				if (Z !== (X + Y) ) begin
					$display("ERROR: ADD:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			`ALU_OP_SUB: begin
				if (Z !== (X - Y) ) begin
					$display("ERROR: SUB:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			`ALU_OP_SLT: begin
				if ((X < Y) && (Z !==32'd1) ) begin
					$display("ERROR: SLT:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
				if ((X > Y) && (Z !==32'd0) ) begin
					$display("ERROR: SLT:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			`ALU_OP_SRL: begin
				if (Z !== (X >> Y) ) begin
					$display("ERROR: SRL:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			`ALU_OP_SLL: begin
				if (Z !== (X << Y) ) begin
					$display("ERROR: SLL:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			`ALU_OP_SRA: begin
				if (Z !== (X >>> Y) ) begin
					$display("ERROR: SLL:  op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			
			end
			default : begin
				//executes at default
				if (Z !== 32'd0) begin
					$display("ERROR HAPPENED! invalid op code, Z was not zero, op_code = %b, X = %h, Y = %h, Z = %h", op_code, X, Y, Z);
					error = error + 1;
				end
			end
		endcase
		
	end
	
endmodule

