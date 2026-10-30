`timescale 1ns/1ps
module tb_temperature_calibration_fsm;
    reg clk=0, reset=1, start=0; reg [15:0] temperature=16'd25, calibration_factor=16'd4;
    wire [31:0] result; wire valid;
    temperature_calibration_fsm dut(clk, reset, start, temperature, calibration_factor, result, valid);
    always #5 clk=~clk;
    initial begin
        $dumpfile("q12_fsm.vcd"); $dumpvars(0,tb_temperature_calibration_fsm); #12 reset=0;
        @(negedge clk) start=1; @(negedge clk) start=0; wait(valid); #1;
        if (result !== 32'd100) $fatal(1,"Incorrect calibration product");
        if (!valid) $fatal(1,"valid not asserted in DONE");
        @(negedge clk); if (valid) $fatal(1,"valid remained high after DONE");
        $display("Q12 PASS: 25 * 4 = 100; valid asserted only in DONE"); $finish;
    end
endmodule
