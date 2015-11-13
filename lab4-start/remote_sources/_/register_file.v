`default_nettype none
`timescale 1ns/1ps

module register_file(clk, rst, rd_addr0, rd_addr1, wr_addr, rd_data0, rd_data1, wr_data, wr_ena, full_register_file);

parameter N = 32;
input wire clk, rst;
input wire [4:0] rd_addr0, rd_addr1, wr_addr;
output reg [N-1:0] rd_data0, rd_data1;
input wire [N-1:0] wr_data;
input wire wr_ena;

reg [31:0] regfile [31:0];

always @(*) begin
	/* insert your code here!!! */
	if (rst) begin
		// automatically set to zero after posedge
	end
	else begin
		case (wr_addr)
			5'd00: d00 = wr_data;
			5'd01: d01 = wr_data;
			5'd02: d02 = wr_data;
			5'd03: d03 = wr_data;
			5'd04: d04 = wr_data;
			5'd05: d05 = wr_data;
			5'd06: d06 = wr_data;
			5'd07: d07 = wr_data;
			5'd08: d08 = wr_data;
			5'd09: d09 = wr_data;
			5'd10: d10 = wr_data;
			5'd11: d11 = wr_data;
			5'd12: d12 = wr_data;
			5'd13: d13 = wr_data;
			5'd14: d14 = wr_data;
			5'd15: d15 = wr_data;
			5'd16: d16 = wr_data;
			5'd17: d17 = wr_data;
			5'd18: d18 = wr_data;
			5'd19: d19 = wr_data;
			5'd20: d20 = wr_data;
			5'd21: d21 = wr_data;
			5'd22: d22 = wr_data;
			5'd23: d23 = wr_data;
			5'd24: d24 = wr_data;
			5'd25: d25 = wr_data;
			5'd26: d26 = wr_data;
			5'd27: d27 = wr_data;
			5'd28: d28 = wr_data;
			5'd29: d29 = wr_data;
			5'd30: d30 = wr_data;
			5'd31: d31 = wr_data;
		endcase
		case (wr_addr)
			5'd00: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
			5'd01: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
			5'd02: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
			5'd03: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
			5'd04: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0001_0000;
			5'd05: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0010_0000;
			5'd06: reg_enas = 32'b0000_0000_0000_0000_0000_0000_0100_0000;
			5'd07: reg_enas = 32'b0000_0000_0000_0000_0000_0000_1000_0000;
			5'd08: reg_enas = 32'b0000_0000_0000_0000_0000_0001_0000_0000;
			5'd09: reg_enas = 32'b0000_0000_0000_0000_0000_0010_0000_0000;
			5'd10: reg_enas = 32'b0000_0000_0000_0000_0000_0100_0000_0000;
			5'd11: reg_enas = 32'b0000_0000_0000_0000_0000_1000_0000_0000;
			5'd12: reg_enas = 32'b0000_0000_0000_0000_0001_0000_0000_0000;
			5'd13: reg_enas = 32'b0000_0000_0000_0000_0010_0000_0000_0000;
			5'd14: reg_enas = 32'b0000_0000_0000_0000_0100_0000_0000_0000;
			5'd15: reg_enas = 32'b0000_0000_0000_0000_1000_0000_0000_0000;
			5'd16: reg_enas = 32'b0000_0000_0000_0001_0000_0000_0000_0000;
			5'd17: reg_enas = 32'b0000_0000_0000_0010_0000_0000_0000_0000;
			5'd18: reg_enas = 32'b0000_0000_0000_0100_0000_0000_0000_0000;
			5'd19: reg_enas = 32'b0000_0000_0000_1000_0000_0000_0000_0000;
			5'd20: reg_enas = 32'b0000_0000_0001_0000_0000_0000_0000_0000;
			5'd21: reg_enas = 32'b0000_0000_0010_0000_0000_0000_0000_0000;
			5'd22: reg_enas = 32'b0000_0000_0100_0000_0000_0000_0000_0000;
			5'd23: reg_enas = 32'b0000_0000_1000_0000_0000_0000_0000_0000;
			5'd24: reg_enas = 32'b0000_0001_0000_0000_0000_0000_0000_0000;
			5'd25: reg_enas = 32'b0000_0010_0000_0000_0000_0000_0000_0000;
			5'd26: reg_enas = 32'b0000_0100_0000_0000_0000_0000_0000_0000;
			5'd27: reg_enas = 32'b0000_1000_0000_0000_0000_0000_0000_0000;
			5'd28: reg_enas = 32'b0001_0000_0000_0000_0000_0000_0000_0000;
			5'd29: reg_enas = 32'b0010_0000_0000_0000_0000_0000_0000_0000;
			5'd30: reg_enas = 32'b0100_0000_0000_0000_0000_0000_0000_0000;
			5'd31: reg_enas = 32'b1000_0000_0000_0000_0000_0000_0000_0000;
		endcase
		case(rd_addr0)
			5'd00: rd_data0 = r00;
			5'd01: rd_data0 = r01;
			5'd02: rd_data0 = r02;
			5'd03: rd_data0 = r03;
			5'd04: rd_data0 = r04;
			5'd05: rd_data0 = r05;
			5'd06: rd_data0 = r06;
			5'd07: rd_data0 = r07;
			5'd08: rd_data0 = r08;
			5'd09: rd_data0 = r09;
			5'd10: rd_data0 = r10;
			5'd11: rd_data0 = r11;
			5'd12: rd_data0 = r12;
			5'd13: rd_data0 = r13;
			5'd14: rd_data0 = r14;
			5'd15: rd_data0 = r15;
			5'd16: rd_data0 = r16;
			5'd17: rd_data0 = r17;
			5'd18: rd_data0 = r18;
			5'd19: rd_data0 = r19;
			5'd20: rd_data0 = r20;
			5'd21: rd_data0 = r21;
			5'd22: rd_data0 = r22;
			5'd23: rd_data0 = r23;
			5'd24: rd_data0 = r24;
			5'd25: rd_data0 = r25;
			5'd26: rd_data0 = r26;
			5'd27: rd_data0 = r27;
			5'd28: rd_data0 = r28;
			5'd29: rd_data0 = r29;
			5'd30: rd_data0 = r30;
			5'd31: rd_data0 = r31;
		endcase
		case(rd_addr1)
			5'd00: rd_data1 = r00;
			5'd01: rd_data1 = r01;
			5'd02: rd_data1 = r02;
			5'd03: rd_data1 = r03;
			5'd04: rd_data1 = r04;
			5'd05: rd_data1 = r05;
			5'd06: rd_data1 = r06;
			5'd07: rd_data1 = r07;
			5'd08: rd_data1 = r08;
			5'd09: rd_data1 = r09;
			5'd10: rd_data1 = r10;
			5'd11: rd_data1 = r11;
			5'd12: rd_data1 = r12;
			5'd13: rd_data1 = r13;
			5'd14: rd_data1 = r14;
			5'd15: rd_data1 = r15;
			5'd16: rd_data1 = r16;
			5'd17: rd_data1 = r17;
			5'd18: rd_data1 = r18;
			5'd19: rd_data1 = r19;
			5'd20: rd_data1 = r20;
			5'd21: rd_data1 = r21;
			5'd22: rd_data1 = r22;
			5'd23: rd_data1 = r23;
			5'd24: rd_data1 = r24;
			5'd25: rd_data1 = r25;
			5'd26: rd_data1 = r26;
			5'd27: rd_data1 = r27;
			5'd28: rd_data1 = r28;
			5'd29: rd_data1 = r29;
			5'd30: rd_data1 = r30;
			5'd31: rd_data1 = r31;
		endcase
	end
