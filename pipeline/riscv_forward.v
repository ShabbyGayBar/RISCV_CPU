`include "riscv_define.v"

module riscv_forward(
	input				rd_we_ex_i,
	input		[`RegAddrBus]	rd_idx_ex_i,
	input		[`RegBus]	rd_val_ex_i,
	input				rd_we_mem_i,
	input		[`RegAddrBus]	rd_idx_mem_i,
	input				data_re_mem_i,
	input		[`RegBus]	data_addr_mem_i,
	input		[`RegBus]	data_mem_i,
	input				rd_we_wb_i,
	input		[`RegAddrBus]	rd_idx_wb_i,
	input		[`RegBus]	rd_val_wb_i,
	input		[`RegAddrBus]	rs1_idx_id_i,
	input		[`RegBus]	rs1_val_reg_i,
	input		[`RegAddrBus]	rs2_idx_id_i,
	input		[`RegBus]	rs2_val_reg_i,
	output	reg	[`RegBus]	rs1_val_o,
	output	reg	[`RegBus]	rs2_val_o
);

wire	[`RegBus]	rd_val_mem;

assign	rd_val_mem = data_re_mem_i ? data_mem_i : data_addr_mem_i;

always @(*) begin
	rs1_val_o = rs1_val_reg_i;
	rs2_val_o = rs2_val_reg_i;
	if (rd_we_wb_i) begin		// Forward WB stage to ID stage
		if (rd_idx_wb_i == rs1_idx_id_i) begin	// Forward rs1
			rs1_val_o = rd_val_wb_i;
		end
		if (rd_idx_wb_i == rs2_idx_id_i) begin	// Forward rs2
			rs2_val_o = rd_val_wb_i;
		end
	end
	if (rd_we_mem_i) begin		// Forward MEM stage to ID stage, MEM stage has higher priority
		if (rd_idx_mem_i == rs1_idx_id_i) begin	// Forward rs1
			rs1_val_o = rd_val_mem;
		end
		if (rd_idx_mem_i == rs2_idx_id_i) begin	// Forward rs2
			rs2_val_o = rd_val_mem;
		end
	end
	if (rd_we_ex_i) begin		// Forward EX stage to ID stage, EX stage has highest priority
		if (rd_idx_ex_i == rs1_idx_id_i) begin	// Forward rs1
			rs1_val_o = rd_val_ex_i;
		end
		if (rd_idx_ex_i == rs2_idx_id_i) begin	// Forward rs2
			rs2_val_o = rd_val_ex_i;
		end
	end
end

endmodule