module Adder(
	input [31:0] input_data,
	output [31:0] output_data
);

assign output_data = input_data + 32'd4;

endmodule