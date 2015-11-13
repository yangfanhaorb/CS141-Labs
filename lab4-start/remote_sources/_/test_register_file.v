`default_nettype none
`timescale 1ns/1ps

module test_register_file;

parameter N = 32;

reg  clk, rst;
reg [4:0] rd_addr0, rd_addr1, wr_addr;
wire [N-1:0] rd_data0, rd_data1;
reg [N-1:0] wr_data;
reg  wr_ena;

register_file #(.N(32)) UUT (
	.clk(clk),
	.rst(rst),
	.rd_addr0(rd_addr0),
	.rd_addr1(rd_addr1),
	.wr_addr(wr_addr),
	.rd_data0(rd_data0),
	.rd_data1(rd_data1),
	.wr_data(wr_data),
	.wr_ena(wr_ena)
);

integer i, j, errors = 0;

initial begin
	clk = 0;
	rst = 0;
	rd_addr0 = 0;
	rd_addr1 = 0;
	wr_addr = 0;
	wr_data = 0;
	wr_ena = 0;
	
	rst = 1;
	@(posedge clk); 
	@(negedge clk) rst = 0;
	
	/* -load values into the register file
		  - suggestion: unique non-zero value per register
		  - try to attempt to load data into r00! - that should result in no change on the output (because that needs to be zero all the time!)
		-read out what was loaded in, confirm that it looks right
	*/
	
	
	$finish;
end

always #5 clk = ~clk;


endmodule

`default_nettype wire
