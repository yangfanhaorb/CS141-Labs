`default_nettype none

module pwm(clk, rst, din, dout);
parameter N = 8; // bits in PWM counter

input wire clk, rst;
input wire [N-1:0] din;
output wire dout;

parameter divider_count = 255; // how high to count before pulsing
reg [$clog2(divider_count)-1:0] divider_counter; // a handy trick to make sure your counters are always the right width (clog2 is ceiling(log2())
/* insert your code here <<<*/

reg out;

assign dout = (divider_counter <= din);

always @(posedge clk) begin
		if(rst) begin
			divider_counter <= 8'd0;
		end
		else begin
			divider_counter <= divider_counter + 8'd1;
		//	if(divider_counter <= divider_count) begin
		//		out <= 1;
		//	end
		//	else begin
		//		out <= 0;
		//	end
		end
	end
	
//assign dout = out;
/* >>>*/
endmodule

`default_nettype wire
