module Controller(
	input [4:0] input_opcode,
	input [2:0] input_func3,
	input input_func7,
	input alu_out,
	output reg next_pc_sel,
	output [3:0] im_w_en,
	output reg [3:0] dm_w_en,
	output reg wb_en,
	output reg jb_op1_sel,
	output reg alu_op1_sel,
	output reg alu_op2_sel,
	output [4:0] output_opcode,
	output [2:0] output_func3,
	output output_func7,
	output reg wb_sel
);

// ***** control ALU *****
assign output_opcode = input_opcode;
assign output_func3 = input_func3;
assign output_func7 = input_func7;

// ***** control RegFile ******
always @(*)
begin // jalr/load/auipc/U-type/jal/I-type/R-type
	if(input_opcode == 5'b11001 || input_opcode == 5'b00000 || input_opcode == 5'b00101 || input_opcode == 5'b01101 || input_opcode == 5'b11011 || input_opcode == 5'b00100 || input_opcode == 5'b01100)
		wb_en = 1'b1;
	else
		wb_en = 1'b0;
end

// ***** control Mux1 *****
always @(*)
begin // jalr/jal/B-type
	if(input_opcode == 5'b11011 || input_opcode == 5'b11001 || ((alu_out == 1'b1) && input_opcode == 5'b11000))
		next_pc_sel = 1'b1;
	else
		next_pc_sel = 1'b0;
end

// ***** control Mux2 *****
always @(*)
begin // R-type/I-type/S-type/B-type/load/lui
	if(input_opcode == 5'b01100 || input_opcode == 5'b00100 || input_opcode == 5'b01000 || input_opcode == 5'b11000 || input_opcode == 5'b00000 || input_opcode == 5'b01101)
		alu_op1_sel = 1'b1;
	else
		alu_op1_sel = 1'b0;
end

// ***** control Mux3 *****
always @(*)
begin // R-type/B-type
	if(input_opcode == 5'b01100 || input_opcode == 5'b11000)
		alu_op2_sel = 1'b1;
	else
		alu_op2_sel = 1'b0;
end

// ***** control Mux4 *****
always @(*)
begin // jalr
	if(input_opcode == 5'b11001)
		jb_op1_sel = 1'b1;
	else
		jb_op1_sel = 1'b0;
end

// ***** control Mux5 *****
always @(*)
begin// jal/jalr/B-type/auipc/I-type/R-type/U-type
	if(input_opcode == 5'b11011 || input_opcode == 5'b11001 || input_opcode == 5'b11000 || input_opcode == 5'b00101 || input_opcode == 5'b00100 || input_opcode == 5'b01100 || input_opcode == 5'b01101)
		wb_sel = 1'b1;
	else
		wb_sel = 1'b0;
end

// ***** control IM *****
assign im_w_en = 4'b0000;

// ***** control DM *****
always @(*)
begin
	if(input_func3 == 3'b000 && input_opcode == 5'b01000) // S-type sb
		dm_w_en = 4'b0001;
	else if(input_func3 == 3'b001 && input_opcode == 5'b01000) // S-type sh
		dm_w_en = 4'b0011;
	else if(input_func3 == 3'b010 && input_opcode == 5'b01000) // S-type sw
		dm_w_en = 4'b1111;	
	else
		dm_w_en = 4'b0000;
end

endmodule
