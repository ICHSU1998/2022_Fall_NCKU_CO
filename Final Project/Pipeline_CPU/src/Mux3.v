module Mux3(
	input [1:0] enable,
	input [31:0] input_data1,
	input [31:0] input_data2,
	input [31:0] input_data3,
	output reg [31:0] output_data
);

always @(*)
begin
	case(enable)
		2'b00: output_data <= input_data1;
		2'b01: output_data <= input_data2;
		2'b10: output_data <= input_data3;
	endcase
end

endmodule