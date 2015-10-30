`timescale 1ns / 1ps

`default_nettype none //makes undeclared nets errors instead of automatic wires

module main(
	//default IO
	input wire unbuf_clk, rstb,
	input wire [7:0] switch, //switches [1:0] used to change demo state
	output wire [7:0] led,
	output wire [7:0] JB,
	input wire button_up, button_down, button_right, button_left, button_center,
	//tft IO
	output wire tft_backlight, tft_clk, tft_data_ena,
	output wire tft_display,tft_vdd,
	output wire [7:0] tft_red, tft_green, tft_blue,
	//touchpad IO
	input wire touch_busy, touch_data_out, touch_interrupt,
	output wire touch_csb, touch_clk, touch_data_in
);

//clocking signals
wire cclk, cclk_n, tft_clk_buf, tft_clk_buf_n, clocks_locked;
wire rst;
assign rst = ~rstb;

//touchpad signals
wire touch_valid;
wire [8:0] touch_x, touch_y, touch_z;
reg [8:0] frame_locked_touch_x, frame_locked_touch_y, frame_locked_touch_z;

//tft signals
wire [9:0] tft_x;
wire [8:0] tft_y;
wire tft_new_frame;

//debugging signals


//generate all the clocks
clock_generator CLOCK_GEN (.clk_100M_in(unbuf_clk), .clk_100M(cclk), .clk_100M_n(cclk_n), .clk_9M(tft_clk_buf), .clk_9M_n(tft_clk_buf_n), .reset(rst), .locked(clocks_locked));
//pass the tft_clk through a DDR2 output buffer (so that it can drive external loads and so that internal loads are unaffected by large skew routing)
ODDR2 tft_clk_fixer (.D0(1'b1), .D1(1'b0), .C0(tft_clk_buf), .C1(tft_clk_buf_n), .Q(tft_clk), .CE(1'b1));

//debugging with LEDs and the switches - different configurations of the switches we aren't using will cause different signals to make it to the LEDs
reg [7:0] led_reg;
assign led = led_reg;
always @(*) begin
	case(switch[6:2])
		5'd0 : led_reg = touch_x[8:1];
		5'd1 : led_reg = touch_y[8:1];
		5'd2 : led_reg = touch_z[8:1];
		5'd3 : led_reg = screen_brightness;
		default: led_reg = 0;
	endcase
end

//debugging port
assign JB = 8'b0; //feel free to connect signals here so that you can probe them

//instantiate the TFT driver

tft_driver TFT(
	.rst(rst),
	.tft_backlight(tft_backlight),
	.tft_clk(tft_clk_buf),
	.tft_data_ena(tft_data_ena),
	.tft_display(tft_display),
	.tft_vdd(tft_vdd),
	.x(tft_x), .y(tft_y),
	.new_frame(tft_new_frame),
	.brightness(screen_brightness)
);
//ensure that the tft RGB signals are zero during the blanking signal (this is critical for driving tft or vga like signals)
assign tft_red   = (tft_data_ena) ? red   : 8'd0;
assign tft_green = (tft_data_ena) ? green : 8'd0;
assign tft_blue  = (tft_data_ena) ? blue  : 8'd0;

wire [7:0] red,green,blue;
graphics_unit GPU (
	.state(switch[1:0]),
	.tft_x(tft_x),
	.tft_y(tft_y),
	.touch_x(frame_locked_touch_x),
	.touch_y(frame_locked_touch_y),
	.touch_valid(touch_valid),
	.mem_rd_data(tft_rd_data), 
	.red(red),
	.green(green),
	.blue(blue)
);

//instantiate the touchpad controller
touchpad_controller TOUCH(
	.cclk(cclk), .rstb(rstb), .touch_clk(touch_clk),
	.touch_busy(touch_busy),
	.data_in(touch_data_out),
	.data_out(touch_data_in),
	.touch_csb(touch_csb),
	.x(touch_x),
	.y(touch_y),
	.z(touch_z),
	.touch_valid(touch_valid)
);

/* The touchpad controller and the tft driver are running in parallel. 
 This means that the touchpad is updating its values while we are still drawing onto the screen
 Use sequential logic here to ensure that frame_locked_touch_x, frame_locked_touch_y, frame_locked_touch_z
 all only change when you have a new frame (hint, check out flip flops with enables)
*/

// assign frame_locked_touch_x = touch_x; //REPLACE THIS LINE TO ELIMINATE TEARING
// assign frame_locked_touch_y = touch_y; //REPLACE THIS LINE TO ELIMINATE TEARING
// assign frame_locked_touch_z = touch_z; //REPLACE THIS LINE TO ELIMINATE TEARING
/*insert your code here <<< */
always @(posedge tft_clk_buf) begin
	if ((frame_locked_touch_x >= touch_x + 4)|(frame_locked_touch_x <= touch_x - 4)) begin // only change when the touch location is changing significantly
		frame_locked_touch_x <= tft_new_frame ? touch_x : frame_locked_touch_x;
	end
	if ((frame_locked_touch_y >= touch_y + 4)|(frame_locked_touch_y <= touch_y - 4)) begin
		frame_locked_touch_y <= tft_new_frame ? touch_y : frame_locked_touch_y;
	end
	if ((frame_locked_touch_z >= touch_z + 4)|(frame_locked_touch_z <= touch_z - 4)) begin
		frame_locked_touch_z <= tft_new_frame ? touch_z : frame_locked_touch_z;
	end
end
/*>>>*/

wire vram_wr_ena;
wire [16:0] vram_wr_addr, touch_addr, tft_rd_addr;

wire [8:0] vram_wr_data, tft_rd_data;

tft_address_generator ADDR_GENERATOR_0 (.x(tft_x), .y(tft_y), .addr(tft_rd_addr));
tft_address_generator ADDR_GENERATOR_1 (.x(touch_x), .y(touch_y), .addr(touch_addr));

// the video memory - holds 9 bits per pixel, which is about the maximum amount of block ram available on the FPGA itself.  The Atlys board has additional ram on board, but interfacing with it is beyond the scope of this class.  If you are still reading, +1j for effort!
block_ram #(.LENGTH(480*272), .WIDTH(9)) VRAM (
	.clk0(cclk), 
	.clk1(tft_clk_buf), 
	.addr0(vram_wr_addr), 
	.addr1(tft_rd_addr), 
	.wr_ena0(vram_wr_ena), 
	.wr_data0(vram_wr_data), 
	//.rd_data0(), //not needed for this project
	.rd_data1(tft_rd_data)
);

reg vram_clear;
reg [16:0] vram_clear_counter; //you may want a counter in your clear FSM

assign vram_wr_addr = vram_clear ? vram_clear_counter : touch_addr; //todo: cut for stub

always @(posedge cclk) begin
	if(rst) begin
		vram_clear <= 0;
		vram_clear_counter <= 0;
	end
	else begin
		if(vram_clear) begin
			/*insert your code here <<<*/
			/*>>>*/
			if (vram_clear_counter < 131072) begin
				vram_clear_counter <= vram_clear_counter + 1;
			end
			else begin
				vram_clear_counter <= 0;
				vram_clear <= 0;
			end
			//make sure to set vram_clear <= 0 when you are done clearing the memory
		end
		else begin
			if(button_center_db) begin
				vram_clear <= 1;
				vram_clear_counter <= 0;
			end
		end
	end
end

wire [8:0] background_color, foreground_color;
assign background_color = 9'b000_000_100; //have fun by changing these around or driving them based on different signals (the touch signals, the switches/buttons).  Copying the screen brightness code could let you use the buttons to change the brightness or intensity of the colors
assign foreground_color = 9'b111_110_000;
assign vram_wr_data = vram_clear ? background_color : foreground_color;
//the vram write enable needs to be asserted while clearing;
// also while switch[7] is high and there is enough pressure on the touchpad
assign vram_wr_ena = vram_clear | (switch[7] & touch_valid); 

////////////////////////////////////////////////////////////////////////////////
///// some odds and ends that deal with the buttons                       //////
////////////////////////////////////////////////////////////////////////////////
//real buttons are literally bouncy - they bounce between high and low at their outputs a few times before settling.  These debouncer modules help filter those out, and are critical to any real design 
wire button_center_db, button_left_db, button_right_db, button_down_db, button_up_db;
debouncer #(.CYCLES(255)) DEBOUNCE_C (.clk(cclk), .rst(rst), .bouncy(button_center), .debounced(button_center_db));
debouncer #(.CYCLES(255)) DEBOUNCE_U (.clk(cclk), .rst(rst), .bouncy(button_up),     .debounced(button_up_db));
debouncer #(.CYCLES(255)) DEBOUNCE_D (.clk(cclk), .rst(rst), .bouncy(button_down),   .debounced(button_down_db));
debouncer #(.CYCLES(255)) DEBOUNCE_L (.clk(cclk), .rst(rst), .bouncy(button_left),   .debounced(button_left_db));
debouncer #(.CYCLES(255)) DEBOUNCE_R (.clk(cclk), .rst(rst), .bouncy(button_right),  .debounced(button_right_db));

//the FPGA's clock runs at 100MHz - if we are trying to create any sort of count based on the buttons, the counter ends up overflowing really quickly.  These oneshot modules only allow one output pulse per the DEADTIME parameter clock ticks.  I use this to change the PWM brightness with the up and down buttons
// with a dead time of 1,000,000 ticks, this means we get a very maneagable 100 counts per second (about 2.5 seconds to fill up the 8 bit counter that drives our pwm level).
wire up_shot,down_shot, left_shot, right_shot;
one_shot #(.DEAD_TIME(32'd1_000_000)) ONE_SHOT_U (.clk(cclk), .rst(rst), .trigger(button_up), .pulse(up_shot));
one_shot #(.DEAD_TIME(32'd1_000_000)) ONE_SHOT_D (.clk(cclk), .rst(rst), .trigger(button_down), .pulse(down_shot));
one_shot #(.DEAD_TIME(32'd1_000_000)) ONE_SHOT_L (.clk(cclk), .rst(rst), .trigger(button_left), .pulse(left_shot));
one_shot #(.DEAD_TIME(32'd1_000_000)) ONE_SHOT_R (.clk(cclk), .rst(rst), .trigger(button_right), .pulse(right_shot));

reg [7:0] screen_brightness;
always @(posedge cclk) begin
	if(rst) begin	
		screen_brightness <= 8'hf0; //start at half brightness
	end
	else begin
		if(up_shot) begin
			if(screen_brightness < 8'hff) begin
				screen_brightness <= screen_brightness + 8'd1;
			end
		end
		else begin //use an else to avoid ambiguities in the state of the counter if both buttons are pressed
			if(down_shot) begin
				if(screen_brightness > 8'h00) begin
					screen_brightness <= screen_brightness - 8'd1;
				end
			end
		end
	end
end

endmodule

`default_nettype wire //disable default_nettype so Xilinx's internal modules work properly
