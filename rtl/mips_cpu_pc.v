module mips_cpu_pc (
    input logic clk,
    input logic jmp,
    input logic jr,
    input logic reset,
    input logic beq_result,
    /*branch if assert*/
    input logic bgez_result,
    /*branch if assert*/
    input logic bgezal_result,
    input logic bgtz_result,
    input logic blez_result,
    input logic bltz_result,
    input logic bltzal_result,
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
