module testMreg();
reg[3:0]n;
reg clock;
wire Q3,Q2,Q1,Q0;

mreg UUT(n, Q3,Q2,Q1,Q0, clock, C1);

	always #5 clock = ~clock;
	initial begin
		#5
		n = 4'b0101;
		$display("Q: = %b%b%b%b", Q3,Q2,Q1,Q0);

	#10 $finish;
	end
endmodule
