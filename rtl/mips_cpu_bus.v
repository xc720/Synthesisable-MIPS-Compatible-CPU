//assumed that the gates that feed into the PC are part of the PC module 
//need to get accurate input/output names

module mips_cpu_bus(
    /* Standard signals */
    input logic clk,
    input logic reset,
    output logic active, 
    output logic[31:0] register_v0,

    /* Avalon memory mapped bus controller*/      
    output logic[31:0] address,
    output logic write, 
    output logic read, 
    input logic waitrequest,
    output logic[31:0] writedata,
    output logic[3:0] byteenable,
    input logic[31:0] readdata
    );
   
    //variables for pc
    logic[31:0] pc_address_in, pc_next_address;
    
    //variables for alu (need to add in the alu_control)
    logic[31:0] alu_result, alu_in_a, alu_in_b, alu_out; 
    logic alu_zero;

    //variables for memory
    logic[31:0] mem_address, mem_write_data, mem_data;

    //variables for ir
    logic ir_state; //ADDED THIS FOR COMPILATION BUT NOT REPRESENTED ON DATAPATH, 
    logic[5:0] opcode, fncode;
    logic[25:0] jmp_address;
    logic[15:0] immediate; 

    //variables for memory data register
    logic[31:0] mem_reg_out;

    //variables for register file
    logic reg_enable ;
    logic[4:0] reg_source_1, reg_source_2, reg_dest;
    logic[31:0] reg_write_data, read_reg_1, read_reg_2, read_reg_v0;
    logic[4:0] reg_write_address;

    //variables for control
    logic pc_write_cond, pc_write, i_or_d, mem_read, memwrite, memtoreg, ir_write, regdst, regwrite, alusrca;
    logic[1:0] alusrcb, pcsource;
    logic[3:0] aluop;

    //variables for A and B registers
    logic[31:0] read_reg_a_next, read_reg_b_next; 

    logic[31:0] sign_extended , read_data_v0, memory_out;
    
    logic[4:0] write_reg;
    logic[2:0] state ;

    assign sign_extended = immediate; //how can i sign extend inside of the mux expression in line 66

    //implementing all multiplexers
    assign mem_address = i_or_d ? pc_next_address : alu_result ; 
    assign write_reg = regdst ? reg_source_2 : reg_dest;    
    assign reg_write_data = memtoreg ? alu_result : mem_reg_out ;
    assign alu_in_a = alusrca ? pc_next_address : read_reg_a_next;
    assign alu_in_b = alusrcb[1] ? (alusrcb[0] ? (sign_extended << 2) : sign_extended ) : (alusrcb[0] ? 4 : read_reg_b_next);
    assign pc_address_in = pcsource[1] ? (pcsource[0] ? read_reg_a_next : {pc_next_address[31:28], (jmp_address << 2)}) : (pcsource[0] ? alu_out: alu_result); //the jmp_address is the wrong width 
    
    //instantiate all modules 
    pc this_pc(  
        .pc_in(pc_address_in),
        .pc_write(pc_write),
        .pc_write_cond(pc_write_cond),
        .alu_zero(alu_zero),
        .pc_out(pc_next_address)
    ); 

     memory this_memory( 
        .address(mem_address),
        .data(mem_write_data),
        .mem_data(mem_data)
    ); 

    controler my_control( 
        .opcode(opcode),
        .fncode(fncode),
        .state(state),
        .regdst(regdst),
        .regwrite(regwrite),
        .iord(i_or_d),
        .irwrite(ir_write),
        .pcwrite(pcwrite),
        .pcsource(pcsource),
        .pcwritecond(pcwritecond),
        .memread(mem_read),
        .memwrite(memwrite),
        .memtoreg(memtoreg),
        .aluop(aluop),
        .alusrcb(alusrcb),
        .alusrca(alusrca)
    );

    instruction_register my_instruction_register(
        .clk(clk),
        .enable(reg_enable),
        .state(ir_state),
        .memory_output(mem_data),
        .control_input(opcode), //instruction[31-26]
        .source_1(reg_source_1), // instruction[25:21] 
        .source_2(reg_source_2), //instruction[20:16]   
        .dest(reg_dest), //instruction[15:11]
        .immediate(immediate), //instruction[15:0]
        .jmp_address(jmp_address), //instruction[25:0]
        .funct(fncode) //instruction[5:0]
    );

    mips_register_file my_register_file( 
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .read_reg_1(reg_source_1),
        .read_reg_2(reg_source_2),
        .write_reg(reg_write_address),
        .write_data(reg_write_data),
        .read_data_1(read_reg_1),
        .read_data_2(read_reg_2),
        .read_data_v0(read_reg_v0)
    );

    mips_memory_data_register my_mem_holder(
        .memory_in(mem_data),
        .memory_out(mem_reg_out)
    );

    mips_reg_holder a(
        .reg_val_d(read_reg_1),
        .reg_val_q(read_reg_a_next)
    );

    mips_reg_holder b(
        .reg_val_d(read_reg_2),
        .reg_val_q(read_reg_b_next)
    );

    mips_reg_holder alu_reg(
        .reg_val_d(alu_result),
        .reg_val_q(alu_out)
    );

    mips_alu my_alu(
        .a(alu_in_a),
        .b(alu_in_b),
        .zero(zero), 
        .alu_result(alu_result)
    );
endmodule
