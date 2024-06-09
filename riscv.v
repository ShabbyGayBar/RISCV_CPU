`include "riscv_define.v"
`include "riscv_if.v"
`include "riscv_id.v"
`include "riscv_ex.v"
`include "riscv_wb.v"
`include "riscv_register.v"

module riscv(
	input	wire		clk,
	input	wire		rst,		// high is reset

	// inst_mem
	input	wire	[31:0]	inst_i,		// instruction from inst_mem
	output	wire	[31:0]	inst_addr_o,	// address to inst_mem, or program counter
	output	wire		inst_ce_o,	// enable to inst_mem

	// data_mem
	input	wire	[31:0]	data_i,		// load data from data_mem
	output	wire		data_we_o,	// write enable to data_mem
	output	wire		data_ce_o,	// enable to data_mem
	output	wire	[31:0]	data_addr_o,	// address to data_mem
	output	wire	[31:0]	data_o		// data to data_mem
);

wire			br;		// branch signal
wire	[`InstAddrBus]	pc_next;	// next value of program counter
wire	[`RegBus]	rs1_val;	// register 1 value
wire	[`RegBus]	rs2_val;	// register 2 value
wire	[`RegAddrBus]	rs1_idx;	// register 1 index
wire	[`RegAddrBus]	rs2_idx;	// register 2 index
wire	[`RegAddrBus]	rd_idx;		// write register index
wire	[`RegBus]	rd_val;		// write register value
wire			rd_we;		// write register enable
wire	[`AluOpBus]	alu_op;		// ALU operation code
wire	[`RegBus]	alu_a;		// ALU input A
wire	[`RegBus]	alu_b;		// ALU input B
wire	[`RegBus]	offset;		// immediate value
wire			zero_en;	// jump if zero enable
wire			data_re;	// read data from data memory

assign	inst_ce_o = 1;			// always read instruction memory
assign	data_ce_o = 1;			// always enable data memory

//--------------------------------------------------------------------
// Instruction Fetch Unit
//--------------------------------------------------------------------
riscv_if IF(
	.clk(clk),
	.rst(rst),
	.br_i(br),
	.pc_i(pc_next),
	.pc_o(inst_addr_o)
);

//--------------------------------------------------------------------
// Instruction Decode Unit
//--------------------------------------------------------------------
riscv_id ID(
	.pc_i(inst_addr_o),
	.inst_i(inst_i),
	.rs1_val_i(rs1_val),
	.rs2_val_i(data_o),
	.rs1_idx_o(rs1_idx),
	.rs2_idx_o(rs2_idx),
	.rd_idx_o(rd_idx),
	.rd_we_o(rd_we),
	.alu_op_o(alu_op),
	.alu_a_o(alu_a),
	.alu_b_o(alu_b),
	.offset_o(offset),
	.br_o(br),
	.zero_en_o(zero_en),
	.data_we_o(data_we_o),
	.data_re_o(data_re)
);

//--------------------------------------------------------------------
// Register File
//--------------------------------------------------------------------
riscv_register REG(
	.clk(clk),
	.rst(rst),
	.rs1_idx_i(rs1_idx),
	.rs2_idx_i(rs2_idx),
	.rd_idx_i(rd_idx),
	.rd_we_i(rd_we),
	.rd_val_i(rd_val),
	.rs1_val_o(rs1_val),
	.rs2_val_o(data_o)
);

//--------------------------------------------------------------------
// Execute Unit
//--------------------------------------------------------------------
riscv_ex EX(
	.pc_i(inst_addr_o),
	.alu_op_i(alu_op),
	.alu_a_i(alu_a),
	.alu_b_i(alu_b),
	.offset_i(offset),
	.br_i(br),
	.zero_en_i(zero_en),
	.pc_o(pc_next),
	.data_addr_o(data_addr_o)
);

//--------------------------------------------------------------------
// Write Back Unit
//--------------------------------------------------------------------
riscv_wb WB(
	.data_i(data_i),
	.data_addr_i(data_addr_o),
	.data_we_i(data_we_o),
	.data_re_i(data_re),
	.rd_val_o(rd_val)
);

endmodule