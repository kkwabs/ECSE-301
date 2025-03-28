module  areg (Q3,Q2,Q1,Q0, so, D, clock, C1, C0);
input [3:0]D;
input clock, C1,C0;
output reg Q3,Q2,Q1,Q0,so;


parameter Load= 2'b00, Reset= 2'b01, Shift= 2'b10, Hold= 2'b11;

always @( posedge clock)
begin
	case ( {C1,C0} )
		Reset: {Q3,Q2,Q1,Q0} <= 4'b0000;
		Load : {Q3,Q2,Q1,Q0} <= {D[3],D[2],D[1],D[0]};
		Shift: {Q3,Q2,Q1,Q0} <= {so,Q3,Q2,Q1};
		Hold: {Q3,Q2,Q1,Q0} <= {Q3,Q2,Q1,Q0};
	endcase

	
end
endmodule
