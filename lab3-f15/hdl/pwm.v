`default_nettype none

module pwm(clk, rst, din, dout);
parameter N = 8; // bits in PWM counter

input wire clk, rst;
input wire [N-1:0] din;
output wire dout;

/* insert your code here <<<*/
parameter divider_count = 255; // how high to count before pulsing


reg [$clog2(divider_count):0] divider_counter;
reg [N-1:0] pwm_counter;


always @(posedge clk) begin
	if(rst) begin
		divider_counter <= 0;
		pwm_counter <= 0;
	end
	else begin
		if(divider_counter < divider_count) begin
			divider_counter <= divider_counter + 1;
		end
		else begin
			divider_counter <= 0;
			pwm_counter <= pwm_counter + 1;
		end
	end
end

assign dout = rst ?  0 : (pwm_counter < din);

/* >>>*/
endmodule

`default_nettype wire
