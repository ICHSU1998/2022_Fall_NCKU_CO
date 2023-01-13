`include "./src/SRAM.v"
`include "./src/CPU.v"

module Top(
    input clk,
    input rst
);
wire [3:0] im_w_en, dm_w_en;
wire [31:0] im_address, dm_address;
wire [31:0] im_write_data, im_read_data, dm_write_data, dm_read_data;

CPU cpu_u(
	.clk(clk),
	.rst(rst),
	.im_w_en(im_w_en),
	.im_address(im_address),
	.im_write_data(im_write_data),
	.im_read_data(im_read_data),
	.dm_w_en(dm_w_en),
	.dm_address(dm_address),
	.dm_write_data(dm_write_data),
	.dm_read_data(dm_read_data)
);

SRAM im (
	.clk(clk),
	.w_en(im_w_en),
	.address(im_address[15:0]),
	.write_data(im_write_data),
	.read_data(im_read_data)
);

SRAM dm (
	.clk(clk),
	.w_en(dm_w_en),
	.address(dm_address[15:0]),
	.write_data(dm_write_data),
	.read_data(dm_read_data)
);

endmodule