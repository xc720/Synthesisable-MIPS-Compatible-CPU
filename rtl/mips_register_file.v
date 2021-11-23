module mips_register_file(
    input logic clk,
    input logic reset,
    input logic write_enable,

    input logic[4:0] src_addr_1,
    input logic[4:0] src_addr_2,
    input logic[4:0] dst_addr,
    input logic[31:0] write_data,

    output logic[31:0] src_data_1,
    output logic[31:0] src_data_2,
    output logic[31:0] src_data_v0

);

    logic[31:0] register[31:0];

    always_ff @(posedge clk) begin
        // reset register
        if(reset) begin
            for(int i = 0; i < 32; i ++)
                register[i] <= 0;
        end
        // write to register
        else begin
            if(write_enable) begin
                register[dst_addr] <= write_data;
            end
        end
    end

    // return data
    assign src_data_1 = (src_addr_1 == 0) ? 32'b0 : register[src_addr_1];
    assign src_data_2 = (src_addr_2 == 0) ? 32'b0 : register[src_addr_2];
    assign src_data_v0 = register[2];

endmodule