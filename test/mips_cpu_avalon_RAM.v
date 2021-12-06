module mips_cpu_avalon_RAM (
    input logic clk,
    input logic [31:0] address,
    input logic [3:0] byteenable,
    input logic read,
    input logic write,
    input logic [31:0] writedata,
    output logic waitrequest,
    output logic [31:0] readdata

);

  parameter RAM_INIT_FILE = "";
  logic [31:0] memory[4095:0];

  logic [31:0] sim_address;
  //simulate address in memory 
  assign sim_address = ((address - 32'hBFC00000) >> 2) % 4096;

  initial begin

    for (int i = 0; i < 4096; i++) begin
      memory[i] = 0;
    end

    if (RAM_INIT_FILE != "") begin
      $display("Loading RAM contents from %s", RAM_INIT_FILE);
      $readmemh(RAM_INIT_FILE, memory);
    end
  end

  integer waitcycle;
  // initialise registers
  initial begin
    waitrequest = 0;
    readdata = 0;

    waitcycle = $urandom_range(0, 5);
  end

  //start wait request if reading or writing
  always_ff @(posedge read or posedge write) begin
    waitrequest <= 1;
  end

  always_ff @(posedge clk) begin
    if (waitrequest) begin  // if in waitrequest
      if (waitcycle != 0) begin  // check if waitcycle has finihsed
        waitcycle <= waitcycle - 1;
      end else if (waitcycle == 0) begin
        if (read) begin  // set readdata if requested
          // $display("Address: %h data: %h", address, memory[address]);
          readdata <= memory[address];
        end else if (write) begin  // set write data if requested
          // $display("Bytenable: %b address: %h data: %h", byteenable, address, writedata);
          memory[address] <= {
            byteenable[3] ? writedata[31:24] : memory[address][31:24],
            byteenable[2] ? writedata[23:16] : memory[address][23:16],
            byteenable[1] ? writedata[15:8] : memory[address][15:8],
            byteenable[0] ? writedata[7:0] : memory[address][7:0]
          };
        end
        waitcycle <= 1;//$urandom_range(0,5); // reset reandom wait time (this can be set to a constant, random can be useful for testing)
        waitrequest <= 0;  // reset wait request
      end
    end
  end



endmodule
