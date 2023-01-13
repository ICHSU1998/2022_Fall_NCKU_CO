module Reg_D(
	input clk,
	input rst,
	input enable_jb,
	input enable_stall,
	input [31:0] input_pc,
	input [31:0] input_inst,
	output reg [31:0] output_pc,
	output reg [31:0] output_inst
);

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_pc <= 32'd0;
	else
	begin
		if(enable_jb)
			output_pc <= 32'd0;
		else if(enable_stall)
			output_pc <= output_pc;
		else
			output_pc <= input_pc;
	end
end

always @(posedge clk or posedge rst)
begin
	if(rst)
		output_inst <= 32'd0;
	else
	begin
		if(enable_jb)
			output_inst <= 32'd0;
		else if(enable_stall)
			output_inst <= output_inst;
		else
			output_inst <= input_inst;
	end
end

endmodule

