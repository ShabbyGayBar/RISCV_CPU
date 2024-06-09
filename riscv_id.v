`include "riscv_define.v"

module riscv_id(
	input		[`InstAddrBus]	pc_i,
	input		[`InstBus]	inst_i,
	input		[`RegBus]	rs1_val_i,
	input		[`RegBus]	rs2_val_i,
	output		[`RegAddrBus]	rs1_idx_o,
	output		[`RegAddrBus]	rs2_idx_o,
	output		[`RegAddrBus]	rd_idx_o,
	output	reg			rd_we_o,
	output	reg	[`AluOpBus]	alu_op_o,
	output	reg	[`RegBus]	alu_a_o,
	output	reg	[`RegBus]	alu_b_o,
	output	reg	[`RegBus]	offset_o,
	output	reg			br_o,
	output	reg			zero_en_o,
	output	reg			data_we_o,
	output	reg			data_re_o
);

//-------------------------------------------------------------
// Immediate Generation
//-------------------------------------------------------------
wire	[`RegBus]	I_imm;
wire	[`RegBus]	S_imm;
wire	[`RegBus]	B_imm;
wire	[`RegBus]	J_imm;
wire	[`RegBus]	U_imm;

assign	I_imm	= {{20{inst_i[31]}}, inst_i[31:20]};
assign	S_imm	= {{19{inst_i[31]}}, inst_i[31:25], inst_i[11:7], 1'b0};
assign	B_imm	= {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
assign	J_imm	= {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:21], 1'b0};
assign	U_imm	= {inst_i[31:12], 12'b0};

//-------------------------------------------------------------
// Decode instruction
//-------------------------------------------------------------
assign	rs1_idx_o	= inst_i[19:15];
assign	rs2_idx_o	= inst_i[24:20];
assign	rd_idx_o	= inst_i[11:7];

always @(*) begin
	alu_op_o	= `ALU_NONE;
	alu_a_o		= rs1_val_i;
	alu_b_o		= rs2_val_i;
	offset_o	= 32'b0;
	data_we_o	= 1'b0;
	data_re_o	= 1'b0;
	rd_we_o		= 1'b1;
	br_o		= 1'b0;
	zero_en_o	= 1'b1;

	if ((inst_i & `INST_ADD_MASK) == `INST_ADD) begin // add
		alu_op_o	= `ALU_ADD;
	end else if ((inst_i & `INST_SUB_MASK) == `INST_SUB) begin // sub
		alu_op_o	= `ALU_SUB;
	end else if ((inst_i & `INST_XOR_MASK) == `INST_XOR) begin // xor
		alu_op_o	= `ALU_XOR;
	end else if ((inst_i & `INST_OR_MASK) == `INST_OR) begin // or
		alu_op_o	= `ALU_OR;
	end else if ((inst_i & `INST_AND_MASK) == `INST_AND) begin // and
		alu_op_o	= `ALU_AND;
	end else if ((inst_i & `INST_SLL_MASK) == `INST_SLL) begin // sll
		alu_op_o	= `ALU_SLL;
	end else if ((inst_i & `INST_SRL_MASK) == `INST_SRL) begin // srl
		alu_op_o	= `ALU_SRL;
	end else if ((inst_i & `INST_SRA_MASK) == `INST_SRA) begin // sra
		alu_op_o	= `ALU_SRA;
	end else if ((inst_i & `INST_SLT_MASK) == `INST_SLT) begin // slt
		alu_op_o	= `ALU_SLT;
	end else if ((inst_i & `INST_SLTU_MASK) == `INST_SLTU) begin // sltu
		alu_op_o	= `ALU_SLTU;
	end else if ((inst_i & `INST_ADDI_MASK) == `INST_ADDI) begin // addi
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_XORI_MASK) == `INST_XORI) begin // xori
		alu_op_o	= `ALU_XOR;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_ORI_MASK) == `INST_ORI) begin // ori
		alu_op_o	= `ALU_OR;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_ANDI_MASK) == `INST_ANDI) begin // andi
		alu_op_o	= `ALU_AND;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_SLLI_MASK) == `INST_SLLI) begin // slli
		alu_op_o	= `ALU_SLL;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_SRLI_MASK) == `INST_SRLI) begin // srli
		alu_op_o	= `ALU_SRL;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_SRAI_MASK) == `INST_SRAI) begin // srai
		alu_op_o	= `ALU_SRA;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_SLTI_MASK) == `INST_SLTI) begin // slti
		alu_op_o	= `ALU_SLT;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_SLTIU_MASK) == `INST_SLTIU) begin // sltiu
		alu_op_o	= `ALU_SLTU;
		alu_b_o		= I_imm;
	end else if ((inst_i & `INST_LB_MASK) == `INST_LB) begin // lb
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
		data_re_o	= 1'b1;
	end else if ((inst_i & `INST_LH_MASK) == `INST_LH) begin // lh
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
		data_re_o	= 1'b1;
	end else if ((inst_i & `INST_LW_MASK) == `INST_LW) begin // lw
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
		data_re_o	= 1'b1;
	end else if ((inst_i & `INST_LBU_MASK) == `INST_LBU) begin // lbu
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
		data_re_o	= 1'b1;
	end else if ((inst_i & `INST_LHU_MASK) == `INST_LHU) begin // lhu
		alu_op_o	= `ALU_ADD;
		alu_b_o		= I_imm;
		data_re_o	= 1'b1;
	end else if ((inst_i & `INST_SB_MASK) == `INST_SB) begin // sb
		alu_op_o	= `ALU_ADD;
		alu_b_o		= S_imm;
		data_we_o	= 1'b1;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_SH_MASK) == `INST_SH) begin // sh
		alu_op_o	= `ALU_ADD;
		alu_b_o		= S_imm;
		data_we_o	= 1'b1;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_SW_MASK) == `INST_SW) begin // sw
		alu_op_o	= `ALU_ADD;
		alu_b_o		= S_imm;
		data_we_o	= 1'b1;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_BEQ_MASK) == `INST_BEQ) begin // beq
		alu_op_o	= `ALU_SUB;
		offset_o	= B_imm;
		br_o		= 1'b1;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_BNE_MASK) == `INST_BNE) begin // bne
		alu_op_o	= `ALU_SUB;
		offset_o	= B_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_BLT_MASK) == `INST_BLT) begin // blt
		alu_op_o	= `ALU_SLT;
		offset_o	= B_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_BGE_MASK) == `INST_BGE) begin // bge
		alu_op_o	= `ALU_SLT;
		offset_o	= B_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
	end else if ((inst_i & `INST_BLTU_MASK) == `INST_BLTU) begin // bltu
		alu_op_o	= `ALU_SLTU;
		offset_o	= B_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_BGEU_MASK) == `INST_BGEU) begin // bgeu
		alu_op_o	= `ALU_SLTU;
		offset_o	= B_imm;
		br_o		= 1'b1;
		rd_we_o		= 1'b0;
	end else if ((inst_i & `INST_JAL_MASK) == `INST_JAL) begin // jal
		alu_op_o	= `ALU_ADD;
		alu_a_o		= pc_i;
		alu_b_o		= 4;
		offset_o	= J_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
	end /*else if ((inst_i & `INST_JALR_MASK) == `INST_JALR) begin // jalr
		alu_op_o	= `ALU_ADD;
		alu_a_o		= pc_i;
		alu_b_o		= 4;
		offset_o	= I_imm;
		br_o		= 1'b1;
		zero_en_o	= 1'b0;
	end*/ else if ((inst_i & `INST_LUI_MASK) == `INST_LUI) begin // lui
		alu_op_o	= `ALU_ADD;
		alu_b_o		= U_imm;
	end else if ((inst_i & `INST_AUIPC_MASK) == `INST_AUIPC) begin // auipc
		alu_op_o	= `ALU_ADD;
		alu_a_o		= pc_i;
		alu_b_o		= U_imm;
	end
end

endmodule