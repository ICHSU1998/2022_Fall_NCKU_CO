  module ALU(
	input [4:0] opcode,
	input [2:0] func3,
	input func7,
	input signed [31:0] operand1,
	input signed [31:0] operand2,
	output reg [31:0] alu_out
);
wire [8:0] combine_r;
wire [7:0] combine_other;

assign combine_r = {func7, func3, opcode};
assign combine_other = {func3, opcode};

// ***** R-type *****
always @(*)
begin
	case(combine_r)
		9'b000001100: alu_out = operand1 + operand2; // R-type add
		9'b100001100: alu_out = operand1 - operand2; // R-type sub
		9'b000101100: alu_out = operand1 << operand2[4:0]; // R-type sll
		9'b001001100: alu_out = (operand1 < operand2) ? 1 : 0 ; // R-type slt
		9'b001101100: alu_out = ($unsigned(operand1) < $unsigned(operand2)) ? 1 : 0 ; // R-type sltu
		9'b010001100: alu_out = operand1 ^ operand2; // R-type xor
		9'b010101100: alu_out = operand1 >> operand2[4:0]; // R-type srl
		9'b110101100: alu_out = operand1 >>> operand2[4:0]; // R-type sra
		9'b011001100: alu_out = operand1 | operand2; // R-type or
		9'b011101100: alu_out = operand1 & operand2; // R-type and
		9'b000100100: alu_out = operand1 << $unsigned(operand2[4:0]); //I-type slli
		9'b010100100: alu_out = operand1 >> $unsigned(operand2[4:0]); //I-type srli
		9'b110100100: alu_out = operand1 >>> $unsigned(operand2[4:0]); //I-type srai
	endcase
end

// ***** I-type & B-type *****
always @(*)
begin
	case(combine_other)
		8'b00000100: alu_out = operand1 + $signed(operand2); // I-type addi
		8'b01000100: alu_out = (operand1 < operand2) ? 1 : 0 ; // I-type slti
		8'b01100100: alu_out = (operand1 < $unsigned(operand2)) ? 1 : 0 ; // I-type sltiu
		8'b10000100: alu_out = operand1 ^ operand2; // I-type xori
		8'b11000100: alu_out = operand1 | operand2; // I-type ori
		8'b11100100: alu_out = operand1 & operand2; // I-type andi
		8'b00011000: alu_out = (operand1 == operand2) ? 32'd1 : 32'd0; // B-type beq
		8'b00111000: alu_out = (operand1 != operand2) ? 32'd1 : 32'd0; // B-type bne
		8'b10011000: alu_out = (operand1 < operand2) ? 32'd1 : 32'd0; // B-type blt
		8'b10111000: alu_out = (operand1 >= operand2) ? 32'd1 : 32'd0; // B-type bge
		8'b11011000: alu_out = ($unsigned(operand1) < $unsigned(operand2)) ? 32'd1 : 32'd0; // B-type bltu
		8'b11111000: alu_out = ($unsigned(operand1) >= $unsigned(operand2)) ? 32'd1 : 32'd0; // B-type bgeu
	endcase
end

// ***** lui *****
always @(*)
begin
	if(opcode == 5'b01101)
		if(operand1 == operand2)
			alu_out = operand2;
		else
			alu_out = operand2;
end

// ***** auipc & load & S-type *****
always @(*)
begin
	if(opcode == 5'b00101 || opcode == 5'b00000 || opcode == 5'b01000)
		alu_out = operand1 + operand2;
end

// ***** jal & jalr *****
always @(*)
begin
	if(opcode == 5'b11011 || opcode == 5'b11001)
		alu_out = operand1 + 32'd4;
end

endmodule
