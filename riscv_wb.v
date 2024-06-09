`include "riscv_define.v"

module riscv_wb(
	input		[`MemDataBus]	data_i,
	input		[`RegBus]	data_addr_i,
	input				data_we_i,
	input				mem2reg_i,
	output	reg	[`RegBus]	rd_val_o
);

//-------------------------------------------------------------
// Mux
//-------------------------------------------------------------
always @(*) begin
	if (mem2reg_i == 1'b1) begin
		rd_val_o = data_i;
	end else begin
		rd_val_o = data_addr_i;
	end
end

endmodule