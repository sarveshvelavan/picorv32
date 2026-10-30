`timescale 1ns/1ps
// Q2: Bus smoke-test only. A constant NOP responder checks that the core
// can fetch continuously; it does NOT verify application firmware.
module tb_picorv32_framework;
    reg clk = 1'b0; reg resetn = 1'b0;
    wire mem_valid, mem_instr; wire [31:0] mem_addr, mem_wdata; wire [3:0] mem_wstrb;
    wire mem_ready = mem_valid; wire [31:0] mem_rdata = 32'h00000013;
    integer fetch_count = 0;
    always #10 clk = ~clk;
    picorv32_system dut(.clk(clk), .resetn(resetn), .mem_valid(mem_valid), .mem_instr(mem_instr), .mem_ready(mem_ready), .mem_addr(mem_addr), .mem_wdata(mem_wdata), .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata));
    always @(posedge clk) if (resetn && mem_valid && mem_ready && mem_instr) fetch_count <= fetch_count + 1;
    initial begin
        $dumpfile("q2_picorv32.vcd"); $dumpvars(0, tb_picorv32_framework);
        #200 resetn = 1'b1; #1000;
        if (fetch_count == 0) $fatal(1, "No instruction fetch observed");
        $display("Q2 bus smoke-test PASS: instruction fetches=%0d", fetch_count); $finish;
    end
endmodule