end


reg [N-1:0] reg_enas;
reg [N-1:0] d00, d01, d02, d03, d04, d05, d06, d07, d08, d09, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31;
wire [N-1:0] r00, r01, r02, r03, r04, r05, r06, r07, r08, r09, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;

/* instantiate register.v modules here using the available signals.  you may find it helpful to use a scripting language to repeat your instantiation 32 times*/
//  a = ['register #(.N(32)) reg_%02d (.clk(clk), .rst(rst), .d(d%02d), .q(r%02d), .ena(reg_enas[%02d]));' %(i,i,i,i) for i in range(32)]
// for line in a:
//     print line
register #(.N(32)) reg_00 (.clk(clk), .rst(rst), .d(d00), .q(r00), .ena(reg_enas[00]));
register #(.N(32)) reg_01 (.clk(clk), .rst(rst), .d(d01), .q(r01), .ena(reg_enas[01]));
register #(.N(32)) reg_02 (.clk(clk), .rst(rst), .d(d02), .q(r02), .ena(reg_enas[02]));
register #(.N(32)) reg_03 (.clk(clk), .rst(rst), .d(d03), .q(r03), .ena(reg_enas[03]));
register #(.N(32)) reg_04 (.clk(clk), .rst(rst), .d(d04), .q(r04), .ena(reg_enas[04]));
register #(.N(32)) reg_05 (.clk(clk), .rst(rst), .d(d05), .q(r05), .ena(reg_enas[05]));
register #(.N(32)) reg_06 (.clk(clk), .rst(rst), .d(d06), .q(r06), .ena(reg_enas[06]));
register #(.N(32)) reg_07 (.clk(clk), .rst(rst), .d(d07), .q(r07), .ena(reg_enas[07]));
register #(.N(32)) reg_08 (.clk(clk), .rst(rst), .d(d08), .q(r08), .ena(reg_enas[08]));
register #(.N(32)) reg_09 (.clk(clk), .rst(rst), .d(d09), .q(r09), .ena(reg_enas[09]));
register #(.N(32)) reg_10 (.clk(clk), .rst(rst), .d(d10), .q(r10), .ena(reg_enas[10]));
register #(.N(32)) reg_11 (.clk(clk), .rst(rst), .d(d11), .q(r11), .ena(reg_enas[11]));
register #(.N(32)) reg_12 (.clk(clk), .rst(rst), .d(d12), .q(r12), .ena(reg_enas[12]));
register #(.N(32)) reg_13 (.clk(clk), .rst(rst), .d(d13), .q(r13), .ena(reg_enas[13]));
register #(.N(32)) reg_14 (.clk(clk), .rst(rst), .d(d14), .q(r14), .ena(reg_enas[14]));
register #(.N(32)) reg_15 (.clk(clk), .rst(rst), .d(d15), .q(r15), .ena(reg_enas[15]));
register #(.N(32)) reg_16 (.clk(clk), .rst(rst), .d(d16), .q(r16), .ena(reg_enas[16]));
register #(.N(32)) reg_17 (.clk(clk), .rst(rst), .d(d17), .q(r17), .ena(reg_enas[17]));
register #(.N(32)) reg_18 (.clk(clk), .rst(rst), .d(d18), .q(r18), .ena(reg_enas[18]));
register #(.N(32)) reg_19 (.clk(clk), .rst(rst), .d(d19), .q(r19), .ena(reg_enas[19]));
register #(.N(32)) reg_20 (.clk(clk), .rst(rst), .d(d20), .q(r20), .ena(reg_enas[20]));
register #(.N(32)) reg_21 (.clk(clk), .rst(rst), .d(d21), .q(r21), .ena(reg_enas[21]));
register #(.N(32)) reg_22 (.clk(clk), .rst(rst), .d(d22), .q(r22), .ena(reg_enas[22]));
register #(.N(32)) reg_23 (.clk(clk), .rst(rst), .d(d23), .q(r23), .ena(reg_enas[23]));
register #(.N(32)) reg_24 (.clk(clk), .rst(rst), .d(d24), .q(r24), .ena(reg_enas[24]));
register #(.N(32)) reg_25 (.clk(clk), .rst(rst), .d(d25), .q(r25), .ena(reg_enas[25]));
register #(.N(32)) reg_26 (.clk(clk), .rst(rst), .d(d26), .q(r26), .ena(reg_enas[26]));
register #(.N(32)) reg_27 (.clk(clk), .rst(rst), .d(d27), .q(r27), .ena(reg_enas[27]));
register #(.N(32)) reg_28 (.clk(clk), .rst(rst), .d(d28), .q(r28), .ena(reg_enas[28]));
register #(.N(32)) reg_29 (.clk(clk), .rst(rst), .d(d29), .q(r29), .ena(reg_enas[29]));
register #(.N(32)) reg_30 (.clk(clk), .rst(rst), .d(d30), .q(r30), .ena(reg_enas[30]));
register #(.N(32)) reg_31 (.clk(clk), .rst(rst), .d(d31), .q(r31), .ena(reg_enas[31]));

