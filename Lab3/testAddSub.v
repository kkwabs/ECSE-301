module testaddsub;

reg a3,a2,a1,a0;
reg b3,b2,b1,b0,control;
wire co,r3,r2,r1,r0;

	addsub UUT (co,r3,r2,r1,r0,a3,a2,a1,a0,b3,b2,b1,b0,control);

	initial
	begin
		$monitor($time,,"A=%b B=%b Cntrl=%b AddSub=%b",
				{a3,a2,a1,a0},
				{b3,b2,b1,b0},
				control,
				{co,r3,r2,r1,r0});
		{a3,a2,a1,a0} = 10;  
		{b3,b2,b1,b0}= 5; 
		control=0; 
		#5;
		control=1;
	end
endmodule
