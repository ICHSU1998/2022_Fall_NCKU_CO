module Controller(
	input clk,
	input rst,
	input [4:0] input_op,
	input [2:0] input_f3,
	input input_f7,
	input [4:0] input_rd,
	input [4:0] input_rs1,
	input [4:0] input_rs2,
	input alu_out,
	output reg next_pc_sel,
	output stall,
	output [3:0] F_im_w_en,
	output D_rs1_data_sel,
	output D_rs2_data_sel,
	output [1:0] E_rs1_data_sel,
	output [1:0] E_rs2_data_sel,
	output reg E_jb_op1_sel,
	output reg E_alu_op1_sel,
	output reg E_alu_op2_sel,
	output reg [4:0] E_op,
	output reg [2:0] E_f3,
	output reg E_f7,
	output reg [3:0] M_dm_w_en,
	output reg W_wb_en,
	output reg [4:0] W_rd_index,
	output reg [2:0] W_f3,
	output reg W_wb_data_sel
);
reg [4:0] E_rd, E_rs1, E_rs2;
reg [4:0] M_op, M_rd;
reg [2:0] M_f3;
reg [4:0] W_op, W_rd;
wire Reg_D_rs1_and_Reg_E_rd_overlap, Reg_D_rs2_and_Reg_E_rd_overlap, is_D_use_rs1, is_D_use_rs2, is_W_use_rd, is_E_use_rs1, is_E_use_rs2, is_M_use_rd;

