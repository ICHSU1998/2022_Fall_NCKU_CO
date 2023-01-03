module Mult(Multiplicand,Multiplier,Product);

	input	[3:0]	Multiplicand,Multiplier;
	output	reg	[7:0]	Product;

	reg    [7:0]	inter[0:2];

	always@	(*)begin
		inter[0] = (Multiplier[0]) ? {4'd0, Multiplicand} : 8'd0;
		inter[1] = (Multiplier[1]) ? inter[0] + {3'd0, Multiplicand, 1'd0} : inter[0];
		inter[2] = (Multiplier[2]) ? inter[1] + {2'd0, Multiplicand, 2'd0} : inter[1];
		Product = (Multiplier[3]) ? inter[2] + {1'd0, Multiplicand, 3'd0} : inter[2];
	end

endmodule