//this is used in the final synthesized version of this lab.
output wire [32*32-1:0] full_register_file;
assign full_register_file = {r31,r30,r29,r28,r27,r26,r25,r24,r23,r22,r21,r20,r19,r18,r17,r16,r15,r14,r13,r12,r11,r10,r09,r08,r07,r06,r05,r04,r03,r02,r01,r00};

//these tasks are tremendously useful for debugging your CPU
task print_hex;
begin
	//print "\t" + "\n\t".join(["$display(\"r%02d::%8s::%%h\",r%02d);"%(i,x,i) for i,x in enumerate(register_names)]) #generator code (python)
	$display("r00::   $zero::%h",r00);
	$display("r01::     $at::%h",r01);
	$display("r02::     $v0::%h",r02);
	$display("r03::     $v1::%h",r03);
	$display("r04::     $a0::%h",r04);
	$display("r05::     $a1::%h",r05);
	$display("r06::     $a2::%h",r06);
	$display("r07::     $a3::%h",r07);
	$display("r08::     $t0::%h",r08);
	$display("r09::     $t1::%h",r09);
	$display("r10::     $t2::%h",r10);
	$display("r11::     $t3::%h",r11);
	$display("r12::     $t4::%h",r12);
	$display("r13::     $t5::%h",r13);
	$display("r14::     $t6::%h",r14);
	$display("r15::     $t7::%h",r15);
	$display("r16::     $s0::%h",r16);
	$display("r17::     $s1::%h",r17);
	$display("r18::     $s2::%h",r18);
	$display("r19::     $s3::%h",r19);
	$display("r20::     $s4::%h",r20);
	$display("r21::     $s5::%h",r21);
	$display("r22::     $s6::%h",r22);
	$display("r23::     $s7::%h",r23);
	$display("r24::     $t8::%h",r24);
	$display("r25::     $t9::%h",r25);
	$display("r26::     $k0::%h",r26);
	$display("r27::     $k1::%h",r27);
	$display("r28::     $gp::%h",r28);
	$display("r29::     $sp::%h",r29);
	$display("r30::     $fp::%h",r30);
	$display("r31::     $ra::%h",r31);
