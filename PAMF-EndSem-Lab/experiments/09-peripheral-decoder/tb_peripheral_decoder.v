`timescale 1ns/1ps
module tb_peripheral_decoder;
    reg clk=0, reset=1, mem_valid=0; reg [31:0] mem_addr=0, mem_wdata=0; reg [3:0] mem_wstrb=0;
    wire mem_ready; wire [31:0] data_reg;
    peripheral_decoder dut(clk, reset, mem_valid, mem_addr, mem_wdata, mem_wstrb, mem_ready, data_reg);
    always #10 clk=~clk;
    initial begin
        $dumpfile("q9_decoder.vcd"); $dumpvars(0,tb_peripheral_decoder); #25 reset=0;
        @(negedge clk); mem_valid=1; mem_addr=32'h40000004; mem_wdata=32'h1234ABCD; mem_wstrb=4'hF;
        #1 if (!mem_ready) $fatal(1,"Target write not acknowledged");
        @(posedge clk); #1; if (data_reg !== 32'h1234ABCD) $fatal(1,"Full word write failed");
        @(negedge clk); mem_valid=0; mem_wstrb=0;
        @(negedge clk); mem_valid=1; mem_addr=32'h40000008; mem_wdata=32'hFFFFFFFF; mem_wstrb=4'hF;
        #1 if (mem_ready) $fatal(1,"Wrong address acknowledged");
        @(posedge clk); #1; if (data_reg !== 32'h1234ABCD) $fatal(1,"Wrong address changed register");
        $display("Q9 PASS: addressed write captured; other address ignored"); $finish;
    end
endmodule
