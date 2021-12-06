module mips_cpu_bus (
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active,
    output logic [31:0] register_v0,
    //logic for clk, reset, active, register_v0 not yet implemented

    /* Avalon memory mapped bus controller */
    output logic [31:0] mem_address,
    output logic memwrite,
    output logic memread,
    input logic waitrequest,
    output logic [31:0] memwritedata,
    output logic [3:0] byteenable,
    input logic [31:0] memreaddata
);

  //variables for pc
  logic [31:0] pc_address_in, pc_current_address;

  //variables for alu (need to add in the alu_control)
  logic [31:0] alu_result, alu_in_a, alu_in_b, alu_out;
  logic condition;

  //variables for alu control
  logic [4:0] toalu;
  logic [2:0] tomult;

  //variables for A and B registers
  logic [31:0] read_reg_a_current, read_reg_b_current;

  //variables for the mul/div 
  logic [31:0] hi, lo;

  //variables for memory data register
  logic [31:0] mem_reg_current;

  //variables for jumps and branching
  logic jump;
  logic [31:0] jumpdestreg, jumpcondreg, increment_pc;

  //variables for ir
  logic [4:0] shift;
  logic [5:0] opcode, fncode;
  logic [25:0] jmp_address;
  logic [15:0] immediate;
  logic [31:0] sign_extended_immediate;
  logic [31:0] zero_extended_immediate;

  //variables for register file
  logic [4:0] reg_source_1, reg_source_2, reg_dest;
  logic [31:0] reg_write_data, read_reg_1, read_reg_2;
  logic [4:0] reg_write_address;

  //variables for control
  logic
      pcwritecond,
      pcwrite,
      iord,
      ir_write,
      memtoreg,
      regwrite,
      alusrca,
      muldivwrite,
      threecycle,
      aluouten;
  logic [1:0] pcsource, regdst;
  logic [2:0] alusrcb;
  logic [3:0] aluop;

  //variables for state machine
  logic [2:0] state;



  //initial conditions
  initial begin
    state = 0;
    active = 0;
    jumpcondreg = 0;
  end

  //state machine
  always_ff @(posedge clk) begin
    if (reset) begin
      state  <= 1;
      active <= 1;
    end else if (pc_current_address == 0 && state != 0) begin
      state  <= 0;
      active <= 0;
    end else if (!waitrequest) begin
      if (state == 4 || (state == 3 && threecycle)) begin
        state <= 1;
      end else begin
        state <= state + 1;
      end
    end
  end

  //sign extend immediate
  assign sign_extended_immediate = immediate[15] ? {16'hFFFF, immediate} : {16'h0000, immediate};
  assign zero_extended_immediate = {16'h0000, immediate};

  //assign where to write to memory from
  assign memwritedata = read_reg_b_current;

  //implementing all multiplexers
  assign mem_address = iord ? pc_current_address : alu_result;
  assign reg_write_address = regdst[1] ? 31 : regdst[0] ? reg_source_2 : reg_dest;
  assign reg_write_data = memtoreg ? mem_reg_current : alu_result;
  assign alu_in_a = alusrca ? pc_current_address : read_reg_a_current;
  assign alu_in_b = alusrcb[2] ? zero_extended_immediate : alusrcb[1] ? (alusrcb[0] ? (sign_extended_immediate << 2) : sign_extended_immediate ) : (alusrcb[0] ? 4 : read_reg_b_current);
  assign increment_pc = pcsource[1] ? (pcsource[0] ? read_reg_a_current : {pc_current_address[31:28], (jmp_address << 2)}) : (pcsource[0] ? alu_out: alu_result);
  assign pc_address_in = jumpcondreg ? jumpdestreg : increment_pc;

  //implementing all single registers
  always_ff @(posedge clk) begin
    mem_reg_current <= memreaddata;
    read_reg_a_current <= read_reg_1;
    read_reg_b_current <= read_reg_2;
    jumpcondreg <= ((condition & pcwritecond) || jump);
    if ((condition & pcwritecond) || jump) begin
      jumpdestreg <= increment_pc;
    end
    if (aluouten) begin
      alu_out <= alu_result;
    end
  end

  //instantiate all modules 
  mips_cpu_pc cpu_pc (
      .pcin (pc_address_in),
      .clk  (clk),
      .reset(reset),
      .jmp  (pcwrite),
      .pcout(pc_current_address)
  );

  mips_cpu_controller cpu_control (
      .opcode(opcode),
      .fncode(fncode),
      .regimm(reg_source_2),
      .state(state),
      .regdst(regdst),
      .regwrite(regwrite),
      .iord(iord),
      .irwrite(ir_write),
      .pcwrite(pcwrite),
      .jump(jump),
      .threecycle(threecycle),
      .pcsource(pcsource),
      .pcwritecond(pcwritecond),
      .memread(memread),
      .memwrite(memwrite),
      .memtoreg(memtoreg),
      .aluop(aluop),
      .muldivwrite(muldivwrite),
      .alusrcb(alusrcb),
      .alusrca(alusrca),
      .aluouten(aluouten)
  );

  mips_cpu_instruction_reg cpu_instruction_register (
      .clk(clk),
      .enable(ir_write),
      .state(state),
      .memory_output(memreaddata),
      .control_input(opcode),  //instruction[31-26]
      .source_1(reg_source_1),  // instruction[25:21] 
      .source_2(reg_source_2),  //instruction[20:16]   
      .dest(reg_dest),  //instruction[15:11]
      .immediate(immediate),  //instruction[15:0]
      .jmp_address(jmp_address),  //instruction[25:0]
      .shamt(shift),  //instruction[6:10]
      .funct(fncode)  //instruction[5:0]
  );

  mips_cpu_register_file cpu_register_file (
      .clk(clk),
      .reset(reset),
      .write_enable(regwrite),
      .read_reg_1(reg_source_1),
      .read_reg_2(reg_source_2),
      .write_reg(reg_write_address),
      .write_data(reg_write_data),
      .read_data_1(read_reg_1),
      .read_data_2(read_reg_2),
      .read_data_v0(register_v0)
  );

  mips_cpu_alu cpu_alu (
      .clk(clk),
      .reset(reset),
      .alu_func(toalu),
      .mult_op(tomult),
      .a(alu_in_a),
      .b(alu_in_b),
      .shift(shift),
      .write(muldivwrite),
      .hi(hi),
      .lo(lo),
      .condition(condition),
      .result(alu_result)
  );

  mips_cpu_alu_control cpu_alu_control (
      .aluOp (aluop),
      .funct (fncode),
      .toAlu (toalu),
      .toMult(tomult)
  );


endmodule
