`include "riscv_define.v"

module riscv_register(
	input				clk,
	input				rst,
	input		[`RegAddrBus]	rs1_idx_i,
	input		[`RegAddrBus]	rs2_idx_i,
	input		[`RegAddrBus]	rd_idx_i,
	input				rd_we_i,
	input		[`RegBus]	rd_val_i,
	output	reg	[`RegBus]	rs1_val_o,
	output	reg	[`RegBus]	rs2_val_o
);

reg	[`RegBus]	x0;
reg	[`RegBus]	x1;
reg	[`RegBus]	x2;
reg	[`RegBus]	x3;
reg	[`RegBus]	x4;
reg	[`RegBus]	x5;
reg	[`RegBus]	x6;
reg	[`RegBus]	x7;
reg	[`RegBus]	x8;
reg	[`RegBus]	x9;
reg	[`RegBus]	x10;
reg	[`RegBus]	x11;
reg	[`RegBus]	x12;
reg	[`RegBus]	x13;
reg	[`RegBus]	x14;
reg	[`RegBus]	x15;
reg	[`RegBus]	x16;
reg	[`RegBus]	x17;
reg	[`RegBus]	x18;
reg	[`RegBus]	x19;
reg	[`RegBus]	x20;
reg	[`RegBus]	x21;
reg	[`RegBus]	x22;
reg	[`RegBus]	x23;
reg	[`RegBus]	x24;
reg	[`RegBus]	x25;
reg	[`RegBus]	x26;
reg	[`RegBus]	x27;
reg	[`RegBus]	x28;
reg	[`RegBus]	x29;
reg	[`RegBus]	x30;
reg	[`RegBus]	x31;

// write register
always @(posedge clk or posedge rst) begin
	if (rst) begin
		x0 <= 0;
		x1 <= 0;
		x2 <= 0;
		x3 <= 0;
		x4 <= 0;
		x5 <= 0;
		x6 <= 0;
		x7 <= 0;
		x8 <= 0;
		x9 <= 0;
		x10 <= 0;
		x11 <= 0;
		x12 <= 0;
		x13 <= 0;
		x14 <= 0;
		x15 <= 0;
		x16 <= 0;
		x17 <= 0;
		x18 <= 0;
		x19 <= 0;
		x20 <= 0;
		x21 <= 0;
		x22 <= 0;
		x23 <= 0;
		x24 <= 0;
		x25 <= 0;
		x26 <= 0;
		x27 <= 0;
		x28 <= 0;
		x29 <= 0;
		x30 <= 0;
		x31 <= 0;
	end else if (rd_we_i) begin
		case (rd_idx_i)
			1:	x1 <= rd_val_i;
			2:	x2 <= rd_val_i;
			3:	x3 <= rd_val_i;
			4:	x4 <= rd_val_i;
			5:	x5 <= rd_val_i;
			6:	x6 <= rd_val_i;
			7:	x7 <= rd_val_i;
			8:	x8 <= rd_val_i;
			9:	x9 <= rd_val_i;
			10:	x10 <= rd_val_i;
			11:	x11 <= rd_val_i;
			12:	x12 <= rd_val_i;
			13:	x13 <= rd_val_i;
			14:	x14 <= rd_val_i;
			15:	x15 <= rd_val_i;
			16:	x16 <= rd_val_i;
			17:	x17 <= rd_val_i;
			18:	x18 <= rd_val_i;
			19:	x19 <= rd_val_i;
			20:	x20 <= rd_val_i;
			21:	x21 <= rd_val_i;
			22:	x22 <= rd_val_i;
			23:	x23 <= rd_val_i;
			24:	x24 <= rd_val_i;
			25:	x25 <= rd_val_i;
			26:	x26 <= rd_val_i;
			27:	x27 <= rd_val_i;
			28:	x28 <= rd_val_i;
			29:	x29 <= rd_val_i;
			30:	x30 <= rd_val_i;
			31:	x31 <= rd_val_i;
		endcase
	end
end

// read register
always @(*) begin
	case (rs1_idx_i)
		1:	rs1_val_o = x1;
		2:	rs1_val_o = x2;
		3:	rs1_val_o = x3;
		4:	rs1_val_o = x4;
		5:	rs1_val_o = x5;
		6:	rs1_val_o = x6;
		7:	rs1_val_o = x7;
		8:	rs1_val_o = x8;
		9:	rs1_val_o = x9;
		10:	rs1_val_o = x10;
		11:	rs1_val_o = x11;
		12:	rs1_val_o = x12;
		13:	rs1_val_o = x13;
		14:	rs1_val_o = x14;
		15:	rs1_val_o = x15;
		16:	rs1_val_o = x16;
		17:	rs1_val_o = x17;
		18:	rs1_val_o = x18;
		19:	rs1_val_o = x19;
		20:	rs1_val_o = x20;
		21:	rs1_val_o = x21;
		22:	rs1_val_o = x22;
		23:	rs1_val_o = x23;
		24:	rs1_val_o = x24;
		25:	rs1_val_o = x25;
		26:	rs1_val_o = x26;
		27:	rs1_val_o = x27;
		28:	rs1_val_o = x28;
		29:	rs1_val_o = x29;
		30:	rs1_val_o = x30;
		31:	rs1_val_o = x31;
		default: rs1_val_o = 0;
	endcase
	case (rs2_idx_i)
		1:	rs2_val_o = x1;
		2:	rs2_val_o = x2;
		3:	rs2_val_o = x3;
		4:	rs2_val_o = x4;
		5:	rs2_val_o = x5;
		6:	rs2_val_o = x6;
		7:	rs2_val_o = x7;
		8:	rs2_val_o = x8;
		9:	rs2_val_o = x9;
		10:	rs2_val_o = x10;
		11:	rs2_val_o = x11;
		12:	rs2_val_o = x12;
		13:	rs2_val_o = x13;
		14:	rs2_val_o = x14;
		15:	rs2_val_o = x15;
		16:	rs2_val_o = x16;
		17:	rs2_val_o = x17;
		18:	rs2_val_o = x18;
		19:	rs2_val_o = x19;
		20:	rs2_val_o = x20;
		21:	rs2_val_o = x21;
		22:	rs2_val_o = x22;
		23:	rs2_val_o = x23;
		24:	rs2_val_o = x24;
		25:	rs2_val_o = x25;
		26:	rs2_val_o = x26;
		27:	rs2_val_o = x27;
		28:	rs2_val_o = x28;
		29:	rs2_val_o = x29;
		30:	rs2_val_o = x30;
		31:	rs2_val_o = x31;
		default: rs2_val_o = 0;
	endcase
end

endmodule