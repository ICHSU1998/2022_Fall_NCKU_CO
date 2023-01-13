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
`include "./src/Mux3.v"
`include "./src/Reg_D.v"
`include "./src/Reg_E.v"
`include "./src/Reg_M.v"
`include "./src/Reg_W.v"

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
wire [31:0] current_pc, addr_pc, jb_pc, next_pc;
wire [31:0] reg_d_pc, reg_d_inst;
wire [4:0] decoder_op, decoder_rs1, decoder_rs2, decoder_rd;
wire [2:0] decoder_f3;
wire decoder_f7;
wire [31:0] imm_ext_imm;
wire [31:0] regfile_data1, regfile_data2;
wire [31:0] mux2_data, mux3_data;
wire [31:0] reg_e_pc, reg_e_data1, reg_e_data2, reg_e_imm;
wire [31:0] mux3_1_data, mux3_2_data;
wire [31:0] mux4_data, mux5_data;
wire [31:0] alu_out;
wire [31:0] mux6_data;
wire [31:0] reg_m_alu_out, reg_m_rs2_data;
wire [31:0] reg_w_alu_out, reg_w_ld_data;
wire [31:0] ld_data_f;
wire [31:0] wb_data;

wire next_pc_sel, stall, D_rs1_data_sel, D_rs2_data_sel, E_jb_op1_sel, E_alu_op1_sel, E_alu_op2_sel, E_f7, W_wb_en, W_wb_data_sel;
wire [1:0] E_rs1_data_sel, E_rs2_data_sel;
wire [4:0] E_op, W_rd_index;
wire [2:0] E_f3, W_f3;

assign im_address = current_pc;
assign dm_address = reg_m_alu_out;
assign dm_write_data = reg_m_rs2_data;

// ********** IF **********
Adder adder_u(
	.input_data(current_pc),
	.output_data(addr_pc)
);

Mux mux1_u(
	.enable(next_pc_sel),
	.input_data1(jb_pc),
	.input_data2(addr_pc),
	.output_data(next_pc)
);

Reg_PC reg_pc_u(
	.clk(clk),
	.rst(rst),
	.enable_stall(stall),
	.next_pc(next_pc),
	.current_pc(current_pc)
);

///////////////
//           //
//           //
//    IM     //
//           //
//           //
///////////////
// ************************
// ********** ID **********
Reg_D reg_d_u(
	.clk(clk),
	.rst(rst),
	.enable_stall(stall),
	.enable_jb(next_pc_sel),
	.input_pc(current_pc),
	.input_inst(im_read_data),
	.output_pc(reg_d_pc),
	.output_inst(reg_d_inst)
);

Decoder decoder_u(
	.inst(reg_d_inst),
	.dc_out_opcode(decoder_op),
	.dc_out_func3(decoder_f3),
	.dc_out_func7(decoder_f7),
	.dc_out_rs1_index(decoder_rs1),
	.dc_out_rs2_index(decoder_rs2),
	.dc_out_rd_index(decoder_rd)
);

Imm_Ext imm_ext_u(
	.inst(reg_d_inst),
	.imm_ext_out(imm_ext_imm)
);

RegFile regfile_u(
	.clk(clk),
	.wb_en(W_wb_en),
	.wb_data(wb_data),
	.rd_index(W_rd_index),
	.rs1_index(decoder_rs1),
	.rs2_index(decoder_rs2),
	.rs1_data_out(regfile_data1),
	.rs2_data_out(regfile_data2)
);

Mux mux2_u(
	.enable(D_rs1_data_sel),
	.input_data1(regfile_data1),
	.input_data2(wb_data),
	.output_data(mux2_data)
);

Mux mux3_u(
	.enable(D_rs2_data_sel),
	.input_data1(regfile_data2),
	.input_data2(wb_data),
	.output_data(mux3_data)
);
// ************************
// ********** EX **********
Reg_E reg_e_u(
	.clk(clk),
	.rst(rst),
	.enable_jb(next_pc_sel),
	.enable_stall(stall),
	.input_pc(reg_d_pc),
	.input_rs1_data(mux2_data),
	.input_rs2_data(mux3_data),
	.input_sext_imm(imm_ext_imm),
	.output_pc(reg_e_pc),
	.output_rs1_data(reg_e_data1),
	.output_rs2_data(reg_e_data2),
	.output_sext_imm(reg_e_imm)
);

Mux3 mux3_1_u(
	.enable(E_rs1_data_sel),
	.input_data1(wb_data),
	.input_data2(reg_m_alu_out),
	.input_data3(reg_e_data1),
	.output_data(mux3_1_data)
);

Mux3 mux3_2_u(
	.enable(E_rs2_data_sel),
	.input_data1(wb_data),
	.input_data2(reg_m_alu_out),
	.input_data3(reg_e_data2),
	.output_data(mux3_2_data)
);

Mux mux4_u(
	.enable(E_alu_op1_sel),
	.input_data1(mux3_1_data),
	.input_data2(reg_e_pc),
	.output_data(mux4_data)
);

Mux mux5_u(
	.enable(E_alu_op2_sel),
	.input_data1(mux3_2_data),
	.input_data2(reg_e_imm),
	.output_data(mux5_data)
);

ALU alu_u(
	.opcode(E_op),
	.func3(E_f3),
	.func7(E_f7),
	.operand1(mux4_data),
	.operand2(mux5_data),
	.alu_out(alu_out)
);

Mux mux6_u(
	.enable(E_jb_op1_sel),
	.input_data1(mux3_1_data),
	.input_data2(reg_e_pc),
	.output_data(mux6_data)
);

JB_Unit jb_unit_u(
	.operand1(mux6_data),
	.operand2(reg_e_imm),
	.jb_out(jb_pc)
);
// ************************
// ********** MEM **********
Reg_M reg_m_u(
	.clk(clk),
	.rst(rst),
	.input_rs2_data(mux3_2_data),
	.input_alu_out(alu_out),
	.output_rs2_data(reg_m_rs2_data),
	.output_alu_out(reg_m_alu_out)
);

///////////////
//           //
//           //
//    DM     //
//           //
//           //
///////////////
// ************************
// ********** WB **********
Reg_W reg_w_u(
	.clk(clk),
	.rst(rst),
	.input_alu_out(reg_m_alu_out),
	.input_ld_data(dm_read_data),
	.output_alu_out(reg_w_alu_out),
	.output_ld_data(reg_w_ld_data)
);

LD_Filter ld_filter_u(
	.func3(W_f3),
	.ld_data(reg_w_ld_data),
	.ld_data_f(ld_data_f)
);

Mux mux7_u(
	.enable(W_wb_data_sel),
	.input_data1(reg_w_alu_out),
	.input_data2(ld_data_f),
	.output_data(wb_data)
);
// ************************
Controller controller_u(
	.clk(clk),
	.rst(rst),
	.input_op(decoder_op),
	.input_f3(decoder_f3),
	.input_f7(decoder_f7),
	.input_rd(decoder_rd),
	.input_rs1(decoder_rs1),
	.input_rs2(decoder_rs2),
	.alu_out(alu_out[0]),
	.next_pc_sel(next_pc_sel),
	.stall(stall),
	.F_im_w_en(im_w_en),
	.D_rs1_data_sel(D_rs1_data_sel),
	.D_rs2_data_sel(D_rs2_data_sel),
	.E_rs1_data_sel(E_rs1_data_sel),
	.E_rs2_data_sel(E_rs2_data_sel),
	.E_jb_op1_sel(E_jb_op1_sel),
	.E_alu_op1_sel(E_alu_op1_sel),
	.E_alu_op2_sel(E_alu_op2_sel),
	.E_op(E_op),
	.E_f3(E_f3),
	.E_f7(E_f7),
	.M_dm_w_en(dm_w_en),
	.W_wb_en(W_wb_en),
	.W_rd_index(W_rd_index),
	.W_f3(W_f3),
	.W_wb_data_sel(W_wb_data_sel)
);
endmodule
