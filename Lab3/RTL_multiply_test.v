module RTL_multiply_test();
	reg signed [3:0] multiplicand;
	reg signed [3:0] multiplier;
	wire signed [7:0] product;
	reg clk;

	initial begin
		clk = 1;
		multiplicand = 0;
		multiplier = 0;
		forever #10 clk = ~clk;
		
		$display("TIME | NUM 1 | NUM 2 | PRODUCT  ");
		#10000 $finish();
	end

	always @(negedge clk) begin
		$display(" %3d  |  %2d  |  %2d  | %3d", $time, multiplicand, multiplier, product);
		if (multiplicand == 4'b0000) begin
			multiplier = multiplier + 1;
		end
		multiplicand = multiplicand + 1;
	end

	RTL_multiply mult(clk, multiplicand, multiplier, product);

endmodule