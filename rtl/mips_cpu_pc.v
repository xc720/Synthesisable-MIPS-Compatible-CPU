module pc (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] pc_in,
    input  logic        pc_write,
    output logic [31:0] pc_out
);

  always_ff @(posedge clk) begin
    if (reset == 1) begin
      pc_out <= 32'hBFC00000;
    end else if (pc_write) begin
      pc_out <= pc_in;
    end
  end

endmodule
