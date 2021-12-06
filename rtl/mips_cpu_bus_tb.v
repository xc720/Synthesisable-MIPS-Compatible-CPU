module mips_cpu_bus_tb;
  //timeunit 1ns / 10ps;

  parameter RAM_INIT_FILE = "as.dump";
  parameter TIMEOUT_CYCLES = 10000;

  logic clk;
  logic reset;
  logic active;

  logic memread;
  logic memwrite;
  logic waitrequest;

  logic [3:0] byteenable;

  logic [31:0] register_v0;
  logic [31:0] mem_address;
  logic [31:0] memreaddata;
  logic [31:0] memwritedata;
  logic [31:0] register[31:0];

  mips_cpu_avalon_RAM #(RAM_INIT_FILE) RAMInst (
      .clk(clk),
      .address(mem_address),
      .byteenable(byteenable),
      .read(memread),
      .write(memwrite),
      .waitrequest(waitrequest),
      .readdata(memreaddata),
      .writedata(memwritedata)
  );

  mips_cpu_bus cpuBusInst (
      .clk(clk),
      .reset(reset),
      .active(active),
      .register_v0(register_v0),
      .mem_address(mem_address),
      .memwrite(memwrite),
      .memread(memread),
      .waitrequest(waitrequest),
      .memwritedata(memwritedata),
      .byteenable(byteenable),
      .memreaddata(memreaddata),
      .register(register)
  );

  // generate clock
  initial begin
    // $timeformat(-9, 1, " ns", 20);
    $dumpfile("mips_cpu_bus_tb.vcd");
    $dumpvars(0, mips_cpu_bus_tb);
    clk = 0;

    repeat (TIMEOUT_CYCLES) begin
      #10;
      clk = !clk;
      #10;
      clk = !clk;
    end

    $fatal(2, "Simulation did not finish within %d cycles.", TIMEOUT_CYCLES);
  end

  initial begin
    reset <= 1;

    @(posedge clk);
    #1;
    reset <= 0;

    @(posedge clk);
    $display("address = %h", mem_address);
    assert (active == 1)
    else $display("TB: CPU did not set active=1 after reset.");

    #150;








    for (int i = 0; i < 32; ++i) begin
      $display("TB: INFO: register_v", i, " = %d", register_v0);
    end

    $display("TB: INFO: register_v0 = %d", register_v0);

    $finish;
  end
endmodule
