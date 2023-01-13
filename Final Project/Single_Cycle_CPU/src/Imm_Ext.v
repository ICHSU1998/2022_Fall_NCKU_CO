module Imm_Ext(
	input [31:0] inst,
	output reg [31:0] imm_ext_out
);
wire [4:0] opcode;

assign opcode = inst[6:2];

always @(*)
begin
	case(opcode)
		5'b01100: imm_ext_out = 32'd0; // ***** R-type *****
		5'b00100: imm_ext_out = {{20{inst[31]}}, inst[31:20]}; // ***** I-type *****
		5'b01000: imm_ext_out = {{20{inst[31]}}, inst[31:25], inst[11:7]}; // ***** S-type *****
		5'b11000: imm_ext_out = {{20{inst[31]}}, inst[30:25], inst[11:8], 1'b0}; // ***** B-type *****
		5'b01101: imm_ext_out = {inst[31:12], 12'b0}; // ***** U-type *****
		5'b11011: imm_ext_out = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; // ***** J-type *****
		5'b11001: imm_ext_out = {{20{inst[31]}}, inst[31:20]};  // ***** jalr *****
		5'b00000: imm_ext_out = {{20{inst[31]}}, inst[31:20]}; // ***** load *****
		5'b00101: imm_ext_out = {inst[31:12], 12'b0}; // ***** auipc *****
	endcase
end

endmodule
