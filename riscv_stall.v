`include "riscv_define.v"

module riscv_stall(
	input			rst,
	input			req_if,
	input			req_id,
	input			req_ex,
	input			req_mem,
	output	reg	[4:0]	stall
);

// stall[0] IF
// stall[1] ID
// stall[2] EX
// stall[3] MEM
// stall[4] WB

always @ (*) begin
	if (rst) begin
		stall = 5'b00000;
	end else if (req_mem) begin
		stall = 5'b01111;
	end else if (req_ex) begin
		stall = 5'b00010;
	end else if (req_id) begin
		stall = 5'b00011;
	end else if (req_if) begin
		stall = 5'b00001;
	end else begin
		stall = 5'b00000;
	end
end

endmodule