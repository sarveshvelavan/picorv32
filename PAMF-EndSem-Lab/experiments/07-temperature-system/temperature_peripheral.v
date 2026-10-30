// Q7: Read-only sensor peripheral on the PicoRV32 native memory interface.
// Other addresses must be handled by the system memory decoder.
module temperature_peripheral (
    input wire [31:0] mem_addr, input wire mem_valid, input wire [3:0] mem_wstrb,
    input wire [31:0] sensor_value, output wire mem_ready, output wire [31:0] mem_rdata
);
    localparam [31:0] TEMP_ADDR = 32'h40000010;
    wire selected_read = mem_valid && (mem_addr == TEMP_ADDR) && (mem_wstrb == 4'b0000);
    assign mem_ready = selected_read; assign mem_rdata = sensor_value;
endmodule
