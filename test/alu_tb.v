module alu_tb ();
  logic [4:0] funct;
  logic [31:0] a;
  logic [31:0] b;
  logic [4:0] shift;
  logic [31:0] result;
  logic zero;

  ALU dut (
      .funct(funct),
      .a(a),
      .b(b),
      .shift(shift),
      .result(result),
      .zero(zero)
  );

  initial begin
    a = 32'b00001111;
    b = 32'b11110000;
    funct = 4'b0000;
    #1
      assert (result == 32'b11111111)
      else $fatal(1, "ADDU FAIL");

    funct = 4'b0001;
    #1
      assert (result == 32'b0)
      else $fatal(1, "AND FAIL");

    funct = 4'b0010;
    #1
      assert (result == a | b)
      else $fatal(1, "OR FAIL");

    funct = 4'b0011;
    b = 32'b00001111;  // a = b
    #1
      assert (result == 32'b0)
      else $fatal(1, "SUB FAIL");

    funct = 4'b0100;
    b = 32'hFFFF;
    #1
      assert (result == 32'b1)
      else $fatal(1, "SLT FAIL");

    funct = 4'b0101;
    b = 32'b00001111;
    #1
      assert (result == 32'b0)
      else $fatal(1, "SLTU FAIL");

    funct = 4'b0110;
    shift = 5'b10;
    #1
      assert (result == 32'b00111100)
      else $fatal(1, "SLL FAIL result = %b", result);

    funct = 4'b0111;
    b = 2;
    #1
      assert (result == 32'b00111100)
      else $fatal(1, "SLLV FAIL");

    funct = 4'b1000;
    #1
      assert (result == 32'b00000011)
      else $fatal(1, "SRL FAIL");

    funct = 4'b1001;
    #1
      assert (result == 32'b00000011)
      else $fatal(1, "SRLV FAIL");

    funct = 4'b1010;
    a = 32'hFFFFFFFF;
    #1 $display("a = %b", a);
    assert (result == 32'hFFFFFFFF)
    else $fatal(1, "SRA FAIL, result = %b", result);

    funct = 4'b1011;
    a = 32'b1100;
    #1
      assert (result == 32'b11)
      else $fatal(1, "SRAV FAIL");


  end

endmodule
