`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2021 12:16:19 PM
// Design Name: 
// Module Name: Lab_4_part_1
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

module FA (A, B, Cin, Cout, SUM);
 input A, B, Cin;
 output Cout, SUM;

 wire w1;
 wire w2;
 wire w3;

 xor x1(w1, A, B);
 xor x2(SUM, w1, Cin);
 and a1(w2, Cin, w1);
 and a2(w3, A, B);
 or o1(Cout, w2, w3);
endmodule


module lab_4_part_1 (sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, led10, led11, led12, led13, led14, led15);
 input sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8;
 output led10, led11, led12, led13, led14, led15;

 wire cw1, cw2, cw3, xw0, xw1, xw2, xw3;

 xor (xw0, sw5, sw0);
 xor (xw1, sw6, sw0);
 xor (xw2, sw7, sw0);
 xor (xw3, sw8, sw0);
 xor (led15, cw3, led14);

 FA FA0(sw1, xw0, sw0, cw1, led10);
 FA FA1(sw2, xw1, cw1, cw2, led11);
 FA FA2(sw3, xw2, cw2, cw3, led12);
 FA FA3(sw4, xw3, cw3, led14, led13);
 
endmodule

