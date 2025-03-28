module FSM( LM, LA0,LA1,LQ0,LQ1, Qm1, Q0, AS, reset, start, done, clock);
        output  LM,    // Register M control = 0 M Holds 1 M Loads
		LA0,LA1, // Register A control
		LQ0,LQ1, // Register Q control
		AS,	 // AddSub control
		done;    // Done=0 indicated working, 1 otherwise
        input 	clock,   // System Clock
		Qm1, Q0, // previous and current lowest bit of Q
		start,   // askink to start multiplying
		reset;   // Reset initial states

        reg  	[1:0] count;
        reg  	LM, LA0,LA1,LQ0,LQ1,AS;

//internal FSM state declarations
        reg [2:0] NEXT_STATE; reg [2:0] ST;


// state encodings
        parameter	s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, 
			s3 = 3'b011, s4 = 3'b100;

// Control Signal Encoding
        parameter Load  = 2'b00, Reset= 2'b01, Shift= 2'b10, Hold= 2'b11,
                  Add   = 1'b0 , Sub   = 1'b1 ,
		  LD    = 1'b1 , HD    = 1'b0;


// Combinational Circuit part
function [2:0] fsm;
input [2:0] fsm_PRES_STATE;

reg [2:0] FST;

begin
        case (fsm_PRES_STATE)
        s0:
	if ( start == 1'b1 ) 
		begin
			LM = LD; 
			{LA1,LA0} = Reset; 
			{LQ1,LQ0} = Load; 
			AS = Add ;
			FST  = s1; 
		end
	else 
		begin
			LM = HD ; 
			{LA1,LA0} = Hold; 
			{LQ1,LQ0} = Hold; 
			AS = Sub ;
			FST  = s0;
		end
        s1: begin
                case ( {Q0,Qm1} )
                2'b01: 
		begin
			LM = HD	; 
			{LA1,LA0} = Load; 
			{LQ1,LQ0} = Hold; 
			AS =  Add;
			FST  = s2; 
		end
                2'b10: 
	 	begin
			LM = HD; 
			{LA1,LA0} = Load; 
			{LQ1,LQ0} = Hold; 
			AS =  Sub;
			FST  = s3;
		end
                2'b00, 
		2'b11: 
		begin
			LM = HD; 
			{LA1,LA0}= Hold; 
			{LQ1,LQ0} = Hold; 
			AS =  Add;
			FST  = s4;
		end
		endcase
           end
        s2: begin
		LM = HD; 
		{LA1,LA0} = Shift; 
		{LQ1,LQ0} = Shift; 
		AS = Add;
		FST  = s4; 
	end
        s3: begin
		LM = HD; 
		{LA1,LA0} = Shift; 
		{LQ1,LQ0} = Shift;
		AS =  Sub;
		FST  = s4;
	    end
        s4: begin
                LM =  HD; 
		{LA1,LA0} = Shift; 
		{LQ1,LQ0} = Shift; 
		AS =  Add;
		if( count == 2'b11 )
			begin
                       	 	FST = s0;
			end
                else
                	begin
                        	FST = s1;
                	end
	   end
	default: begin
                FST     = s0;
		LM = HD ; 
		{LA1,LA0} = Hold; 
		{LQ1,LQ0} = Hold; 
		AS = Add ;
	  end
        endcase
	fsm = FST;
end
endfunction

// Evaluating Combinational Logic
always @(start or ST or Qm1 or Q0)
         NEXT_STATE = fsm(ST);

// Evaluating Sequential  Logic
always @(posedge clock)
begin
	if( reset )
		begin
			ST = s0;
			count = 2'b11;
		end
	else
		begin
        		ST = NEXT_STATE ;
		end

end

endmodule
