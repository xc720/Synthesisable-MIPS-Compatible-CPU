`timescale 1ns/100ps

module mux_1(
    input logic[4:0] source_2,
    input logic[4:0] dest,
    input logic select,
    output logic[4:0] mux_1_output
);

    always_comb begin
        if (select == 0) begin
            mux_1_output = source_2;
        end
        else begin
            mux_1_output = dest;
        end


    end

endmodule




