`include "riscv_define.v"
`include "riscv_if.v"
`include "riscv_id.v"
`include "riscv_ex.v"
`include "riscv_wb.v"
`include "riscv_register.v"
`include "riscv_id_ex.v"
`include "riscv_ex_mem.v"
`include "riscv_mem_wb.v"
`include "riscv_stall.v"

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

wire	[4:0]		stall;		// stall control
wire			br_o_id;	// branch signal
wire			br_i_ex;
wire			br_o_ex;
wire	[`InstAddrBus]	pc_i_ex;	// program counter
wire	[`InstAddrBus]	pc_next;
wire	[`RegBus]	rs1_val_id;	// register 1 value
wire	[`RegBus]	rs2_val_id;	// register 2 value
wire	[`RegAddrBus]	rs1_idx_id;	// register 1 index
wire	[`RegAddrBus]	rs2_idx_id;	// register 2 index
wire			rs_re_id;	// register read enable
wire	[`RegAddrBus]	rd_idx_o_id;	// write register index
wire	[`RegAddrBus]	rd_idx_ex;
wire	[`RegAddrBus]	rd_idx_mem;
wire	[`RegAddrBus]	rd_idx_wb;
wire	[`RegBus]	rd_val_wb;	// write register value
wire			rd_we_o_id;	// write register enable
wire			rd_we_ex;
wire			rd_we_mem;
wire			rd_we_wb;
wire	[`AluOpBus]	alu_op_o_id;	// ALU operation code
wire	[`AluOpBus]	alu_op_i_ex;
wire	[`RegBus]	alu_a_o_id;	// ALU input A
wire	[`RegBus]	alu_a_i_ex;
wire	[`RegBus]	alu_b_o_id;	// ALU input B
wire	[`RegBus]	alu_b_i_ex;
wire	[`RegBus]	offset_o_id;	// immediate value
wire	[`RegBus]	offset_i_ex;
wire			zero_en_o_id;	// jump if zero enable
wire			zero_en_i_ex;
wire	[`MemDataBus]	data_o_id;	// data to data memory
wire	[`MemDataBus]	data_ex;
wire			data_we_o_id;	// write enable to data memory
wire			data_we_ex;
wire			data_re_o_id;	// read data from data memory
wire			data_re_ex;
wire			data_re_mem;
wire	[`MemAddrBus]	data_addr_o_ex;	// address to data memory
wire	[`MemAddrBus]	data_addr_i_wb;	// address to data memory
wire			data_we_i_wb;	// write enable to data memory
wire			data_re_i_wb;	// write register enable

assign	inst_ce_o = 1;			// always read instruction memory
assign	data_ce_o = 1;			// always enable data memory

//--------------------------------------------------------------------
// Stall control
//--------------------------------------------------------------------
riscv_stall STALL(
	.rst(rst),
	.req_if(1'b0),		// stall if branch instruction
	.req_id(rs_re_id && data_re_ex && (rs1_idx_id == rd_idx_ex || rs2_idx_id == rd_idx_ex)),
	// stall if register read && last instruction is load type && load data is not ready
	.req_ex(br_o_ex),
	.req_mem(1'b0),		// stall if load type instruction
	.stall(stall)
);

//--------------------------------------------------------------------
// Instruction Fetch Unit
//--------------------------------------------------------------------
riscv_if IF(
	.clk(clk),
	.rst(rst),
	.stall(stall),
	.br_i(br_o_ex),
	.pc_i(pc_next),
	.pc_o(inst_addr_o)
);

// Stage IF already incoporated register IF-ID

//--------------------------------------------------------------------
// Instruction Decode Unit
//--------------------------------------------------------------------
riscv_id ID(
	.pc_i(inst_addr_o),
	.inst_i(inst_i),
	.rs1_val_i(rs1_val_id),
	.rs2_val_i(rs2_val_id),
	.rs1_idx_o(rs1_idx_id),
	.rs2_idx_o(rs2_idx_id),
	.rs_re_o(rs_re_id),
	.rd_idx_o(rd_idx_o_id),
	.rd_we_o(rd_we_o_id),
	.alu_op_o(alu_op_o_id),
	.alu_a_o(alu_a_o_id),
	.alu_b_o(alu_b_o_id),
	.offset_o(offset_o_id),
	.br_o(br_o_id),
	.zero_en_o(zero_en_o_id),
	.data_o(data_o_id),
	.data_we_o(data_we_o_id),
	.data_re_o(data_re_o_id)
);

//--------------------------------------------------------------------
// Register File
//--------------------------------------------------------------------
riscv_register REG(
	.clk(clk),
	.rst(rst),
	.rs1_idx_i(rs1_idx_id),
	.rs2_idx_i(rs2_idx_id),
	.rd_idx_i(rd_idx_wb),
	.rd_we_i(rd_we_wb),
	.rd_val_i(rd_val_wb),
	.rs1_val_o(rs1_val_id),
	.rs2_val_o(rs2_val_id)
);

//--------------------------------------------------------------------
// ID-EX Register
//--------------------------------------------------------------------
riscv_id_ex ID_EX(
	.clk(clk),
	.rst(rst),
	.stall(stall),
	.pc_i(inst_addr_o),
	.rd_idx_i(rd_idx_o_id),
	.rd_we_i(rd_we_o_id),
	.alu_op_i(alu_op_o_id),
	.alu_a_i(alu_a_o_id),
	.alu_b_i(alu_b_o_id),
	.offset_i(offset_o_id),
	.br_i(br_o_id),
	.zero_en_i(zero_en_o_id),
	.data_i(data_o_id),
	.data_we_i(data_we_o_id),
	.data_re_i(data_re_o_id),
	.pc_o(pc_i_ex),
	.rd_idx_o(rd_idx_ex),
	.rd_we_o(rd_we_ex),
	.alu_op_o(alu_op_i_ex),
	.alu_a_o(alu_a_i_ex),
	.alu_b_o(alu_b_i_ex),
	.offset_o(offset_i_ex),
	.br_o(br_i_ex),
	.zero_en_o(zero_en_i_ex),
	.data_o(data_ex),
	.data_we_o(data_we_ex),
	.data_re_o(data_re_ex)
);

//--------------------------------------------------------------------
// Execute Unit
//--------------------------------------------------------------------
riscv_ex EX(
	.pc_i(pc_i_ex),
	.alu_op_i(alu_op_i_ex),
	.alu_a_i(alu_a_i_ex),
	.alu_b_i(alu_b_i_ex),
	.offset_i(offset_i_ex),
	.br_i(br_i_ex),
	.zero_en_i(zero_en_i_ex),
	.br_o(br_o_ex),
	.pc_o(pc_next),
	.data_addr_o(data_addr_o_ex)
);

//--------------------------------------------------------------------
// EX-MEM Register
//--------------------------------------------------------------------
riscv_ex_mem EX_MEM(
	.clk(clk),
	.rst(rst),
	.stall(stall),
	.rd_idx_i(rd_idx_ex),
	.rd_we_i(rd_we_ex),
	.data_i(data_ex),
	.data_we_i(data_we_ex),
	.data_re_i(data_re_ex),
	.data_addr_i(data_addr_o_ex),
	.rd_idx_o(rd_idx_mem),
	.rd_we_o(rd_we_mem),
	.data_o(data_o),
	.data_we_o(data_we_o),
	.data_re_o(data_re_mem),
	.data_addr_o(data_addr_o)
);

//--------------------------------------------------------------------
// MEM-WB Register
//--------------------------------------------------------------------
riscv_mem_wb MEM_WB(
	.clk(clk),
	.rst(rst),
	.stall(stall),
	.rd_idx_i(rd_idx_mem),
	.rd_we_i(rd_we_mem),
	.data_addr_i(data_addr_o),
	.data_we_i(data_we_o),
	.data_re_i(data_re_mem),
	.rd_idx_o(rd_idx_wb),
	.rd_we_o(rd_we_wb),
	.data_addr_o(data_addr_i_wb),
	.data_re_o(data_re_i_wb)
);

//--------------------------------------------------------------------
// Write Back Unit
//--------------------------------------------------------------------
riscv_wb WB(
	.data_i(data_i),
	.data_addr_i(data_addr_i_wb),
	.data_re_i(data_re_i_wb),
	.rd_val_o(rd_val_wb)
);

endmodule