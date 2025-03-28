module mreg (D3,D2,D1,D0, Q3,Q2,Q1,Q0, clock, C1,C0);
input D3,D2,D1,D0;
input clock, C1;
output reg Q3,Q2,Q1,Q0,C0;


always @ (posedge clock)

begin

	{Q3,Q2,Q1,Q0} <= {D3,D2,D1,D0};
end

endmodule