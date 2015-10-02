`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    SRA 
// Author(s): 
// Description: 
//
//
//////////////////////////////////////////////////////////////////////////////////
module SRA(X,Y,Z);

	//parameter definitions

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] Z;

	// 16 bit shift
	wire [31:0] out_16pos;
	wire [31:0] out_16neg;
	wire [31:0] out_8pos;
	wire [31:0] out_8neg;
	wire [31:0] out_4pos;
	wire [31:0] out_4neg;
	wire [31:0] out_2pos;
	wire [31:0] out_2neg;
	wire [31:0] out_1pos;
	wire [31:0] out_1neg;
	
	//assign out_16 = Z[31:0];//[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,Z[31:16]];
	assign out_16pos = {16'b0000000000000000,X[31:16]};
	assign out_16neg = {16'b1111111111111111,X[31:16]};
	
	// intermediary wires
	wire [31:0] shift4out;
	wire [31:0] shift3out;
	wire [31:0] shift2out;
	wire [31:0] shift1out;
	wire [31:0] shift0out;

	//choose between 16 bit shift or skip, pos or neg
	param_4_to_1_mux #(.width(32)) MUX_0 (.A(X) , .B(X) , .C(out_16pos),.D(out_16neg),.S({Y[4],X[31]}) , .Z(shift4out));
	
	//8 bit shift
	//assign wire [31:0] out_8 = {0,0,0,0,0,0,0,0,shift4out[31:8]};
	assign out_8pos = {8'b00000000,shift4out[31:8]};
	assign out_8neg = {8'b11111111,shift4out[31:8]};
	
	//choose between 8 bit shift or skip, pos or neg
	param_4_to_1_mux #(.width(32)) MUX_1 (.A(shift4out) , .B(shift4out), .C(out_8pos), .D(out_8neg) , .S({Y[3],X[31]}) , .Z(shift3out));
	
	//4 bit shift
	//assign wire [31:0] 4out = [0,0,0,0,shift3out[31:4]];
	assign out_4pos = {4'b0000,shift3out[31:4]};
	assign out_4neg = {4'b1111,shift3out[31:4]};
	
	//choose between 4 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_2 (.A(shift3out) , .B(shift3out),.C(out_4pos) , .D(out_4neg),.S({Y[2],X[31]}) , .Z(shift2out));
	
	//2 bit shift
	//assign wire [31:0] 2out = [0,0,shift3out[31:2]];
	assign out_2pos = {2'b00,shift2out[31:2]};
	assign out_2neg = {2'b11,shift2out[31:2]};
	
	//choose between 2 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_3 (.A(shift2out) , .B(shift2out),.C(out_2pos), .D(out_2neg) , .S({Y[1],X[31]}) , .Z(shift1out));
	
	//1 bit shift
	//assign wire [31:0] 1out = [0,shift3out[31:1]];
	assign out_1pos = {1'b0,shift1out[31:1]};
	assign out_1neg = {1'b1,shift1out[31:1]};
	
	//choose between 1 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_4 (.A(shift1out) , .B(shift1out), .C(out_1pos) , .D(out_1neg), .S({Y[0],X[31]}) , .Z(shift0out));

	assign Z = shift0out;
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
