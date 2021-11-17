`timescale 1ns / 1ps

module HW3_2(A, B, C, F1);
input A, B, C;
output F1;
assign F1 = (A) ? (B ? 1 : !C) : (B ? 0 : C);
endmodule

module HW3_2_tb;
reg A, B, C;
wire F1;

HW3_2 dut(A, B, C, F1);

initial begin
A = 0;
B = 0;
C = 0;
#10
A = 0;
B = 0;
C = 1;
#10
A = 0;
B = 1;
C = 0;
#10
A = 0;
B = 1;
C = 1;
#10
A = 1;
B = 0;
C = 0;
#10
A = 1;
B = 0;
C = 1;
#10
A = 1;
B = 1;
C = 0;
#10
A = 1;
B = 1;
C = 1;

end
endmodule
