// Q3: Simulation-only clock/reset source; not synthesizable hardware.
`timescale 1ns/1ps
module clock_reset_source(output reg clk, output reg resetn);
    initial begin clk = 1'b0; forever #10 clk = ~clk; end
    initial begin resetn = 1'b0; #200 resetn = 1'b1; end
endmodule
