`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
`include "lab3_defines.v"
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2015
// Module Name:    graphics_unit 
// Author(s): 
// Description: A purely combinational (behavioural is fine) block that decides 
//              what colors to output based on the tft_x,y, touch_x,y, and mem
//              signals based on which state the system is in.
//////////////////////////////////////////////////////////////////////////////////
module graphics_unit(state,tft_x,tft_y,touch_x,touch_y,touch_valid,mem_rd_data,red,green,blue);

	//parameter definitions

	//port definitions
	input  wire [1:0] state;
	input  wire [9:0] tft_x;
	input  wire [8:0] tft_y;
	input  wire [9:0] touch_x;
	input  wire [8:0] touch_y;
	input  wire touch_valid;
	input  wire [8:0] mem_rd_data;
	output reg  [7:0] red;
	output reg  [7:0] green;
	output reg  [7:0] blue;
	
	/* put any combinational logic for the moving square here: <<<*/
	
	/*>>>*/
	
	always @(*) begin
		case (state)
			`DEMO_SINGLE_COLOR  : begin
				/* insert your favorite color here */
				red   = 8'h00;
				green = 8'hff;
				blue  = 8'h00;
			end
			`DEMO_STATIC_SQUARE : begin
				/* insert your code here <<<*/
				if ((tft_x > 247)&(tft_x < 277)&(tft_y > 129)&(tft_y < 159)) begin
					red   = 8'hff;
					green = 8'hff;
					blue  = 8'hff;
				end
				else begin
					red   = 8'h00;
					green = 8'hff;
					blue  = 8'h00;
				end
				
				/* >>> */
			end
			`DEMO_MOVING_SQUARE : begin
				/* insert your code here <<< */
				
				/* >>> */
			end
			`DEMO_ETCH_A_SKETCH : begin
				//here we are dealing with the fact that our memory isn't big enough to hold 8 bits per color, so I just repeat the bits over again a few times.  
				red   = {mem_rd_data[8:6], mem_rd_data[8:6], mem_rd_data[8:6]};
				green = {mem_rd_data[5:3], mem_rd_data[5:3], mem_rd_data[5:3]};
				blue  = {mem_rd_data[2:0], mem_rd_data[2:0], mem_rd_data[2:0]};
			end

		endcase
	end


endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
