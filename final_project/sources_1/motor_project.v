`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Jacob Kearin
// 
// Create Date: 11/23/2021 05:04:48 PM
// Design Name: BLDC driver
// Module Name: 
// Project Name: BLDC_driver
// Target Devices: Basys-3
// Tool Versions: 
// Description: 
//      Program was designed for Basys-3 development board, IO may need to be modified for use with other products
//      Program was designed around BODINE BLDC 12V gearmotor with built-in hall sensors and 43.9:1 reduction ratio
//      For use with other BLDC, modifications to program may be necessary. See annotations below for guidance
// 
//////////////////////////////////////////////////////////////////////////////////


//module for creating motor driver signals
//see motor datasheet
module motor_driver(clk, enable, fwd, Apos, Aneg, Bpos, Bneg, Cpos, Cneg, hall);
input clk, enable, fwd; 
input [2:0] hall;
output Apos, Aneg, Bpos, Bneg, Cpos, Cneg; 

//6 bit value {A+, A-, B+, B-, C+, C-} for each state
parameter s0 = 6'b000000;   // use of pull-up NMOS  changes all to active high signals
parameter s1 = 6'b100001;   // without pull-up, A+, B+, C+ are active low
parameter s2 = 6'b100100;   
parameter s3 = 6'b000110;   
parameter s4 = 6'b010010;
parameter s5 = 6'b011000;
parameter s6 = 6'b001001;

reg [5:0] state = s0;

assign {Apos, Aneg, Bpos, Bneg, Cpos, Cneg} = state;    

always @(posedge clk) begin  
    if (!enable) state <= s0;
    else case (state)
        s0: begin
            if (hall == 3'b001) state <= s1;
            else if (hall == 3'b000) state <= s2;   // for sensorless BLDC either change
            else if (hall == 3'b100) state <= s3;   // this section to start at a specific 
            else if (hall == 3'b110) state <= s4;   // state OR set top module hall value
            else if (hall == 3'b111) state <= s5;   // to 1'b000, NOT BOTH
            else if (hall == 3'b011) state <= s6;
            else state <= s0;
        end
        s1: state <= enable ? (fwd ? s2 : s6) : s0;
        s2: state <= enable ? (fwd ? s3 : s1) : s0;
        s3: state <= enable ? (fwd ? s4 : s2) : s0;
        s4: state <= enable ? (fwd ? s5 : s3) : s0;
        s5: state <= enable ? (fwd ? s6 : s4) : s0;
        s6: state <= enable ? (fwd ? s1 : s5) : s0;
    endcase 
end
endmodule


//module for taking adc input from potentiometer for speed control
//outputs a 16 bit value with most significant 12 bits being and output
module adc_controller(CLK, jxADC, data_out);
input CLK;
input [6:0] jxADC;
output reg [15:0] data_out; // 12 bit ADC data within most significant of 16 bit output

wire enable;
wire ready;
wire [15:0] data; 

xadc_wiz_2  XLXI_7 (   
        .daddr_in(8'h1f),
        .dclk_in(CLK), 
        .den_in(enable), 
        .di_in(0), 
        .dwe_in(0),
        .vauxp15(jxADC[3]),
        .vauxn15(jxADC[7]), 
        .do_out(data),
        .eoc_out(enable),
        .drdy_out(ready));

always @(posedge CLK) begin
    data_out <= data; 
end
endmodule


// main motor driver module
// see schematic attached for circuit layout
module main_driver (clk, JXADC, sw, JA, JC);
input clk;
input [7:0] JXADC;
input [15:0] sw;    // basys-3 {sw0, sw1} = enable, fwd
input [7:0] JA;     // basys-3 JA0, JA1, JA2 for 3 bit hall sensors
                    // if no hall sensors, set value to 1'b000
output [7:0] JC;    // basys-3 JB0-6 for output signals to 3 phase transistor array
                    // use of pull-up NMOS required for ABC positive inputs

reg [31:0] freq_counter = 0;
reg var_clk = 0;
wire [15:0] data;   
parameter min_count = 84996;    // minimum frequency counter
                                // (100Mhz clk / (2 * max_motor_freq(hz))/6states = min_count
                                // see excel file sheet 2 for details
adc_controller dut0(clk, JXADC, data);

always @(posedge clk) begin
    freq_counter <= freq_counter +1;
    if (freq_counter >= (min_count + ((4096 - data[15:4]) ** 2))) begin 
        freq_counter <= 0;
        var_clk <= !var_clk;
    end
end

motor_driver dut1(var_clk, sw[0], sw[1], JC[0], JC[1], JC[2], JC[3], JC[4], JC[5], JA[2:0]);

endmodule
