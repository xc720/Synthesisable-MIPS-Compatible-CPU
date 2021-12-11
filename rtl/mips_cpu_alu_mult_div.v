module mips_cpu_alu_mult_div (
    input logic [31:0] a,
    b,
    input logic [2:0] op,
    input logic clk,
    input logic write,
    input logic reset,

    output logic [31:0] hi, lo
);

  logic [31:0] mag_a, mag_b, signed_a, signed_b, unsigned_a, unsigned_b, div_u, div, rem_u, rem;
  logic [63:0] mult_u, mult;

  assign sign_a = a[31];
  assign sign_b = b[31];

  always_comb begin
    signed_a = $signed(a);
    signed_b = $signed(b);
    unsigned_a = $unsigned(a);
    unsigned_b = $unsigned(b);

    div_u = unsigned_a / unsigned_b;
    rem_u = unsigned_a % unsigned_b;
    mult_u = unsigned_a * unsigned_b;

    div = signed_a / signed_b;
    rem = signed_a % signed_b;
    mult = signed_a * signed_b;

  end

  always_ff @(posedge clk) begin

    if (reset) begin
      hi <= 0;
      lo <= 0;
    end else if (write) begin
      case (op)
        3'b000: begin
          hi <= rem_u;
          lo <= div_u[31:0];  //DIVU
        end
        3'b001: begin
          hi <= mult_u[63:32];
          lo <= mult_u[31:0];  //MULTU
        end
        3'b010: begin
          hi <= rem;
          lo <= div[31:0];  //DIV
        end
        3'b011: begin
          hi<= mult[63:32];
          lo <= mult[31:0];  //MULT
        end
        3'b100: hi <= a;  //MTHI
        3'b101: lo <= a;  //MTLO
        3'b110: hi <= hi;  //MFHI
        3'b111: lo <= lo;  //MFLO
      endcase
      ;
    end
  end

endmodule
