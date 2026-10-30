`timescale 1ns/1ps
module tb_temperature_peripheral;
    reg mem_valid=0; reg [31:0] mem_addr=0, sensor_value=32'd25; reg [3:0] mem_wstrb=0;
    wire mem_ready; wire [31:0] mem_rdata;
    temperature_peripheral dut(mem_addr, mem_valid, mem_wstrb, sensor_value, mem_ready, mem_rdata);
    initial begin
        $dumpfile("q7_temp.vcd"); $dumpvars(0,tb_temperature_peripheral);
        #5 mem_valid=1; mem_addr=32'h40000010; mem_wstrb=0; #1;
        if (!mem_ready || mem_rdata !== 32'd25) $fatal(1,"Temperature read failed");
        #4 mem_addr=32'h40000014; #1;
        if (mem_ready) $fatal(1,"Peripheral acknowledged wrong address");
        $display("Q7 PASS: matching read selected and wrong address ignored"); $finish;
    end
endmodule
