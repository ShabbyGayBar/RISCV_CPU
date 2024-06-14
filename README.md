# RISC-V CPU
This is a term project of MST3305-01, SJTU, 2024 spring.

## Features
* A single cycle version (located in ./single) and a 5-stage pipeline version (located in ./pipeline) of a RISC-V CPU
* Inplemented with Verilog
* Supports all instructions in RV32I, including:
  * R type: add, sub, xor, or, and, sll, srl, sra, slt, sltu
  * I type: addi, xori, ori, andi, slli, srli, srai, slti, sltiu, lw, jalr
  * S type: sw
  * B type: beq, bne, blt, bge, bltu, bgeu
  * U type: lui, auipc
  * J type: jal
* A testbench program (a quick sort algorithm in ./single/machinecode.txt and ./pipeline/machinecode.txt)
* A Latex report (written in Mandarin, located in ./report)

## Testbench
* Install [iVerilog](https://github.com/steveicarus/iverilog) & [GTKWave](https://sourceforge.net/projects/gtkwave/files/)
* Go to directory ./single or ./pipeline
* Open terminal in the directory
* Enter the following commands:
```sh
iverilog -o wave .\riscv_soc_tb.v
vvp -n wave -lxt2
gtkwave wave.vcd
```
* The GTKWave waveform should pop up. Have fun~
