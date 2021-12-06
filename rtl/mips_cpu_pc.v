module mips_cpu_pc (
    input logic clk,
    input logic pcenable,
    input logic reset,
    input logic [31:0] pcin,

    output logic [31:0] pcout
);


  always @(posedge clk) begin

    if (reset) begin
      pcout <= 32'hBFC00000;
    end else if (pcenable) begin
      pcout <= pcin;
    end
    $display("pc = %h", pcout);
  end

endmodule
