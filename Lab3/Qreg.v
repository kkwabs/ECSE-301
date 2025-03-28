module  qreg (D3,D2,D1,D0, Q3,Q2,Q1,Q0, clock, C1, C0, si);
input   D3,D2,D1,D0;
input  clock, C1,C0, si;
output  Q3,Q2,Q1,Q0;

reg Q3,Q2,Q1,Q0;

parameter Load=2'b00 , Shift=2'b01 , Hold=2'b10 ;

always @( posedge clock)
begin
	case ( {C1,C0} )
		Load : {Q3,Q2,Q1,Q0} <= {D3,D2,D1,D0};
		Shift: {Q3,Q2,Q1,Q0} <= {si,Q3,Q2,Q1};
		Hold: {Q3,Q2,Q1,Q0} <= {Q3,Q2,Q1,Q0};
	endcase
end
endmodule
