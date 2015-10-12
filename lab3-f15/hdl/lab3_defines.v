`ifndef LAB3_DEFINES

`define LAB3_DEFINES

//the different states of the program
`define DEMO_SINGLE_COLOR  2'd0
`define DEMO_STATIC_SQUARE 2'd1
`define DEMO_MOVING_SQUARE 2'd2
`define DEMO_ETCH_A_SKETCH 2'd3

//some constants for the TFT display
`define TFT_X_RES 480 //pixel clock periods
`define TFT_Y_RES 272 //frame lines
`define TFT_X_BLANKING 45 //pixel clock periods
`define TFT_Y_BLANKING 16 // frame lines
`define TFT_CLK_DIV_COUNT 5 
`define TFT_BITS_PER_COLOR 3  //512 colors
`define TFT_BITS_PER_PIXEL 9
`define TFT_X_NUM_BITS 10
`define TFT_Y_NUM_BITS 9

`define TFT_NUM_PIXELS  (`TFT_X_RES * `TFT_Y_RES )

`endif
