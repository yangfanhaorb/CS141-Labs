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
	
	// intermediary wires
	wire [31:0] shift4out;
	wire [31:0] shift3out;
	wire [31:0] shift2out;
	wire [31:0] shift1out;
	wire [31:0] shift0out;
	wire [31:0] alltheway;
	
	// decision array for shift to 0
	wire [5:0] farshift;
	wire [5:0] dofarshift;
	wire [4:0] decide1;
	wire [4:0] decide2;
	
	
	
	//make all 0 if shfiting more than 31
	assign farshift[5] = |Y[31:5];
	assign dofarshift[5] = |Y[31:5];
	param_2_to_1_mux #(.N(32)) MUX_init (.X(X) , .Y(0) , .S( farshift[5]) , .Z(alltheway));

	//assign out_16 = Z[31:0];//[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,Z[31:16]];
	assign out_16pos = {16'b0000000000000000,alltheway[31:16]};
	assign out_16neg = {16'b1111111111111111,alltheway[31:16]};

	//determine if shift to 0
	
	assign farshift[4] = &alltheway[31:15];
	assign dofarshift[4] = farshift[4]&Y[4];
	assign decide1[4] = (~farshift[4] & Y[4]& ~(|dofarshift[5]));
	assign decide2[4] = ((X[31]|farshift[4])&Y[4]);
	
	//choose between 16 bit shift or 0 or skip
	param_4_to_1_mux #(.width(32)) MUX_0 (.A(alltheway), 
													.B(0), 
													.C(out_16pos), 
													.D(out_16neg) , 
													.S({decide1[4],decide2[4]}) , 
													.Z(shift4out));
	
	//8 bit shift
	//assign wire [31:0] out_8 = {0,0,0,0,0,0,0,0,shift4out[31:8]};
	assign out_8pos = {8'b00000000,shift4out[31:8]};
	assign out_8neg = {8'b11111111,shift4out[31:8]};
	
	//determine if shift to 0
	assign farshift[3] = &shift4out[31:7];
	assign dofarshift[3] = farshift[3]&Y[3];
	assign decide1[3] = (~farshift[3] & Y[3]& ~(|dofarshift[5:4]));
	assign decide2[3] = ((X[31]|farshift[3])&Y[3]);
	
	//choose between 8 bit shift or 0 or skip, pos or neg
	param_4_to_1_mux #(.width(32)) MUX_1 (.A(shift4out) , 
														.B(0), 
														.C(out_8pos), 
														.D(out_8neg) , 
														.S({decide1[3],decide2[3]}) , 
														.Z(shift3out));
	
	//4 bit shift
	//assign wire [31:0] 4out = [0,0,0,0,shift3out[31:4]];
	assign out_4pos = {4'b0000,shift3out[31:4]};
	assign out_4neg = {4'b1111,shift3out[31:4]};
	
	//determine if shift to 0
	assign farshift[2] = &shift3out[31:3];
	assign dofarshift[2] = farshift[2]&Y[2];
	assign decide1[2] = (~farshift[2] & Y[2]& ~(|dofarshift[5:3]));
	assign decide2[2] = ((X[31]|farshift[2])&Y[2]);
	
	//choose between 4 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_2 (.A(shift3out) , 
														.B(0),
														.C(out_4pos) , 
														.D(out_4neg),
														.S({decide1[2],decide2[2]}) , 
														.Z(shift2out));
	
	//2 bit shift
	//assign wire [31:0] 2out = [0,0,shift3out[31:2]];
	assign out_2pos = {2'b00,shift2out[31:2]};
	assign out_2neg = {2'b11,shift2out[31:2]};
	
	//determine if shift to 0
	assign farshift[1] = &shift2out[31:1];
	assign dofarshift[1] = farshift[1]&Y[1];
	assign decide1[1] = (~farshift[1] & Y[1]& ~(|dofarshift[5:2]));
	assign decide2[1] = ((X[31]|farshift[1])&Y[1]);
	
	//choose between 2 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_3 (.A(shift2out) , 
														.B(0),
														.C(out_2pos), 
														.D(out_2neg) , 
														.S({decide1[1],decide2[1]}) , 
														.Z(shift1out));
	
	//1 bit shift
	//assign wire [31:0] 1out = [0,shift3out[31:1]];
	assign out_1pos = {1'b0,shift1out[31:1]};
	assign out_1neg = {1'b1,shift1out[31:1]};
	
	//determine if shift to 0
	assign farshift[0] = &shift1out;
	assign dofarshift[0] = farshift[0]&Y[0];
	assign decide1[0] = (~farshift[0] & Y[0]& ~(|dofarshift[5:1]));
	assign decide2[0] = ((X[31]|farshift[0])&Y[0]);
	
	
	//choose between 1 bit shift or skip
	param_4_to_1_mux #(.width(32)) MUX_4 (.A(shift1out) , 
														.B(0), 
														.C(out_1pos) , 
														.D(out_1neg), 
														.S({decide1[0],decide2[0]}) , 
														.Z(shift0out));

	assign Z = shift0out;
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
