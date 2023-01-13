module Reg_E(
	input clk,
	input rst,
	input enable_jb,
	input enable_stall,
	input [31:0] input_pc,
	input [31:0] input_rs1_data,
	input [31:0] input_rs2_data,
	input [31:0] input_sext_imm,
	output reg [31:0] output_pc,
	output reg [31:0] output_rs1_data,
	output reg [31:0] output_rs2_data,
	output reg [31:0] output_sext_imm
);

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		output_rs1_data <= 32'd0;
		output_rs2_data <= 32'd0;
	end
	else
	begin
		if(enable_jb || enable_stall)
		begin
			output_rs1_data <= 32'd0;
			output_rs2_data <= 32'd0;
		end
		else
		begin
			output_rs1_data <= input_rs1_data;
			output_rs2_data <= input_rs2_data;
		end
	end
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_sext_imm <= 32'd0;
	else
	begin
		if(enable_jb || enable_stall)
			output_sext_imm <= 32'd0;
		else
			output_sext_imm <= input_sext_imm;
	end
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_pc <= 32'd0;
	else
	begin
		if(enable_jb || enable_stall)
			output_pc <= 32'd0;
		else
			output_pc <= input_pc;
	end
end

endmodule
