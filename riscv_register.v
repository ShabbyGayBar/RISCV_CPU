`include "riscv_define.v"

module riscv_register(
	input			clk,
	input			rst,
	input	[`RegAddrBus]	rs1_idx_i,
	input	[`RegAddrBus]	rs2_idx_i,
	input	[`RegAddrBus]	rd_idx_i,
	input			rd_we_i,
	input	[`RegBus]	rd_val_i,
	output	[`RegBus]	rs1_val_o,
	output	[`RegBus]	rs2_val_o
);

reg	[`RegBus]	register [31:0];

// write register
always @(posedge clk or posedge rst) begin
	if (rst) begin
		register[0] <= 32'b0;
		register[1] <= 32'b0;
		register[2] <= 32'b0;
		register[3] <= 32'b0;
		register[4] <= 32'b0;
		register[5] <= 32'b0;
		register[6] <= 32'b0;
		register[7] <= 32'b0;
		register[8] <= 32'b0;
		register[9] <= 32'b0;
		register[10] <= 32'b0;
		register[11] <= 32'b0;
		register[12] <= 32'b0;
		register[13] <= 32'b0;
		register[14] <= 32'b0;
		register[15] <= 32'b0;
		register[16] <= 32'b0;
		register[17] <= 32'b0;
		register[18] <= 32'b0;
		register[19] <= 32'b0;
		register[20] <= 32'b0;
		register[21] <= 32'b0;
		register[22] <= 32'b0;
		register[23] <= 32'b0;
		register[24] <= 32'b0;
		register[25] <= 32'b0;
		register[26] <= 32'b0;
		register[27] <= 32'b0;
		register[28] <= 32'b0;
		register[29] <= 32'b0;
		register[30] <= 32'b0;
		register[31] <= 32'b0;
	end else if (rd_we_i) begin
		register[rd_idx_i] <= rd_val_i;
	end
end

// read register
assign	rs1_val_o = register[rs1_idx_i];
assign	rs2_val_o = register[rs2_idx_i];

endmodule