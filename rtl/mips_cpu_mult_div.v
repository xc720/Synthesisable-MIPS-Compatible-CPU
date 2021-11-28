module mult(
    input logic[31:0] a, b,
    input logic[2:0] op,
    input logic clk,
    input logic write,
    input logic reset,

    output logic[31:0] hi, lo
);

logic sign_a, sign_b, sign_out;
logic[31:0] mag_a, mag_b, signed_a, signed_b, unsigned_a, unsigned_b;
logic[63:0] div_u, mult_u, div, mult;

assign sign_a = a[31];
assign sign_b = b[31];

always_comb begin 
    signed_a = $signed(a);
    signed_b = $signed(b);
    unsigned_a = $unsigned(a);
    unsigned_b = $unsigned(b);

    mag_a = sign_a ? -$signed(a) :  $unsigned(a);
    mag_b = sign_b ? -$signed(b) : $unsigned(b);

    div_u = unsigned_a / unsigned_b;
    mult_u = unsigned_a * unsigned_b;
    div = mag_a / mag_b;
    mult = mag_a * mag_b;

    sign_out = sign_a + sign_b;

end

always @(posedge clk) begin

    if (reset) begin
        hi <= 0;
        lo <= 0;
    end else if (write) begin
        case(op)
            3'b000: begin
                    hi <= div_u[63:32];
                    lo <= div_u[31:0]; //DIVU
                end 
            3'b001: begin
                    hi <= mult_u[63:32];
                    lo <= mult_u[31:0]; //MULTU
                end
            3'b010: begin 
                    hi[31] <= sign_out;
                    hi[30:0] <= div[62:32];
                    lo <= div[31:0];//DIV
                end
            3'b011: begin 
                    hi[31] <= sign_out;
                    hi[30:0] <= mult[62:32];
                    lo <= mult[31:0];//MULT
                end
            3'b100: hi <= a; //MTHI
            3'b101: lo <= a; //MTLO
        endcase;
    end 
end

endmodule