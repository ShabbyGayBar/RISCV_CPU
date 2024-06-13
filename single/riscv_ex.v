`include "riscv_define.v"
`include "riscv_alu.v"

module riscv_ex (
	input		[`InstAddrBus]	pc_i,
	input		[`AluOpBus]	alu_op_i,
	input		[`RegBus]	alu_a_i,
	input		[`RegBus]	alu_b_i,
	input		[`RegBus]	offset_i,
	input				br_i,
	input				zero_en_i,
	output				br_o,
	output		[`InstAddrBus]	pc_o,
	output		[`MemAddrBus]	data_addr_o
);

//-------------------------------------------------------------
// ALU
//-------------------------------------------------------------
wire	zero;

riscv_alu ALU(
	.alu_op_i(alu_op_i),
	.alu_a_i(alu_a_i),
	.alu_b_i(alu_b_i),
	.zero_o(zero),
	.alu_p_o(data_addr_o)
);

//-------------------------------------------------------------
// Branch
//-------------------------------------------------------------
assign br_o = (br_i == 1'b1 && zero == zero_en_i);
assign pc_o = pc_i + offset_i;

endmodule