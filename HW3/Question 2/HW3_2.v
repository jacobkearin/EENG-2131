`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 05:06:08 PM
// Design Name: 
// Module Name: HW3_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
