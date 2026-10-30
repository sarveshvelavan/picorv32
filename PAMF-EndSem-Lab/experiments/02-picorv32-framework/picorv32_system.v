// Q2: PicoRV32 core integration wrapper. Uses the official picorv32.v
// in the parent repository; this file does not reimplement the processor.
module picorv32_system (
    input wire clk, input wire resetn,
    output wire mem_valid, output wire mem_instr,
    input wire mem_ready,
    output wire [31:0] mem_addr, output wire [31:0] mem_wdata,
    output wire [3:0] mem_wstrb, input wire [31:0] mem_rdata
);
    picorv32 #(.PROGADDR_RESET(32'h00000000)) cpu (
        .clk(clk), .resetn(resetn), .mem_valid(mem_valid), .mem_instr(mem_instr),
        .mem_ready(mem_ready), .mem_addr(mem_addr), .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata),
        .pcpi_wr(1'b0), .pcpi_rd(32'b0), .pcpi_wait(1'b0), .pcpi_ready(1'b0), .irq(32'b0)
    );
endmodule
