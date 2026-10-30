// Q1: Compact stage-register model for IF/ID/EX/MEM/WB overlap.
// This is a pipeline timing demonstration, not a complete RISC-V CPU.
module pipeline5(input wire clk, input wire reset);
    reg [7:0] fetch_pc;
    reg [7:0] if_id, id_ex, ex_mem, mem_wb;
    always @(posedge clk or posedge reset) begin
        if (reset) begin fetch_pc <= 0; if_id <= 0; id_ex <= 0; ex_mem <= 0; mem_wb <= 0; end
        else begin if_id <= fetch_pc; id_ex <= if_id; ex_mem <= id_ex; mem_wb <= ex_mem; fetch_pc <= fetch_pc + 1'b1; end
    end
endmodule
