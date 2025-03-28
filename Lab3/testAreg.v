module testAreg();
reg [3:0]D;
reg clock, C1, C0;
wire Q3,Q2,Q1,Q0, so;

areg UUT(Q3,Q2,Q1,Q0, so, D, clock, C1, C0);
always #5 clock = ~clock;
	initial begin
		clock = 0;
		#5
		D = 4'b1010;
		C1 = 1'b0;
		C0 = 1'b0;
		#5
		$display("Load: Q = %b%b%b%b", Q3,Q2,Q1,Q0);

		#5
		D = 4'b0000;
		C1 = 1'b0;
		C0 = 1'b1;
		#10
		$display("Reset: Q = %b%b%b%b", Q3,Q2,Q1,Q0);

		#5
		D = 4'b1111;
		C1 = 1'b1;
		C0 = 1'b0;
		#10
		$display("Shift: Q = %b%b%b%b", Q3,Q2,Q1,Q0);

		#5
		C1 = 1'b1;
		C0 = 1'b1;
		#10
		$display("Hold: Q = %b%b%b%b", Q3,Q2,Q1,Q0);

		#10 $finish;

	end
endmodule
