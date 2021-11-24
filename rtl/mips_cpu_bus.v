module mips_cpu_bus (
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active,
    output logic [31:0] register_v0,

    /* Avalon memory mapped bus controller (master) */
    output logic [31:0] address,
    output logic write,
    output logic read,
    input logic waitrequest,
    output logic [31:0] writedata,
    output logic [3:0] byteenable,
    input logic [31:0] readdata
);

  logic [2:0] state;  //0-halt 1-fetch 2-decode 3-exec1 4-exec2

  initial begin
    state  = 1;
    active = 1;
  end

  always_ff @(posedge clk) begin  //state machine
    if (reset) begin
      state <= 1;
    end else if (pc_out == 0 && state != 0) begin
      state  <= 0;
      active <= 0;
    end else if (!waitrequest) begin
      if (state == 4) begin
        state <= 1;
      end else begin
        state <= state + 1;
      end
    end
  end

endmodule

