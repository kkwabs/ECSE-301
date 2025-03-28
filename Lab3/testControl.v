module testcontrol;

  wire LM, LA0, LA1, LQ0, LQ1, AS, done;
 
  reg clock, Qm1, Q0, start, reset;
  

  FSM UUT (
    .LM(LM), .LA0(LA0), .LA1(LA1),
    .LQ0(LQ0), .LQ1(LQ1),
    .AS(AS), .done(done),
    .clock(clock), .Qm1(Qm1), .Q0(Q0),
    .start(start), .reset(reset)
  );
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
 
  initial begin
   
    reset = 1; start = 0;
    Qm1 = 0; Q0 = 0;
    #10;
    reset = 0;
    #10;
    
    start = 1;
    #10;
    start = 0;
    
    Q0 = 1; Qm1 = 0;
    #10;
    
    Q0 = 0; Qm1 = 1;
    #10;
    
    Q0 = 0; Qm1 = 0;
    #10;
    
    Q0 = 1; Qm1 = 1;
    #10;
    
    #50;
    
    $finish;
  end
  
  // Monitor signals (excluding simulation time)
  initial begin
    $display("clk | reset | start | Qm1 Q0 | LM | LA1 LA0 | LQ1 LQ0 | AS | done");
    $monitor("%b   |   %b   |   %b   |  %b %b | %b |   %b %b   |  %b %b |  %b | %b",
             clock, reset, start, Qm1, Q0, LM, LA1, LA0, LQ1, LQ0, AS, done);
  end

endmodule
