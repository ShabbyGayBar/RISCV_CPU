`include "riscv_define.v"

module riscv_id_ex(
	input				clk,
	input				rst,
	input		[`InstAddrBus]	pc_i,
	input		[`RegAddrBus]	rd_idx_i,
	input				rd_we_i,
	input		[`AluOpBus]	alu_op_i,
	input		[`RegBus]	alu_a_i,
	input		[`RegBus]	alu_b_i,
	input		[`RegBus]	offset_i,
	input				br_i,
	input				zero_en_i,
	input				data_we_i,
	input				data_re_i,
	output	reg	[`InstAddrBus]	pc_o,
	output	reg	[`RegAddrBus]	rd_idx_o,
	output	reg			rd_we_o,
	output	reg	[`AluOpBus]	alu_op_o,
	output	reg	[`RegBus]	alu_a_o,
	output	reg	[`RegBus]	alu_b_o,
	output	reg	[`RegBus]	offset_o,
	output	reg			br_o,
	output	reg			zero_en_o,
	output	reg			data_we_o,
	output	reg			data_re_o
);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		pc_o		<= 0;
		rd_idx_o	<= 0;
		rd_we_o		<= 0;
		alu_op_o	<= `ALU_NONE;
		alu_a_o		<= 0;
		alu_b_o		<= 0;
		offset_o	<= 0;
		br_o		<= 0;
		zero_en_o	<= 0;
		data_we_o	<= 0;
		data_re_o	<= 0;
	end else begin
		pc_o		<= pc_i;
		rd_idx_o	<= rd_idx_i;
		rd_we_o		<= rd_we_i;
		alu_op_o	<= alu_op_i;
		alu_a_o		<= alu_a_i;
		alu_b_o		<= alu_b_i;
		offset_o	<= offset_i;
		br_o		<= br_i;
		zero_en_o	<= zero_en_i;
		data_we_o	<= data_we_i;
		data_re_o	<= data_re_i;
	end
end

endmodule