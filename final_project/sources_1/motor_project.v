`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Jacob Kearin
// 
// Create Date: 11/23/2021 05:04:48 PM
// Design Name: BLDC driver
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// variable frquency driver for 3 phase BLDC motor with included hall sensors
// 
// Dependencies: 
//
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module motor_driver(clk, enable, fwd, hall, Apos, Aneg, Bpos, Bneg, Cpos, Cneg, ADCinput);
input clk, enable, fwd; 
input [2:0] hall;
input [7:0] ADCinput;   //ABC hall sensors
output Apos, Aneg, Bpos, Bneg, Cpos, Cneg; //0 is ground bit, 1 is +12V bit, 2 is -12V bit

wire abcclk;
//module for abc clock reference based on user input


//6 bit value for A+, A-, B+, B-, C+, C- in each state
parameter s0 = 6'b000000;
parameter s1 = 6'b100001;
parameter s2 = 6'b100100;
parameter s3 = 6'b000110;
parameter s4 = 6'b010010;
parameter s5 = 6'b011000;
parameter s6 = 6'b001001;

reg [5:0] state = s0;

assign {Apos, Aneg, Bpos, Bneg, Cpos, Cneg} = state;

always @(posedge clk) begin  //change to abcclk when module finished
    if (!enable) state <= s0;
    else case (state)
        s0: begin
            if (hall == 001) state <= s1;
            else if (hall == 000) state <= s2;
            else if (hall == 100) state <= s3;
            else if (hall == 110) state <= s4;
            else if (hall == 111) state <= s5;
            else if (hall == 011) state <= s6;
            else state <= s0;
        end
        s1: assign state = enable ? (fwd ? s2 : s6) : s0;
        s2: assign state = enable ? (fwd ? s3 : s1) : s0;
        s3: assign state = enable ? (fwd ? s4 : s2) : s0;
        s4: assign state = enable ? (fwd ? s5 : s3) : s0;
        s5: assign state = enable ? (fwd ? s6 : s4) : s0;
        s6: assign state = enable ? (fwd ? s1 : s5) : s0;
        
    endcase
end
endmodule
