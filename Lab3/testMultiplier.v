module testMultiplier;

  reg  [3:0] multiplicand;
  reg  [3:0] multiplier;
  reg        start, reset, clock;
  
  
  wire [7:0] product;
  wire       done;
  
  
  multiplier uut (
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .start(start),
    .reset(reset),
    .clock(clock),
    .done(done),
    .product(product)
  );
  
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
  
  initial begin
  
    reset = 1; start = 0;
    multiplicand = 4'b0000;
    multiplier   = 4'b0000;
    #10;
    
    reset = 0;
    #10;
    
    
    multiplicand = 4'd4;
    multiplier   = 4'd3;
    start = 1;  
    #10;
    start = 0;  
    
    
    wait(done == 1);
    #20; 
    
    $display("Test 1: Multiplicand = %d, Multiplier = %d, Product = %d", 
              multiplicand, multiplier, product);
    #20;
    
    
    reset = 1;   
    #10;
    reset = 0;
    multiplicand = 4'd5;
    multiplier   = 4'd7;
    start = 1;
    #10;
    start = 0;
    
    wait(done == 1);
    #20;
    
    $display("Test 3: Multiplicand = %d, Multiplier = %d, Product = %d", 
              multiplicand, multiplier, product);
    #20;
    
    $finish;
  end
  
endmodule
