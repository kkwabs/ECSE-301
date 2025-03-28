module testQreg();
// reg 
reg [3:0]f;
reg clock, C1,C0, si;
// wire
wire Q3,Q2,Q1,Q0;

// Instantiate your component
// QReg
qreg UUT(D3,D2,D1,D0 ,Q3,Q2,Q1,Q0,clock,C1,C0,si);
always #5 clock = ~clock;
	initial begin

	clock = 0;

	#5
	f = 4'b0011;
	C1 = 1'b0;
	C0 = 1'b0;
	#10
	$display("Load = %b%b%b%b" , Q3,Q2,Q1,Q0);

	
	#5
	f = 4'b0011;
	C1 = 1'b0;
	C0 = 1'b1;
	si = 1'b1;
	
	#10
	$display("Shift = %b%b%b%b" , Q3,Q2,Q1,Q0);


	#5
	f = 4'b0011;
	clock = 1;
	C1 = 1'b1;
	C0 = 1'b0;
	#10
	$display("Hold = %b%b%b%b" ,Q3,Q2,Q1,Q0);
	
	#10 $finish;
	end
endmodule
