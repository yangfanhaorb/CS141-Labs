`timescale 1ns/1ps
`default_nettype none
`define NUM_TEST_VALUES 25
`define MAX_OP_CODE 4'd10
`define OP_AND 4'b0000
`define OP_OR  4'b0001
`define OP_XOR 4'b0010
`define OP_NOR 4'b0011
`define OP_ADD 4'b0101
`define OP_SUB 4'b0110
`define OP_SLT 4'b0111
`define OP_SRL 4'b1000
`define OP_SLL 4'b1001
`define OP_SRA 4'b1010

module test_alu2;

	reg [31:0] X,Y;
	wire signed [31:0] X_signed, Y_signed, Z_signed;
	wire [31:0] neg_X, neg_Y;

	assign neg_X = ~X + 1;
	assign neg_Y = ~Y + 1;
	assign X_signed = X;
	assign Y_signed = Y;
	assign Z_signed = Z;

	reg [3:0] op_code;
	reg cclk;
	wire overflow, zero, equal;
	wire [31:0] Z;

	alu UUT (.X(X), .Y(Y), .op_code(op_code), .Z(Z), .overflow(overflow), .zero(zero), .equal(equal));
	reg [31:0] test_values [0:(`NUM_TEST_VALUES-1)];

	integer ii, jj, errors, misc_errors;
	reg [31:0] op_code_errors [0:11];

	initial begin
		X = 0; Y = 0; op_code = 0; cclk = 0; ii =0; jj = 0; errors = 0; misc_errors = 0;
		$readmemh("alu_testcases.memh", test_values);
		for (op_code = 4'b0; op_code <= `MAX_OP_CODE; op_code = op_code + 1) begin
			op_code_errors[op_code] = errors;
			for (ii = 0; ii < `NUM_TEST_VALUES; ii = ii + 1) begin
				for (jj = 0; jj < `NUM_TEST_VALUES; jj = jj + 1) begin
					X <= test_values[ii][31:0];
					Y <= test_values[jj][31:0];
					#10;
				end
			end
			#10;
			op_code_errors[op_code] = errors - op_code_errors[op_code];
		end
		#10;
		if((errors > 0) || (misc_errors > 0)) begin
			$display("\nTest completed with %d errors.", errors);
		end
		else begin
			$display("\nTest completed with 0 errors!");
		end
		for (op_code = 4'b0; op_code <= `MAX_OP_CODE; op_code = op_code + 1) begin
			if(op_code_errors[op_code] !== 32'd0) begin
				$display("Found %d errors in op_code %d", op_code_errors[op_code], op_code);
			end
		end

		$finish;
	end

	//checker
	always @(X or Y or op_code) begin
		#1;  //this delay makes sure that all values are stable from last change
		//$display("@%8t: op_code = %d, X = %h, Y = %h, Z = %h, overflow = %b, zero = %b, equal = %b", $time, op_code, X, Y, Z, overflow, zero, equal);
		
		if(zero !== (Z === 32'd0)) begin
			$display("Error: ZERO  : X = %h, Y = %h, Z = %h, zero = %b, should be %b", X, Y, Z, zero, (Z === 32'd0));
			misc_errors = misc_errors + 1;
		end
		
		if(equal !== (X === Y)) begin
			$display("Error: EQUAL  : X = %h, Y = %h, Z = %h, equal = %b, should be %b", X, Y, Z, equal, (X === Y));
			misc_errors = misc_errors + 1;
		end
		
		if(~((op_code === `OP_ADD) | (op_code === `OP_SUB))) begin
			if(overflow !== 1'b0) begin
				$display("Error: OVERFLOW  : op_code = %2d,overflow = %b, not 0", op_code, overflow);
				misc_errors = misc_errors + 1;
			end
		end
		
		case(op_code)
			`OP_AND : begin //and
				if( Z !== (X & Y) ) begin
					$display("Error: AND  : X = %b, Y = %b, Z = %b, should be %b", X, Y, Z, X & Y);
					errors = errors + 1;
				end
			end
			
			`OP_OR : begin //or
				if (Z !== (X | Y) ) begin
					$display("Error: OR   : X = %b, Y = %b, Z = %b, should be %b", X, Y, Z, X | Y);
					errors = errors + 1;
				end
			end
			
			`OP_XOR : begin //xor
				if (Z !== (X ^ Y)) begin
					$display("Error: XOR  : X = %b, Y = %b, Z = %b, should be %b", X, Y, Z, X ^ Y);
					errors = errors + 1;
				end
			end
			
			`OP_NOR : begin //nor
				if (Z !==  ~(X | Y)) begin
					$display("Error: NOR  : X = %b, Y = %b, Z = %b, should be %b", X, Y, Z, ~(X | Y));
					errors = errors + 1;
				end
			end
			
			`OP_SLT : begin //slt
				case ({X[31], Y[31]}) //switch off the signs of X and Y
					2'b00 : begin //both positive
						if (Z !== ((X < Y) ? 32'd1 : 32'd0)) begin
							$display("Error: SLT  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, ((X < Y) ? 32'd1 : 32'd0));
							errors = errors + 1;
						end
					end
					2'b01 : begin //Y negative, X is necessarily NOT less than Y
						if (Z !== 32'd0) begin
							$display("Error: SLT  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, 32'd0);
							errors = errors + 1;
						end
					end
					2'b10 : begin //X negative, X is necessarily less than Y
						if (Z !== 32'd1) begin
							$display("Error: SLT  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, 32'd1);
							errors = errors + 1;
						end
					end
					2'b11 : begin //both negative, compare inverses...
						if (Z !== ((neg_X > neg_Y)? 32'd1 : 32'd0)) begin
							$display("Error: SLT  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, ((neg_X > neg_Y)? 32'd1 : 32'd0));
							errors = errors + 1;
						end
					end
					default : begin
						$display("Error: SLT (testbench) : X = %h, Y = %h, Z = %h", X, Y, Z);
						errors = errors + 1;
					end
				endcase
			end
			
			`OP_SLL : begin //sll
				if (Y <= 32'd32) begin
					if (Z !== (X << Y)) begin
						$display("Error: SLL  : X = %b, Y = %d, Z = %b, should be %b", X, Y, Z, X << Y);
						errors = errors + 1;
					end
				end
				else begin
					if (Z !== 32'd0) begin
						$display("Error: SLL  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, 32'd0);
						errors = errors + 1;
					end
				end
			end
			
			`OP_SRL : begin //srl
				if (Y <= 32'd32) begin
					if (Z !== (X >> Y)) begin
						$display("Error: SRL  : X = %b, Y = %d, Z = %b, should be %b", X, Y, Z, X >> Y);
						errors = errors + 1;
					end
				end
				else begin
					if (Z !== 32'd0) begin
						$display("Error: SRL  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, 32'd0);
						errors = errors + 1;
					end
				end
			end
			`OP_SRA : begin
				//behavioural sra needs "signed" variables
				if (Y < 32'd32) begin
					if (Z_signed !== (X_signed >>> Y)) begin
						$display("Error: SRA  : X = %b, Y = %d, Z = %b, should be %b", X, Y, Z, X_signed >>> Y);
						errors = errors + 1;
					end
				end
				else begin
					if (Z !== 32'd0) begin
						$display("Error: SRA  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, 32'd0);
						errors = errors + 1;
					end
				end
			end

			
			`OP_ADD : begin //add
				if(Z !==(X+Y)) begin
					$display("Error: ADD  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, X + Y);
					errors = errors + 1;
				end
				//check overflow
				case ({X[31], Y[31]}) //switch off the signs of X and Y
					2'b00 : begin //both positive
						if (overflow !== Z[31]) begin
							$display("Error: ADD OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, Z[31]);
							errors = errors + 1;
						end
					end
					2'b01 : begin //Y negative, no overflow possible
						if (overflow !== 1'b0) begin
							$display("Error: ADD OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, 1'b0);
							errors = errors + 1;
						end
					end
					2'b10 : begin //X negative, no overflow possible
						if (overflow !== 1'b0) begin
							$display("Error: ADD OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, 1'b0);
							errors = errors + 1;
						end
					end
					2'b11 : begin //both negative, compare inverses...
						if (overflow !== ~Z[31]) begin
							$display("Error: ADD OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, ~Z[31]);
							errors = errors + 1;
						end
					end
					default : begin
						$display("Error: ADD (testbench) : X = %h, Y = %h, Z = %h", X, Y, Z);
						errors = errors + 1;
					end
				endcase
			end
			
			`OP_SUB : begin //sub
				if(Z !==(X-Y)) begin
					$display("Error: SUB  : X = %h, Y = %h, Z = %h, should be %h", X, Y, Z, X - Y);
					errors = errors + 1;
				end
				//check overflow
				case ({X[31], Y[31]}) //switch off the signs of X and Y
					2'b00 : begin //both positive, no overflow possible
						if (overflow !== 1'b0) begin
							$display("Error: SUB OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, 1'b0);
							errors = errors + 1;
						end
					end
					2'b01 : begin //Y negative, X positive - overflows on sign flip
						if (overflow !== (Z[31])) begin
							$display("Error: SUB OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, ((X == 32'd0) & (Y === 32'h80000000)));
							errors = errors + 1;
						end
					end
					2'b10 : begin //X negative, Y positive, overflow occurs on negative overflow to positive numbers
						if (overflow !== (~Z[31])) begin
							$display("Error: SUB OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, ~Z[31]);
							errors = errors + 1;
						end
					end
					2'b11 : begin //both negative, cannot overflow
						if (overflow !== 1'b0) begin
							$display("Error: SUB OVERFLOW  : X = %h, Y = %h, Z = %h, overflow = %b, should be %b", X, Y, Z, overflow, 1'b0);
							errors = errors + 1;
						end
					end
					default : begin
						$display("Error: SUB (testbench) : X = %h, Y = %h, Z = %h", X, Y, Z);
						errors = errors + 1;
					end
				endcase
			end
			default: begin
				if(Z !==32'd0) begin
					$display("Error: reserved op_code %d  : Z = %h, not zero", op_code, Z);
					errors = errors + 1;
				end
			end
		endcase
	end

endmodule

`default_nettype wire
