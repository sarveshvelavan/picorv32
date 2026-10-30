// Q12: Three-state unsigned temperature calibration multiplier.
module temperature_calibration_fsm (
    input wire clk, input wire reset, input wire start,
    input wire [15:0] temperature, input wire [15:0] calibration_factor,
    output reg [31:0] result, output wire valid
);
    localparam [1:0] IDLE=2'd0, COMPUTE=2'd1, DONE=2'd2;
    reg [1:0] state, next_state;
    reg [15:0] temperature_reg, factor_reg;
    assign valid = (state == DONE);
    always @(posedge clk or posedge reset) begin
        if (reset) begin state<=IDLE; temperature_reg<=0; factor_reg<=0; result<=0; end
        else begin
            state<=next_state;
            if (state==IDLE && start) begin temperature_reg<=temperature; factor_reg<=calibration_factor; end
            if (state==COMPUTE) result<=temperature_reg * factor_reg;
        end
    end
    always @(*) begin
        next_state=state;
        case (state)
            IDLE: if (start) next_state=COMPUTE;
            COMPUTE: next_state=DONE;
            DONE: next_state=IDLE;
            default: next_state=IDLE;
        endcase
    end
endmodule
