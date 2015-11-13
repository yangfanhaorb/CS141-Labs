`ifndef MIPS_MULTICYCLE_DEFINES
`define MIPS_MULTICYCLE_DEFINES
//main FSM states
`define S_FETCH          4'd0
`define S_DECODE         4'd1
`define S_EXECUTE        4'd2
`define S_MEMORY         4'd3
`define S_WRITEBACK      4'd4
`define S_MEMORY1        4'd6
`define S_MEMORY2        4'd7
`define S_FETCH1         4'd8
`define S_FETCH2         4'd9
`define S_FAILURE        4'hf

//switch codes for the PC source mux
`define PC_SRC_SW_WIDTH 2
`define PC_SRC_SW_ALU      2'd0 //the current combinational ALU result
`define PC_SRC_SW_ALU_LAST 2'd1 //the last ALU result
`define PC_SRC_SW_JUMP     2'd2 //the jump target out of the IR

//switch codes for the ALU source muxes
`define ALU_SRC_A_SW_WIDTH		1
`define ALU_SRC_A_SW_REG_A      1'd0
`define ALU_SRC_A_SW_PC         1'd1

`define ALU_SRC_B_SW_WIDTH		3
`define ALU_SRC_B_SW_REG_B      3'd0
`define ALU_SRC_B_SW_SEI        3'd1 //sign extended immediate
`define ALU_SRC_B_SW_SESI       3'd2 //sign extended shifted immediate
`define ALU_SRC_B_SW_SHAMT      3'd3 //shift amount
`define ALU_SRC_B_SW_4			3'd4 //the number four (for PC + 4)
`define ALU_SRC_B_SW_16			3'd5 //the number 16   (for LUI...and that's about it)

`endif

