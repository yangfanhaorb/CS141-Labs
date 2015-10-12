`timescale 1ns / 1ps
`default_nettype none

module test_tft;
	// Inputs
	reg tft_clk;
	reg rst;

	// Outputs
	wire tft_backlight;
	wire tft_data_ena;
	wire tft_display;
	wire tft_vdd;
	wire [9:0] x;
	wire [8:0] y;
	wire new_frame;

	// Instantiate the Unit Under Test (UUT)
	tft_driver uut (
		.rst(rst),
		.tft_backlight(tft_backlight), 
		.tft_data_ena(tft_data_ena), 
		.tft_display(tft_display), 
		.tft_vdd(tft_vdd), 
		.tft_clk(tft_clk), 
		.x(x), 
		.y(y), 
		.new_frame(new_frame)
	);
	
	always #4.5 tft_clk = ~tft_clk;

	initial begin
		//icarus verilog specific
		$dumpfile("waves/test_tft.lxt");
		$dumpvars(0, uut);
		
		// Initialize Inputs
		tft_clk = 0;
		rst = 1;
		
		// reset
		rst = 1;
		repeat (2) @(posedge tft_clk);
		rst = 0;
		
		// wait until the new_frame goes high a couple times
		$display("waiting for new_frame (1/2)...");
		@(posedge new_frame);
		$display("...done");
		
		$display("waiting for new_frame (2/2)...");
		@(posedge new_frame);
		$display("...done");
		
		$display("test success, check the waveforms!");
		$finish;
	end
	
	// have a hard time out in case new_frame doesn't work and you still want to test
	initial begin //you can have multiple initial blocks, by the way
		repeat (480*272*3) @(posedge tft_clk);
		$display("ERROR: TEST TIMED OUT!");
		$finish;
	end
	
endmodule




`default_nettype wire
