`include "riscv_define.v"

module riscv_if(
	input				clk,
	input				rst,
	input		[4:0]		stall,
	input				br_i,	// Branch
	input		[`InstAddrBus]	pc_i,	// Next PC if branch
	output	reg	[`InstAddrBus]	pc_o	// Current program counter
);

// Program counter register
always @(posedge clk or posedge rst) begin
	if (rst) begin
		pc_o <= 0;
	end else if (stall[0]) begin
		// Do nothing
	end else if (br_i) begin
		pc_o <= pc_i;
	end else begin
		pc_o <= pc_o + 4;
	end
end

endmodule