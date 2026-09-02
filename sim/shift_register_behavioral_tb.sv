`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module shift_register_behavioral_tb();
    reg in;
    reg [3:0] prev_out;
    reg clk = 1'b0;
    wire [3:0] out;

    shift_register_behavioral DUT (
        .in(in),
        .clk(clk),
        .out(out)
    );

    always #(4) clk <= ~clk;

    always @(posedge clk) prev_out <= out;

    integer i;
    
    initial begin
        string fsdb_file;
        if (!$value$plusargs("fsdbfile+%s", fsdb_file)) begin
            fsdb_file = "default.fsdb"; 
        end
        $fsdbDumpfile(fsdb_file);

        in = 1'b0;
        #(32)
        assert(out == 4'b0000) else $fatal("Expected out to be 0000, but got %b after in=%b for 4 cycles", out, in);

        for(i = 0; i < 16; i = i + 1) begin
            in = $urandom() % 2;
            #(8);
            assert(out == {prev_out[2:0], in}) else $fatal("Expected out to be %b, but got %b a cycle after in=%b", {prev_out[2:0], in}, out, in);
        end

        $display("All tests passed!");
        $finish();
    end
endmodule
