`include "riscv_define.v"

module riscv_ex_mem(
	input				clk,
	input				rst,
	input		[`RegAddrBus]	rd_idx_i,
	input				rd_we_i,
	input				data_we_i,
	input				data_re_i,
	input		[`MemAddrBus]	data_addr_i,
	output	reg	[`RegAddrBus]	rd_idx_o,
	output	reg			rd_we_o,
	output	reg			data_we_o,
	output	reg			data_re_o,
	output	reg	[`MemAddrBus]	data_addr_o
);

always @(posedge clk or posedge rst) begin
	if (rst) begin
		rd_idx_o <= 0;
		rd_we_o <= 0;
		data_we_o <= 0;
		data_re_o <= 0;
		data_addr_o <= 0;
	end else begin
		rd_idx_o <= rd_idx_i;
		rd_we_o <= rd_we_i;
		data_we_o <= data_we_i;
		data_re_o <= data_re_i;
		data_addr_o <= data_addr_i;
	end
end

endmodule