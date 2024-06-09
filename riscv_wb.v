`include "riscv_define.v"

module riscv_wb(
	input		[`MemDataBus]	data_i,
	input		[`RegBus]	data_addr_i,
	input				data_we_i,
	input				data_re_i,
	output	reg	[`RegBus]	rd_val_o
);

//-------------------------------------------------------------
// Mux
//-------------------------------------------------------------
always @(*) begin
	if (data_re_i == 1'b1) begin
		rd_val_o = data_i;
	end else begin
		rd_val_o = data_addr_i;
	end
end

endmodule