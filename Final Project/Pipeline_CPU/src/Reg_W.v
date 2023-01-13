module Reg_W(
	input clk,
	input rst,
	input [31:0] input_alu_out,
	input [31:0] input_ld_data,
	output reg [31:0] output_alu_out,
	output reg [31:0] output_ld_data
);

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_ld_data <= 32'd0;
	else
		output_ld_data <= input_ld_data;
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_alu_out <= 32'd0;
	else
		output_alu_out <= input_alu_out;
end

endmodule
