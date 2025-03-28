module multiplier(product, multiplicand, multiplier, start, reset, clock, done);

input [3:0] multiplicand;
input [3:0] multiplier;
input start, reset, clock;

output [7:0] product;
output done;

wire[3:0] M;
wire[3:0] A;
wire[3:0] Q;
wire[3:0] sum;
wire Qm1, LM, LA0, LA1, LQ0, LQ1, AS, co;

mreg M_reg(.Q3(M[3]), .Q2(M[2]), .Q1(M[1]), .Q0(M[0]),
         .D3(multiplicand[3]), .D2(multiplicand[2]), .D1(multiplicand[1]), .D0(multiplicand[0]),
         .clock(Clock), .C0(LM));
  
  qreg Q_reg(.Q3(Q[3]), .Q2(Q[2]), .Q1(Q[1]), .Q0(Q[0]), .Qm1(Qm1),
         .D3(multiplier[3]), .D2(multiplier[2]), .D1(multiplier[1]), .D0(multiplier[0]),
         .A0(A[0]), .clock(Clock), .C1(LQ1), .C0(LQ0));
  
  areg A_reg(.Q3(A[3]), .Q2(A[2]), .Q1(A[1]), .Q0(A[0]),
         .D3(sum[3]), .D2(sum[2]), .D1(sum[1]), .D0(sum[0]),
         .clock(Clock), .C1(LA1), .C0(LA0));
  
  addsub addsub_unit(.co(co),
             .r3(sum[3]), .r2(sum[2]), .r1(sum[1]), .r0(sum[0]),
             .a3(A[3]), .a2(A[2]), .a1(A[1]), .a0(A[0]),
             .b3(M[3]), .b2(M[2]), .b1(M[1]), .b0(M[0]),
             .control(AS));
  
  FSM controller(.LM(LM), .LA0(LA0), .LA1(LA1), .LQ0(LQ0), .LQ1(LQ1),
          .Qm1(Qm1), .Q0(Q[0]), .AS(AS), .reset(Reset),
          .start(Start), .done(Done), .clock(Clock));
  
  assign Product = {A, Q};
endmodule