assign is_D_use_rs1 = (input_op == 5'b01100 || input_op == 5'b00100 || input_op == 5'b01000 || input_op == 5'b11000 || input_op == 5'b11001 || input_op == 5'b00000) ? 1'b1 : 1'b0;
assign is_D_use_rs2 = (input_op == 5'b01100 || input_op == 5'b01000 || input_op == 5'b11000) ? 1'b1 : 1'b0;
assign is_W_use_rd = (W_op == 5'b01100 || W_op == 5'b00100 || W_op == 5'b01101 || W_op == 5'b00101 || W_op == 5'b11011 || W_op == 5'b11001 || W_op == 5'b00000) ? 1'b1 : 1'b0;
assign is_E_use_rs1 = (E_op == 5'b01100 || E_op == 5'b00100 || E_op == 5'b00000 || E_op == 5'b01000 || E_op == 5'b11000 || E_op == 5'b11001) ? 1'b1 : 1'b0;
assign is_E_use_rs2 = (E_op == 5'b01100 || E_op == 5'b01000 || E_op == 5'b11000) ? 1'b1 : 1'b0;
assign is_M_use_rd = (M_op == 5'b01100 || M_op == 5'b00100 || M_op == 5'b01101 || M_op == 5'b00101 || M_op == 5'b11011 || M_op == 5'b11001 || M_op == 5'b00000) ? 1'b1 : 1'b0;

// ***** reg EX *****
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		E_op <= 5'd0;
		E_f3 <= 3'd0;
		E_f7 <= 1'd0;
		E_rd <= 5'd0;
		E_rs1 <= 5'd0;
		E_rs2 <= 5'd0;
	end
	else
	begin
		if((E_op == 5'b11011 || E_op == 5'b11001 || ((alu_out == 1'b1) && E_op == 5'b11000)) || ((E_op == 5'b00000) & (Reg_D_rs1_and_Reg_E_rd_overlap | Reg_D_rs2_and_Reg_E_rd_overlap)))
		begin
			E_op <= 5'd0;
			E_f3 <= 3'd0;
			E_f7 <= 1'd0;
			E_rd <= 5'd0;
			E_rs1 <= 5'd0;
			E_rs2 <= 5'd0;
		end
		else
		begin
			E_op <= input_op;
			E_f3 <= input_f3;
			E_f7 <= input_f7;
			E_rd <= input_rd;
			E_rs1 <= input_rs1;
			E_rs2 <= input_rs2;
		end
	end
end

// ***** reg MEM *****
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		M_op <= 5'd0;
		M_f3 <= 3'd0;
		M_rd <= 5'd0;
	end
	else
	begin
		M_op <= E_op;
		M_f3 <= E_f3;
		M_rd <= E_rd;
	end
end

// ***** reg WB *****
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		W_op <= 5'd0;
		W_f3 <= 3'd0;
		W_rd <= 5'd0;
	end
	else
	begin
		W_op <= M_op;
		W_f3 <= M_f3;
		W_rd <= M_rd;
	end
end


// ***** control RegFile ******
always @(*)
begin // jalr/load/auipc/U-type/jal/I-type/R-type
	if(W_op == 5'b11001 || W_op == 5'b00000 || W_op == 5'b00101 || W_op == 5'b01101 || W_op == 5'b11011 || W_op == 5'b00100 || W_op == 5'b01100)
		W_wb_en = 1'b1;
	else
		W_wb_en = 1'b0;
end

always @(*)
begin // jalr/load/auipc/U-type/jal/I-type/R-type
	if(W_op == 5'b11001 || W_op == 5'b00000 || W_op == 5'b00101 || W_op == 5'b01101 || W_op == 5'b11011 || W_op == 5'b00100 || W_op == 5'b01100)
		W_rd_index = W_rd;
	else
		W_rd_index = 5'd0;
end

// ***** stall *****
assign stall = (E_op == 5'b00000) & (Reg_D_rs1_and_Reg_E_rd_overlap | Reg_D_rs2_and_Reg_E_rd_overlap);
assign Reg_D_rs1_and_Reg_E_rd_overlap = (is_D_use_rs1 & (input_rs1 == E_rd) & (E_rd != 5'd0));
assign Reg_D_rs2_and_Reg_E_rd_overlap = (is_D_use_rs2 & (input_rs2 == E_rd) & (E_rd != 5'd0));

// ***** control Mux3_1 *****
assign E_rs1_data_sel = ((is_E_use_rs1 & is_M_use_rd & (E_rs1 == M_rd) & (M_rd != 5'd0)) ? 2'd1 : (is_E_use_rs1 & is_W_use_rd & (E_rs1 == W_rd) & (W_rd != 5'd0)) ? 2'd0 : 2'd2);

// ***** control Mux3_2 *****
assign E_rs2_data_sel = ((is_E_use_rs2 & is_M_use_rd & (E_rs2 == M_rd) & (M_rd != 5'd0)) ? 2'd1 : (is_E_use_rs2 & is_W_use_rd & (E_rs2 == W_rd) & (W_rd != 5'd0)) ? 2'd0 : 2'd2);

// ***** control Mux1 *****
always @(*)
begin // jalr/jal/B-type
	if(E_op == 5'b11011 || E_op == 5'b11001 || ((alu_out == 1'b1) && E_op == 5'b11000))
		next_pc_sel = 1'b1;
	else
		next_pc_sel = 1'b0;
end

// ***** control Mux2 *****
assign D_rs1_data_sel = (is_D_use_rs1 & is_W_use_rd & (input_rs1 == W_rd) & (W_rd != 5'd0)) ? 1'd0 : 1'd1;

// ***** control Mux3 *****
assign D_rs2_data_sel = (is_D_use_rs2 & is_W_use_rd & (input_rs2 == W_rd) & (W_rd != 5'd0)) ? 1'd0 : 1'd1;

// ***** control Mux4 *****
always @(*)
begin // R-type/I-type/S-type/B-type/load/lui
	if(E_op == 5'b01100 || E_op == 5'b00100 || E_op == 5'b01000 || E_op == 5'b11000 || E_op == 5'b00000 || E_op == 5'b01101)
		E_alu_op1_sel = 1'b1;
	else
		E_alu_op1_sel = 1'b0;
end

// ***** control Mux5 *****
always @(*)
begin // R-type/B-type
	if(E_op == 5'b01100 || E_op == 5'b11000)
		E_alu_op2_sel = 1'b1;
	else
		E_alu_op2_sel = 1'b0;
end

// ***** control Mux6 *****
always @(*)
begin // jalr
	if(E_op == 5'b11001)
		E_jb_op1_sel = 1'b1;
	else
		E_jb_op1_sel = 1'b0;
end

// ***** control Mux7 *****
always @(*)
begin// jal/jalr/B-type/auipc/I-type/R-type/U-type
	if(W_op == 5'b11011 || W_op == 5'b11001 || W_op == 5'b11000 || W_op == 5'b00101 || W_op == 5'b00100 || W_op == 5'b01100 || W_op == 5'b01101)
		W_wb_data_sel = 1'b1;
	else
		W_wb_data_sel = 1'b0;
end

// ***** control IM *****
assign F_im_w_en = 4'b0000;

// ***** control DM *****
always @(*)
begin
	if(M_f3 == 3'b000 && M_op == 5'b01000) // S-type sb
		M_dm_w_en = 4'b0001;
	else if(M_f3 == 3'b001 && M_op == 5'b01000) // S-type sh
		M_dm_w_en = 4'b0011;
	else if(M_f3 == 3'b010 && M_op == 5'b01000) // S-type sw
		M_dm_w_en = 4'b1111;
	else
		M_dm_w_en = 4'b0000;
end

endmodule
