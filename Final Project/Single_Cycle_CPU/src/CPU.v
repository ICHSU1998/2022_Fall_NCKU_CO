`include "./src/Reg_PC.v"
`include "./src/Adder.v"
`include "./src/ALU.v"
`include "./src/Controller.v"
`include "./src/Decoder.v"
`include "./src/Imm_Ext.v"
`include "./src/JB_Unit.v"
`include "./src/LD_Filter.v"
`include "./src/Mux.v"
`include "./src/RegFile.v"

module CPU(
	input clk,
	input rst,
	input [31:0] im_read_data,
	input [31:0] dm_read_data,
	output [3:0] im_w_en,
	output [31:0] im_address,
	output [31:0] im_write_data,
	output [3:0] dm_w_en,
	output [31:0] dm_address,
	output [31:0] dm_write_data
);
wire [31:0] next_pc, current_pc, adder_pc;
wire [4:0] dc_out_opcode;
wire [2:0] dc_out_func3;
wire dc_out_func7;
wire [4:0] dc_out_rs1_index, dc_out_rs2_index, dc_out_rd_index;
wire [31:0] imm_ext_out;
wire [31:0] rs1_data_out, rs2_data_out;
wire [31:0] operand1, operand2;
wire [31:0] alu_out;
wire [31:0] output_mux4;
wire [31:0] ld_data_f;
wire [31:0] wb_data;
wire next_pc_sel, wb_en, jb_op1_sel, alu_op1_sel, alu_op2_sel, wb_sel;
wire [4:0] output_opcode;
wire [2:0] output_func3;
wire output_func7;
wire [31:0] jb_pc;

assign im_address = current_pc;
assign dm_address = alu_out;
assign dm_write_data = rs2_data_out;

Reg_PC reg_pc_u(
	.clk(clk),
	.rst(rst),
	.next_pc(next_pc),
	.current_pc(current_pc)
);

Adder adder_u(
	.input_data(current_pc),
	.output_data(adder_pc)
);

Mux mux1_u(
	.enable(next_pc_sel),
	.input_data1(jb_pc),
	.input_data2(adder_pc),
	.output_data(next_pc)
);

Decoder decoder_u(
	.inst(im_read_data),
	.dc_out_opcode(dc_out_opcode),
	.dc_out_func3(dc_out_func3),
	.dc_out_func7(dc_out_func7),
	.dc_out_rs1_index(dc_out_rs1_index),
	.dc_out_rs2_index(dc_out_rs2_index),
	.dc_out_rd_index(dc_out_rd_index)
);

Imm_Ext imm_ext_u(
	.inst(im_read_data),
	.imm_ext_out(imm_ext_out)
);

RegFile regfile_u(
	.clk(clk),
	.wb_en(wb_en),
	.wb_data(wb_data),
	.rd_index(dc_out_rd_index),
	.rs1_index(dc_out_rs1_index),
	.rs2_index(dc_out_rs2_index),
	.rs1_data_out(rs1_data_out),
	.rs2_data_out(rs2_data_out)
);

Mux mux2_u(
	.enable(alu_op1_sel),
	.input_data1(rs1_data_out),
	.input_data2(current_pc),
	.output_data(operand1)
);

Mux mux3_u(
	.enable(alu_op2_sel),
	.input_data1(rs2_data_out),
	.input_data2(imm_ext_out),
	.output_data(operand2)
);

ALU alu_u(
	.opcode(output_opcode),
	.func3(output_func3),
	.func7(output_func7),
	.operand1(operand1),
	.operand2(operand2),
	.alu_out(alu_out)
);

Mux mux4_u(
	.enable(jb_op1_sel),
	.input_data1(rs1_data_out),
	.input_data2(current_pc),
	.output_data(output_mux4)
);

JB_Unit jb_unit_u(
	.operand1(output_mux4),
	.operand2(imm_ext_out),
	.jb_out(jb_pc)
);

LD_Filter ld_filter_u(
	.func3(output_func3),
	.ld_data(dm_read_data),
	.ld_data_f(ld_data_f)
);

Mux mux5_u(
	.enable(wb_sel),
	.input_data1(alu_out),
	.input_data2(ld_data_f),
	.output_data(wb_data)
);

Controller controller_u(
	.input_opcode(dc_out_opcode),
	.input_func3(dc_out_func3),
	.input_func7(dc_out_func7),
	.alu_out(alu_out[0]),
	.next_pc_sel(next_pc_sel),
	.im_w_en(im_w_en),
	.wb_en(wb_en),
	.jb_op1_sel(jb_op1_sel),
	.alu_op1_sel(alu_op1_sel),
	.alu_op2_sel(alu_op2_sel),
	.output_opcode(output_opcode),
	.output_func3(output_func3),
	.output_func7(output_func7),
	.wb_sel(wb_sel),
	.dm_w_en(dm_w_en)
);
endmodule
