module RTL_multiply(clk, m, q, out, done);
input clk;
input [3:0] m;
input  [3:0] q;
output [7:0] out;
output done;
	reg start;
	reg [2:0] i;
	reg [9:0] product;

	assign done = (i==4? 1'b1: 1'b0);
	assign out = product[8:1];

	always @(posedge clk) begin
		if(start)
			{product, start, i} = {{5'b00000, q, 1'b0}, 1'b0, 3'b000};
		if(i<4) begin
			case (product[1:0])
				2'b01 : product[9:5] = product[9:5] + {m[3], m};
				2'b10 : product[9:5] = product[9:5] - {m[3], m};
			endcase
			product = {product[9], product[9:1]};
			i = i + 1'b1;
		end
		else begin
			start = 1;
			i = 0;
		end
	end
endmodule
