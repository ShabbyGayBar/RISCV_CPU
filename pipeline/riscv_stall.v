`include "riscv_define.v"

module riscv_stall(
	input				rst,
	input				inst_busy_i,
	input				data_busy_i,
	input				rs_re_id_i,
	input		[`RegAddrBus]	rs1_idx_id_i,
	input		[`RegAddrBus]	rs2_idx_id_i,
	input				is_load_ex_i,
	input		[`RegAddrBus]	rd_idx_ex_i,
	input				br_i,
	output	reg	[4:0]		stall
);

wire	is_data_hazard;

assign	is_data_hazard = rs_re_id_i && is_load_ex_i && (rs1_idx_id_i == rd_idx_ex_i || rs2_idx_id_i == rd_idx_ex_i);

// stall[0] IF
// stall[1] ID
// stall[2] EX
// stall[3] MEM
// stall[4] WB

always @ (*) begin
	if (rst) begin
		stall = 5'b00000;
	end else if (data_busy_i) begin
		stall = 5'b01111;
	end else if (is_data_hazard) begin
		stall = 5'b00011;
	end else if (br_i) begin
		stall = 5'b00010;
	end else if (inst_busy_i) begin
		stall = 5'b00001;
	end else begin
		stall = 5'b00000;
	end
end

endmodule