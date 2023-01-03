module adder_2(input [1:0] x, input [1:0] y, input cin, output[1:0] s, output cout);
wire [1:0]  tmp_and_xy, tmp_xor_xy, tmp_and_cin;
wire        tmp_cout;
assign tmp_and_xy[0] = x[0] & y[0];
assign tmp_xor_xy[0] = x[0] ^ y[0];
assign tmp_and_cin[0] = tmp_xor_xy[0] & cin;
assign tmp_cout = tmp_and_cin[0] | tmp_and_xy[0];
assign s[0] = tmp_xor_xy[0] ^ cin;

assign tmp_and_xy[1] = x[1] & y[1];
assign tmp_xor_xy[1] = x[1] ^ y[1];
assign tmp_and_cin[1] = tmp_xor_xy[1] & tmp_cout;
assign cout = tmp_and_cin[1] | tmp_and_xy[1];
assign s[1] = tmp_xor_xy[1] ^ tmp_cout;
endmodule

module Adder(input [3:0] x, input [3:0] y, input cin, output [3:0] s, output cout);

wire inter_cout;
adder_2 adder0 (.x(x[1:0]), .y(y[1:0]), .cin(cin), .s(s[1:0]), .cout(inter_cout));
adder_2 adder1 (.x(x[3:2]), .y(y[3:2]), .cin(inter_cout), .s(s[3:2]), .cout(cout));

endmodule