`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000

module one_bit_comparator_structural_tb();
    reg a, b;
    wire greater, less, equal;

    one_bit_comparator_structural DUT (
        .a(a),
        .b(b),
        .greater(greater),
        .less(less),
        .equal(equal)
    );

    initial begin
        string fsdb_file;
        if (!$value$plusargs("fsdbfile+%s", fsdb_file)) begin
            fsdb_file = "default.fsdb"; 
        end
        $fsdbDumpfile(fsdb_file);

        a = 1'b0;
        b = 1'b0;
        #(1);
        assert(greater == 1'b0) else $fatal("Expected greater to be 0, but got %b for a=%b, b=%b", greater, a, b);
        assert(less == 1'b0) else $fatal("Expected less to be 0, but got %b for a=%b, b=%b", less, a, b);
        assert(equal == 1'b1) else $fatal("Expected equal to be 1, but got %b for a=%b, b=%b", equal, a, b);

        a = 1'b0;
        b = 1'b1;
        #(1);
        assert(greater == 1'b0) else $fatal("Expected greater to be 0, but got %b for a=%b, b=%b", greater, a, b);
        assert(less == 1'b1) else $fatal("Expected less to be 1, but got %b for a=%b, b=%b", less, a, b);
        assert(equal == 1'b0) else $fatal("Expected equal to be 0, but got %b for a=%b, b=%b", equal, a, b);

        a = 1'b1;
        b = 1'b0;
        #(1);
        assert(greater == 1'b1) else $fatal("Expected greater to be 1, but got %b for a=%b, b=%b", greater, a, b);
        assert(less == 1'b0) else $fatal("Expected less to be 0, but got %b for a=%b, b=%b", less, a, b);
        assert(equal == 1'b0) else $fatal("Expected equal to be 0, but got %b for a=%b, b=%b", equal, a, b);

        a = 1'b1;
        b = 1'b1;
        #(1);
        assert(greater == 1'b0) else $fatal("Expected greater to be 0, but got %b for a=%b, b=%b", greater, a, b);
        assert(less == 1'b0) else $fatal("Expected less to be 0, but got %b for a=%b, b=%b", less, a, b);
        assert(equal == 1'b1) else $fatal("Expected equal to be 1, but got %b for a=%b, b=%b", equal, a, b);

        $display("All tests passed!");
        $finish();
    end
endmodule
