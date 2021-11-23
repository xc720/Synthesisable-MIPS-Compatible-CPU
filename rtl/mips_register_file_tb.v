`timescale 1ns / 1ps
module mips_register_file_tb(
);
    reg [31:0] write_data;
    reg [4:0] src_addr_1;
    reg [4:0] src_addr_2;
    reg [4:0] dst_addr;
    wire [31:0] src_data_1;
    wire [31:0] src_data_2;
    wire [31:0] src_data_v0;
    reg clk;
    reg reset;
    reg write_enable;

    mips_register_file inst_reg(
        .write_data(write_data),
        .src_addr_1(src_addr_1),
        .src_addr_2(src_addr_2),
        .dst_addr(dst_addr),
        .src_data_1(src_data_1),
        .src_data_2(src_data_2),
        .src_data_v0(src_data_v0),
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable)
    );
    
    initial begin
        $timeformat(-9, 1, " ns", 100);
        $dumpfile("mips_register_file_tb.vcd");
        $dumpvars(0, mips_register_file_tb);

        /* Clock low. */
        clk = 0;
        reset = 1;
        dst_addr=0;
        write_enable=0;
        write_data=0;

        /* Rising edge */
        #5 clk = 1;

        /* Falling edge */
        #5 clk = 0;
        /* Check outputs */
        assert(src_data_1==0);
        /* Drive new inputs */
        reset = 0;
        src_addr_1 = 1;
        dst_addr = 0;
        write_data = 3;
        write_enable = 1;

        /* Rising edge */
        #5 clk = 1;

        /* Falling edge */
        #5 clk = 0;
        /* Check outputs */
        assert(src_data_1==0);
        /* Drive new inputs */
        src_addr_1 = 0;
        dst_addr = 1;
        write_data = 7;
        write_enable = 1;

        /* Rising edge */
        #5 clk = 1;

        /* Falling edge */
        #5 clk = 0;
        /* Check outputs */
        assert(src_data_1==3);
        /* Drive new inputs */
        src_addr_1 = 1;
        dst_addr = 0;
        write_data = 10;
        write_enable = 0;

        /* Rising edge */
        #5 clk = 1;

        /* Falling edge */
        #5 clk = 0;
        /* Check outputs */
        assert(src_data_1==7);
    end
endmodule