`include "riscv_define.v"

module riscv_alu(
	input	[`AluOpBus]	alu_op_i,
	input	[`RegBus]	alu_a_i,
	input	[`RegBus]	alu_b_i,

	output			zero_o,
	output	[`RegBus]	alu_p_o
);

reg	[`RegBus]	result_r;

reg	[31:16]		shift_right_fill_r;
reg	[`RegBus]	shift_right_1_r;
reg	[`RegBus]	shift_right_2_r;
reg	[`RegBus]	shift_right_4_r;
reg	[`RegBus]	shift_right_8_r;

reg	[`RegBus]	shift_left_1_r;
reg	[`RegBus]	shift_left_2_r;
reg	[`RegBus]	shift_left_4_r;
reg	[`RegBus]	shift_left_8_r;

wire	[`RegBus]	sub_res_w = alu_a_i - alu_b_i;

always @ (*) begin
	shift_right_fill_r = 16'b0;
	shift_right_1_r = 32'b0;
	shift_right_2_r = 32'b0;
	shift_right_4_r = 32'b0;
	shift_right_8_r = 32'b0;

	shift_left_1_r = 32'b0;
	shift_left_2_r = 32'b0;
	shift_left_4_r = 32'b0;
	shift_left_8_r = 32'b0;

	case (alu_op_i)
	// Shift Left
	`ALU_SLL : begin
		if (alu_b_i[0] == 1'b1)
			shift_left_1_r = {alu_a_i[30:0],1'b0};
		else
			shift_left_1_r = alu_a_i;

		if (alu_b_i[1] == 1'b1)
			shift_left_2_r = {shift_left_1_r[29:0],2'b00};
		else
			shift_left_2_r = shift_left_1_r;

		if (alu_b_i[2] == 1'b1)
			shift_left_4_r = {shift_left_2_r[27:0],4'b0000};
		else
			shift_left_4_r = shift_left_2_r;

		if (alu_b_i[3] == 1'b1)
			shift_left_8_r = {shift_left_4_r[23:0],8'b00000000};
		else
			shift_left_8_r = shift_left_4_r;

		if (alu_b_i[4] == 1'b1)
			result_r = {shift_left_8_r[15:0],16'b0000000000000000};
		else
			result_r = shift_left_8_r;
	end
	// Shift Right
	`ALU_SRL, `ALU_SRA: begin
		// Arithmetic shift? Fill with 1's if MSB set
		if (alu_a_i[31] == 1'b1 && alu_op_i == `ALU_SRA)
			shift_right_fill_r = 16'b1111111111111111;
		else
			shift_right_fill_r = 16'b0000000000000000;

		if (alu_b_i[0] == 1'b1)
			shift_right_1_r = {shift_right_fill_r[31], alu_a_i[31:1]};
		else
			shift_right_1_r = alu_a_i;

		if (alu_b_i[1] == 1'b1)
			shift_right_2_r = {shift_right_fill_r[31:30], shift_right_1_r[31:2]};
		else
			shift_right_2_r = shift_right_1_r;

		if (alu_b_i[2] == 1'b1)
			shift_right_4_r = {shift_right_fill_r[31:28], shift_right_2_r[31:4]};
		else
			shift_right_4_r = shift_right_2_r;

		if (alu_b_i[3] == 1'b1)
			shift_right_8_r = {shift_right_fill_r[31:24], shift_right_4_r[31:8]};
		else
			shift_right_8_r = shift_right_4_r;

		if (alu_b_i[4] == 1'b1)
			result_r = {shift_right_fill_r[31:16], shift_right_8_r[31:16]};
		else
			result_r = shift_right_8_r;
	end
	// Arithmetic
	`ALU_ADD : begin
		result_r	= (alu_a_i + alu_b_i);
	end
	`ALU_SUB : begin
		result_r	= sub_res_w;
	end
	// Logical
	`ALU_AND : begin
		result_r	= (alu_a_i & alu_b_i);
	end
	`ALU_OR  : begin
		result_r	= (alu_a_i | alu_b_i);
	end
	`ALU_XOR : begin
		result_r	= (alu_a_i ^ alu_b_i);
	end
	// Comparision
	`ALU_SLTU : begin
		result_r	  = (alu_a_i < alu_b_i) ? 32'h1 : 32'h0;
	end
	`ALU_SLT  : begin
		if (alu_a_i[31] != alu_b_i[31])
			result_r  = alu_a_i[31] ? 32'h1 : 32'h0;
		else
			result_r  = sub_res_w[31] ? 32'h1 : 32'h0;		
	end
	default  : begin
		result_r	  = alu_a_i;
	end
	endcase
end

assign alu_p_o	= result_r;
assign zero_o	= (result_r == 32'h0);

endmodule
