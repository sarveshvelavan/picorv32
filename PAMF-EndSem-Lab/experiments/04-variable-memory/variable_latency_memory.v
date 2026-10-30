// Q4: PicoRV32 native memory bus model with random 3..7 clock latency.
// Supports byte-strobed writes and registered read data.
module variable_latency_memory (
    input wire clk, input wire reset, input wire mem_valid, input wire [31:0] mem_addr,
    input wire [31:0] mem_wdata, input wire [3:0] mem_wstrb,
    output wire mem_ready, output reg [31:0] mem_rdata
);
    localparam IDLE = 2'd0, WAIT = 2'd1, RESP = 2'd2;
    reg [1:0] state; reg [31:0] addr_r, wdata_r; reg [3:0] wstrb_r, wait_count;
    reg [31:0] mem [0:255]; integer i;
    assign mem_ready = (state == RESP);
    always @(posedge clk or posedge reset) begin
        if (reset) begin state <= IDLE; addr_r <= 0; wdata_r <= 0; wstrb_r <= 0; wait_count <= 0; mem_rdata <= 0; end
        else case (state)
            IDLE: if (mem_valid) begin addr_r <= mem_addr; wdata_r <= mem_wdata; wstrb_r <= mem_wstrb; wait_count <= $urandom_range(3, 7); state <= WAIT; end
            WAIT: if (wait_count > 1) wait_count <= wait_count - 1'b1;
                  else begin
                      if (|wstrb_r) for (i=0; i<4; i=i+1) if (wstrb_r[i]) mem[addr_r[9:2]][8*i +: 8] <= wdata_r[8*i +: 8];
                      mem_rdata <= mem[addr_r[9:2]]; state <= RESP;
                  end
            RESP: state <= IDLE;
            default: state <= IDLE;
        endcase
    end
endmodule
