module avalon_RAM (
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
      $readmemh(RAM_INIT_FILE, memory, 1);
    end
  end

  integer waittime;
  // initialise registers
  initial begin
    waitrequest = 0;
    readdata = 0;

    waittime = $urandom_range(0, 5);
  end

  //start wait request if reading or writing
  always_ff @(posedge read or posedge write) begin
    waitrequest <= 1;
  end

  always_ff @(posedge clk) begin
    if (waitrequest) begin  // if in waitrequest
      if (waittime > 0) begin
        waittime <= waittime - 1;
      end else begin
        if (read) begin
          readdata <= memory[sim_address];
        end else if (write) begin
          memory[sim_address][31:24] <= (byteenable[3] ? writedata[31:24] : memory[sim_address][31:24]);
          memory[sim_address][23:16] <= (byteenable[2] ? writedata[23:16] : memory[sim_address][23:16]);
          memory[sim_address][15:8] <= (byteenable[1] ? writedata[15:8] : memory[sim_address][15:8]);
          memory[sim_address][7:0] <= (byteenable[0] ? writedata[7:0] : memory[sim_address][7:0]);
        end
        waittime <= 1;  //change to random for better test
        waitrequest <= 0;
      end
    end
  end



endmodule
