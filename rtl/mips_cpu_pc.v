module mips_cpu_pc (
    input logic clk,
    input logic jmp,
    input logic reset,
    input logic [31:0] pcin,

    output logic [31:0] pcout
);


  always_ff @(posedge clk) begin

    if (reset) begin
      pcout <= 32'hBFC00000;
    end else if (jmp) begin
      pcout <= pcin;
    end

  end

endmodule
