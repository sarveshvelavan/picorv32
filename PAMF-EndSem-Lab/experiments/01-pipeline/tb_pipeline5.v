`timescale 1ns/1ps
module tb_pipeline5;
    reg clk = 1'b0, reset = 1'b1;
    pipeline5 dut(.clk(clk), .reset(reset));
    always #10 clk = ~clk;
    initial begin
        $dumpfile("q1_pipeline.vcd"); $dumpvars(0, tb_pipeline5);
        #25 reset = 1'b0;
        repeat (5) @(posedge clk);
        #1;
        if ({dut.if_id, dut.id_ex, dut.ex_mem, dut.mem_wb} !== {8'd4,8'd3,8'd2,8'd1}) $fatal(1, "Pipeline stage progression mismatch");
        $display("Q1 PASS: pipeline registers contain successive instruction tokens"); $finish;
    end
endmodule
