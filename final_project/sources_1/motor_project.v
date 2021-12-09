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
// brushless gearmotor that this was designed for has 0-98hz variability
// for use with BLDC with different frequency limitations, the primary module "main_driver" will need modifications to max counters and multipliers. 
//
// Revision 0.01 - File Created
// Additional Comments:
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
            else if (hall == 3'b000) state <= s2;
            else if (hall == 3'b100) state <= s3;
            else if (hall == 3'b110) state <= s4;
            else if (hall == 3'b111) state <= s5;
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
module adc_counter(CLK, jxADC, data_out);
input CLK;
input [6:0] jxADC;
output reg [15:0] data_out;

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
    data_out <= data; //((data[15:4] * 98) / 4096); //data;
end
endmodule


//motor driver module
//see schematic attached for circuit layout
module main_driver (clk, JXADC, sw, JA, JB);
input clk;
input [7:0] JXADC;
input [15:0] sw;    // basys-3 {sw0, sw1} = enable, fwd
input [7:0] JA;     // basys-3 JA0, JA1, JA2 for 3 bit hall sensors
                    // if no hall sensors, set value to 1'b000
output [5:0] JB;    // basys-3 JB0-6 for output signals to 3 phase transistor array
                    // use of pull-up NMOS required for ABC positive inputs

reg [31:0] counter = 0;
reg freq_clk = 0;
wire [15:0] data;

parameter min_count = 510200;   // half of minimum frequency counter
                                // 100Mhz clk / (2 * max_motor_freq)

adc_counter countdut(clk, JXADC, data);

always @(posedge clk) begin
    counter <= counter +1;
    if (counter >= (min_count + ((4096 - data[15:4]) ** 2))) begin 
        counter <= 0;
        freq_clk <= !freq_clk;
    end
end

motor_driver dut(freq_clk, sw[0], sw[1], JB[0], JB[1], JB[2], JB[3], JB[4], JB[5], JA[2:0]);

endmodule

//addition of PMOD display WIP
