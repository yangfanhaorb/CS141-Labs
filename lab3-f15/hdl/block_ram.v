`default_nettype none

/*
	Avinash Uttamchandani (avinash@seas.harvard.edu) 2015
	
	implements a RAM that is both simulatable and will be appropriately inferred as Block RAM by Xilinx

*/

module block_ram(clk0, clk1, addr0, addr1, wr_ena0, wr_data0, rd_data0, rd_data1);

//parameters
parameter LENGTH = 1024;
parameter ADDR_WIDTH = $clog2(LENGTH);
parameter WIDTH = 8;

//ports
input wire clk0, clk1, wr_ena0;

input wire [ADDR_WIDTH-1:0] addr0, addr1;

input  wire [WIDTH-1:0] wr_data0;
output wire [WIDTH-1:0] rd_data0, rd_data1;

reg [ADDR_WIDTH-1:0] rd_addr0, rd_addr1;

//the ram itself
reg [WIDTH-1:0] ram [LENGTH-1:0];


always @(posedge clk0) begin
	if(wr_ena0) begin
		ram[addr0] <= wr_data0;
	end
	rd_addr0 <= addr0;
end

assign rd_data0 = ram[rd_addr0];

always @(posedge clk1) begin
	rd_addr1 <= addr1;
end

assign rd_data1 = ram[rd_addr1];


endmodule

`default_nettype wire
