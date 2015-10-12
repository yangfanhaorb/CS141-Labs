`timescale 1ns / 1ps
`default_nettype none

`include "lab3_defines.v"

module tft_driver(tft_clk, rst, tft_backlight, tft_data_ena, tft_display, tft_vdd, x, y, new_frame, brightness);


input wire tft_clk, rst;
input wire [7:0] brightness;
output wire tft_backlight, tft_data_ena;
output reg tft_display, tft_vdd;

output reg [(`TFT_X_NUM_BITS-1):0] x;
output reg [(`TFT_Y_NUM_BITS-1):0] y;
output wire new_frame;

wire blanking;
reg [2:0] clk_div_counter;
wire [(`TFT_BITS_PER_COLOR-1):0] r, g, b;

pwm #(.N(8)) PWM0 (.clk(tft_clk), .rst(rst), .din(brightness), .dout(tft_backlight));
//assign tft_backlight = 1; //comment out the pwm module instantiation and uncomment this line to check your tft driver module without PWM
/* insert your code here <<< */

/* >>> */
endmodule
`default_nettype wire
