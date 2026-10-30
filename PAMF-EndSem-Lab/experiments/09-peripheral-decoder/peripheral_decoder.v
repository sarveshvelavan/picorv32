// Q9: PicoRV32 native bus write decoder for 0x40000004.
// Combinational ready completes the valid/ready handshake in the write cycle.
// Byte write strobes update only selected lanes.
module peripheral_decoder (
    input wire clk, input wire reset, input wire mem_valid, input wire [31:0] mem_addr,
    input wire [31:0] mem_wdata, input wire [3:0] mem_wstrb,
    output wire mem_ready, output reg [31:0] data_reg
);
    localparam [31:0] TARGET_ADDR = 32'h40000004;
    wire selected_write = mem_valid && (mem_addr == TARGET_ADDR) && (|mem_wstrb);
    assign mem_ready = selected_write;
    integer lane;
    always @(posedge clk or posedge reset) begin
        if (reset) data_reg <= 32'd0;
        else if (selected_write) for (lane=0; lane<4; lane=lane+1) if (mem_wstrb[lane]) data_reg[8*lane +: 8] <= mem_wdata[8*lane +: 8];
    end
endmodule
