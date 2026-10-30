`timescale 1ns/1ps
module tb_variable_latency_memory;
    reg clk=0, reset=1, mem_valid=0; reg [31:0] mem_addr=0, mem_wdata=0; reg [3:0] mem_wstrb=0;
    wire mem_ready; wire [31:0] mem_rdata; integer wait_cycles=0;
    variable_latency_memory dut(clk, reset, mem_valid, mem_addr, mem_wdata, mem_wstrb, mem_ready, mem_rdata);
    always #10 clk=~clk;
    always @(posedge clk) if (mem_valid && !mem_ready) wait_cycles <= wait_cycles + 1;
    initial begin
        $dumpfile("q4_slowmem.vcd"); $dumpvars(0,tb_variable_latency_memory); #25 reset=0;
        @(negedge clk); mem_valid=1; mem_addr=32'h00000004; mem_wdata=32'h1234ABCD; mem_wstrb=4'hF;
        wait(mem_ready); #1; if (wait_cycles < 4 || wait_cycles > 8) $fatal(1,"Observed wait cycles outside expected 3..7 delay: %0d",wait_cycles-1);
        @(posedge clk); #1; mem_valid=0; mem_wstrb=0;
        if (dut.mem[1] !== 32'h1234ABCD) $fatal(1,"Delayed write failed");
        wait_cycles=0; @(negedge clk); mem_valid=1; mem_addr=32'h00000004; mem_wstrb=0;
        wait(mem_ready); #1; if (wait_cycles < 4 || wait_cycles > 8) $fatal(1,"Read wait cycles outside expected 3..7 delay");
        if (mem_rdata !== 32'h1234ABCD) $fatal(1,"Readback failed");
        @(posedge clk); #1; mem_valid=0;
        $display("Q4 PASS: delayed write/read completed with 3..7-cycle latency"); $finish;
    end
endmodule
