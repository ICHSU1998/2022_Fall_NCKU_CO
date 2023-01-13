module Mux(
	input enable,
	input [31:0] input_data1,
	input [31:0] input_data2,
	output [31:0] output_data
);

assign output_data = (enable) ? input_data1 : input_data2;

endmodule