module Reg_M(
	input clk,
	input rst,
	input [31:0] input_rs2_data,
	input [31:0] input_alu_out,
	output reg [31:0] output_rs2_data,
	output reg [31:0] output_alu_out
);

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_rs2_data <= 32'd0;
	else
		output_rs2_data <= input_rs2_data;
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_alu_out <= 32'd0;
	else
		output_alu_out <= input_alu_out;
end

endmodule