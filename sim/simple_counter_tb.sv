`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module simple_counter_tb();
    reg reset = 1'b1;
    reg clk = 1'b0;
    wire [1:0] counter;

    simple_counter DUT (
        .clk(clk),
        .reset(reset),
        .counter_out(counter)
    );

    always #(4) clk <= ~clk;

    initial begin
        string fsdb_file;
        if (!$value$plusargs("fsdbfile+%s", fsdb_file)) begin
            fsdb_file = "default.fsdb"; 
        end
        $fsdbDumpfile(fsdb_file);

        #(10)
        reset = 1'b0;

        assert(counter == 2'b00) else $fatal("Expected counter to be 00 after a long reset, but got %b", counter);
        #(4)
        assert(counter == 2'b01) else $fatal("Expected counter to be 01, but got %b", counter);
        #(8)
        assert(counter == 2'b10) else $fatal("Expected counter to be 10, but got %b", counter);
        #(8)
        assert(counter == 2'b11) else $fatal("Expected counter to be 11, but got %b", counter);
        #(8)
        assert(counter == 2'b00) else $fatal("Expected counter to be 00, but got %b", counter);
        #(8)
        assert(counter == 2'b01) else $fatal("Expected counter to be 01, but got %b", counter);

        #(1)
        reset = 1'b1;
        #(1)
        assert(counter == 2'b00) else $fatal("Expected counter to be 00 after a reset, but got %b", counter);

        $display("All tests passed!");
        $finish();
    end
endmodule
