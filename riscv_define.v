`ifndef DEFINES_V
`define DEFINES_V

//--------------------------------------------------------------------
// ALU Operations
//--------------------------------------------------------------------
`define		ALU_NONE	4'b0000
`define		ALU_SLL		4'b0001
`define		ALU_SRL		4'b0010
`define		ALU_SRA		4'b0011
`define		ALU_ADD		4'b0100
`define		ALU_SUB		4'b0110
`define		ALU_AND		4'b0111
`define		ALU_OR		4'b1000
`define		ALU_XOR		4'b1001
`define		ALU_SLTU	4'b1010
`define		ALU_SLT		4'b1011

//--------------------------------------------------------------------
// Instructions Masks
//--------------------------------------------------------------------
// andi
`define		INST_ANDI 32'h7013
`define		INST_ANDI_MASK 32'h707f

// addi
`define		INST_ADDI 32'h13
`define		INST_ADDI_MASK 32'h707f

// slti
`define		INST_SLTI 32'h2013
`define		INST_SLTI_MASK 32'h707f

// sltiu
`define		INST_SLTIU 32'h3013
`define		INST_SLTIU_MASK 32'h707f

// ori
`define		INST_ORI 32'h6013
`define		INST_ORI_MASK 32'h707f

// xori
`define		INST_XORI 32'h4013
`define		INST_XORI_MASK 32'h707f

// slli
`define		INST_SLLI 32'h1013
`define		INST_SLLI_MASK 32'hfc00707f

// srli
`define		INST_SRLI 32'h5013
`define		INST_SRLI_MASK 32'hfc00707f

// srai
`define		INST_SRAI 32'h40005013
`define		INST_SRAI_MASK 32'hfc00707f

// lui
`define		INST_LUI 32'h37
`define		INST_LUI_MASK 32'h7f

// auipc
`define		INST_AUIPC 32'h17
`define		INST_AUIPC_MASK 32'h7f

// add
`define		INST_ADD 32'h33
`define		INST_ADD_MASK 32'hfe00707f

// sub
`define		INST_SUB 32'h40000033
`define		INST_SUB_MASK 32'hfe00707f

// slt
`define		INST_SLT 32'h2033
`define		INST_SLT_MASK 32'hfe00707f

// sltu
`define		INST_SLTU 32'h3033
`define		INST_SLTU_MASK 32'hfe00707f

// xor
`define		INST_XOR 32'h4033
`define		INST_XOR_MASK 32'hfe00707f

// or
`define		INST_OR 32'h6033
`define		INST_OR_MASK 32'hfe00707f

// and
`define		INST_AND 32'h7033
`define		INST_AND_MASK 32'hfe00707f

// sll
`define		INST_SLL 32'h1033
`define		INST_SLL_MASK 32'hfe00707f

// srl
`define		INST_SRL 32'h5033
`define		INST_SRL_MASK 32'hfe00707f

// sra
`define		INST_SRA 32'h40005033
`define		INST_SRA_MASK 32'hfe00707f

// jal
`define		INST_JAL 32'h6f
`define		INST_JAL_MASK 32'h7f

// jalr
`define		INST_JALR 32'h67
`define		INST_JALR_MASK 32'h707f

// beq
`define		INST_BEQ 32'h63
`define		INST_BEQ_MASK 32'h707f

// bne
`define		INST_BNE 32'h1063
`define		INST_BNE_MASK 32'h707f

// blt
`define		INST_BLT 32'h4063
`define		INST_BLT_MASK 32'h707f

// bge
`define		INST_BGE 32'h5063
`define		INST_BGE_MASK 32'h707f

// bltu
`define		INST_BLTU 32'h6063
`define		INST_BLTU_MASK 32'h707f

// bgeu
`define		INST_BGEU 32'h7063
`define		INST_BGEU_MASK 32'h707f

// lb
`define		INST_LB 32'h3
`define		INST_LB_MASK 32'h707f

// lh
`define		INST_LH 32'h1003
`define		INST_LH_MASK 32'h707f

// lw
`define		INST_LW 32'h2003
`define		INST_LW_MASK 32'h707f

// lbu
`define		INST_LBU 32'h4003
`define		INST_LBU_MASK 32'h707f

// lhu
`define		INST_LHU 32'h5003
`define		INST_LHU_MASK 32'h707f

// lwu
`define		INST_LWU 32'h6003
`define		INST_LWU_MASK 32'h707f

// sb
`define		INST_SB 32'h23
`define		INST_SB_MASK 32'h707f

// sh
`define		INST_SH 32'h1023
`define		INST_SH_MASK 32'h707f

// sw
`define		INST_SW 32'h2023
`define		INST_SW_MASK 32'h707f

// ecall
`define		INST_ECALL 32'h73
`define		INST_ECALL_MASK 32'hffffffff

// ebreak
`define		INST_EBREAK 32'h100073
`define		INST_EBREAK_MASK 32'hffffffff

// eret
`define		INST_ERET 32'h200073
`define		INST_ERET_MASK 32'hcfffffff

// csrrw
`define		INST_CSRRW 32'h1073
`define		INST_CSRRW_MASK 32'h707f

// csrrs
`define		INST_CSRRS 32'h2073
`define		INST_CSRRS_MASK 32'h707f

// csrrc
`define		INST_CSRRC 32'h3073
`define		INST_CSRRC_MASK 32'h707f

// csrrwi
`define		INST_CSRRWI 32'h5073
`define		INST_CSRRWI_MASK 32'h707f

// csrrsi
`define		INST_CSRRSI 32'h6073
`define		INST_CSRRSI_MASK 32'h707f

// csrrci
`define		INST_CSRRCI 32'h7073
`define		INST_CSRRCI_MASK 32'h707f

// mul
`define		INST_MUL 32'h2000033
`define		INST_MUL_MASK 32'hfe00707f

// mulh
`define		INST_MULH 32'h2001033
`define		INST_MULH_MASK 32'hfe00707f

// mulhsu
`define		INST_MULHSU 32'h2002033
`define		INST_MULHSU_MASK 32'hfe00707f

// mulhu
`define		INST_MULHU 32'h2003033
`define		INST_MULHU_MASK 32'hfe00707f

// div
`define		INST_DIV 32'h2004033
`define		INST_DIV_MASK 32'hfe00707f

// divu
`define		INST_DIVU 32'h2005033
`define		INST_DIVU_MASK 32'hfe00707f

// rem
`define		INST_REM 32'h2006033
`define		INST_REM_MASK 32'hfe00707f

// remu
`define		INST_REMU 32'h2007033
`define		INST_REMU_MASK 32'hfe00707f

// wfi
`define		INST_WFI 32'h10500073
`define		INST_WFI_MASK 32'hffff8fff

// fence
`define		INST_FENCE 32'hf
`define		INST_FENCE_MASK 32'h707f

// sfence
`define		INST_SFENCE 32'h12000073
`define		INST_SFENCE_MASK 32'hfe007fff

// fence.i
`define		INST_IFENCE 32'h100f
`define		INST_IFENCE_MASK 32'h707f

//-------------------------------------------------------------
// Hardware Parameters
//-------------------------------------------------------------
// Instruction Memory
`define InstAddrBus 31:0 
`define InstBus 31:0
`define InstMemNum 131072
`define InstMemNumLog2 17

// Register File
`define RegAddrBus 4:0
`define RegBus 31:0
`define RegNum 32
`define RegNumLog2 5

// ALU
`define AluOpBus 7:0
`define AluSelBus 2:0

// Memory
`define MemAddrBus 31:0
`define MemAddrWidth 32
`define MemDataBus 31:0
`define MemDataWidth 32
`define ByteBus 7:0
`define DataMemNum 131072
`define DataMemNumLog2 17

`endif