end
endtask

task print_decimal;
begin
	//print "\t" + "\n\t".join(["$display(\"r%02d::%8s::%%h\",r%02d);"%(i,x,i) for i,x in enumerate(register_names)]) #generator code (python)
	$display("r00::   $zero::%d",r00);
	$display("r01::     $at::%d",r01);
	$display("r02::     $v0::%d",r02);
	$display("r03::     $v1::%d",r03);
	$display("r04::     $a0::%d",r04);
	$display("r05::     $a1::%d",r05);
	$display("r06::     $a2::%d",r06);
	$display("r07::     $a3::%d",r07);
	$display("r08::     $t0::%d",r08);
	$display("r09::     $t1::%d",r09);
	$display("r10::     $t2::%d",r10);
	$display("r11::     $t3::%d",r11);
	$display("r12::     $t4::%d",r12);
	$display("r13::     $t5::%d",r13);
	$display("r14::     $t6::%d",r14);
	$display("r15::     $t7::%d",r15);
	$display("r16::     $s0::%d",r16);
	$display("r17::     $s1::%d",r17);
	$display("r18::     $s2::%d",r18);
	$display("r19::     $s3::%d",r19);
	$display("r20::     $s4::%d",r20);
	$display("r21::     $s5::%d",r21);
	$display("r22::     $s6::%d",r22);
	$display("r23::     $s7::%d",r23);
	$display("r24::     $t8::%d",r24);
	$display("r25::     $t9::%d",r25);
	$display("r26::     $k0::%d",r26);
	$display("r27::     $k1::%d",r27);
	$display("r28::     $gp::%d",r28);
	$display("r29::     $sp::%d",r29);
	$display("r30::     $fp::%d",r30);
	$display("r31::     $ra::%d",r31);
end
endtask


endmodule
`default_nettype wire


