`timescale 1ns/1ps
// Q3: Required structural testbench: instantiates PicoRV32 via the wrapper,
// with a 50 MHz clock and resetn held low for exactly 200 ns.
module tb_picorv32_reset;
    wire clk, resetn; wire mem_valid, mem_instr; wire [31:0] mem_addr, mem_wdata; wire [3:0] mem_wstrb;
    wire mem_ready = mem_valid; wire [31:0] mem_rdata = 32'h00000013;
    clock_reset_source clock_and_reset(.clk(clk), .resetn(resetn));
    picorv32_system dut(.clk(clk), .resetn(resetn), .mem_valid(mem_valid), .mem_instr(mem_instr), .mem_ready(mem_ready), .mem_addr(mem_addr), .mem_wdata(mem_wdata), .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata));
    initial begin
        $dumpfile("q3_picorv32_reset.vcd"); $dumpvars(0, tb_picorv32_reset);
        #199; if (resetn !== 1'b0) $fatal(1, "resetn released before 200 ns");
        #1; #0.001; if (resetn !== 1'b1) $fatal(1, "resetn not released at 200 ns");
        #400; $display("Q3 reset timing PASS"); $finish;
    end
endmodule
