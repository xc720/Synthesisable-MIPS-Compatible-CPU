//assumed that the gates that feed into the PC are part of the PC module 
//need to get accurate input/output names
module mips_cpu_bus(
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active, 
    output logic[31:0] register_v0,

    /* Avalon memory mapped bus controller (master) */      
    output logic[31:0] address,
    output logic write, 
    output logic read, 
    input logic waitrequest,
    output logic[31:0] writedata,
    output logic[3:0] byteenable,
    input logic[31:0] readdata
    );

    logic[31:0] shifted, sign_extended, alu_in_a, alu_in_b , mem_address, pc_in, pc_out, write_data, mem_data, alu_result, alu_result_reg, mem_reg_out, read_data_1, read_data_2, read_data_v0, memory_out, read_data_1_reg, read_data_2_reg;
    logic[25:0] jmp_address;
    logic[15:0] immediate; 
    logic[5:0] opcode, fncode;
    logic[4:0] source_1, source_2, dest_reg, write_reg;
    logic[3:0] aluop;
    logic[2:0] state ;
    logic[1:0] alusrcb, pcsource;
    logic zero, alusrca, regdst, regwrite, iord, iwrite, pcwrite, pcwritecond, memread, memwrite, memtoreg, enable, ir_state;

    //sign extend:
    assign sign_extended = immediate; //Q: is this enough for sign extending?

    //implementing all multiplexers
    assign write_reg = regdst ? source_2 : dest_reg; //Q:check    
    assign write_data = memtoreg ? alu_result : memory_out ;
    assign mem_address = iord ? pc_out : alu_result ; 
    assign alu_in_a = alusrca ? pc_out : read_data_1_reg;
    assign alu_in_b = alusrcb[1] ? (alusrcb[0] ? (sign_extended << 2) : sign_extended ) : (alusrcb[0] ? 4 : read_data_2_reg);
    assign pc_in = pcsource[1] ? (pcsource[0] ? read_data_1_reg : (jmp_address << 2)) : (pcsource[0] ? alu_result_reg: alu_result);
    
    //instantiate all modules 
    pc this_pc(  
        .pc_in(pc_in),
        .pc_out(pc_out)
    ); 

     memory this_memory( 
        .address(mem_address),
        .data(write_data),
        .mem_data(mem_data)
    ); 

    controler my_control( 
        .opcode(opcode),
        .fncode(fncode),
        .state(state),
        .regdst(regdst),
        .regwrite(regwrite),
        .iord(iord),
        .irwrite(iwrite),
        .pcwrite(pcwrite),
        .pcsource(pcsource),
        .pcwritecond(pcwritecond),
        .memread(memread),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .alusrcb(alusrcb),
        .alusrca(alusrca)
    );

    instruction_register my_instruction_register(
        .clk(clk),
        .enable(enable),
        .state(ir_state),
        .memory_output(mem_data),
        .control_input(opcode), 
        .source_1(source_1),
        .source_2(source_2),
        .dest(dest_reg),
        .immediate(immediate),
        .jmp_address(jmp_address),
        .funct(fncode)
    );

    mips_register_file my_register_file( 
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_reg_1(source_1),
        .read_reg_2(source_2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2),
        .read_data_v0(read_data_v0)
    );

    mips_memory_data_register my_mem_holder(
        .memory_in(mem_data),
        .memory_out(memory_out)
    );

    mips_reg_holder a(
        .reg_val_d(read_data_1),
        .reg_val_q(read_data_1_reg)
    );

    mips_reg_holder b(
        .reg_val_d(read_data_2),
        .reg_val_q(read_data_2_reg)
    );

    mips_reg_holder alu_reg(
        .reg_val_d(alu_result),
        .reg_val_q(alu_result_reg)
    );

    mips_alu my_alu(
        .a(alu_in_a),
        .b(alu_in_b),
        .zero(zero),
        .alu_result(alu_result)
    );
endmodule
