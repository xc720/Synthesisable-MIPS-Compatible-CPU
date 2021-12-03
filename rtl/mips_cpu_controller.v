module mips_cpu_controller (
    input logic [5:0] opcode,
    input logic [5:0] fncode,
    input logic [4:0] regimm,
    input logic [2:0] state,

    output logic [1:0] regdst,
    output logic regwrite,
    output logic iord,
    output logic irwrite,
    output logic pcwrite,
    output logic [1:0] pcsource,
    output logic pcwritecond,
    output logic jump,
    output logic threecycle,
    output logic memread,
    output logic memwrite,
    output logic [3:0] byteenable,
    output logic memtoreg,
    output logic [3:0] aluop,
    output logic muldivwrite,
    output logic alusrca,
    output logic [2:0] alusrcb

);

  logic exec1, exec2;

  always_comb begin
    exec1 = (state == 3);
    exec2 = (state == 4);

    if (state == 1) begin  //fetch
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 1;
      pcwrite = 1;
      pcsource = 0;
      pcwritecond = 0;
      jump = 0;
      threecycle = 0;
      memread = 1;
      memwrite = 0;
      byteenable = 0;
      memtoreg = 0;
      aluop = 0;
      alusrca = 0;
      alusrcb = 1;

    end else if (state == 2) begin  //decode
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 0;
      pcwrite = 0;
      pcsource = 0;
      pcwritecond = 0;
      jump = 0;
      threecycle = 0;
      memread = 0;
      memwrite = 0;
      byteenable = 0;
      memtoreg = 0;
      aluop = 0;
      alusrca = 0;
      alusrcb = 3;

    end else begin  //exec1 and exec2
      case (opcode)
        6'h0: begin  //Rtype
          if (fncode  == 6'h4  || fncode == 6'h6 || fncode == 6'h7 || fncode == 6'h21 || fncode == 6'h23 || fncode == 6'h24 || fncode == 6'h25 || fncode == 6'h26 || fncode == 6'h2a || fncode == 6'h2b) begin  //Arithmetic and logical
            regdst = 1;
            regwrite = 1;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 0;
            pcwritecond = 0;
            jump = 0;
            threecycle = 1;
            memread = 0;
            memwrite = 0;
            byteenable = 0;
            memtoreg = 0;
            aluop = 2;
            alusrca = 1;
            alusrcb = 0;
          end else if (fncode == 6'h8) begin  //JR
            regdst = 0;
            regwrite = 0;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 3;
            pcwritecond = 0;
            jump = 1;
            threecycle = 1;
            memread = 0;
            memwrite = 0;
            byteenable = 0;
            memtoreg = 0;
            aluop = 0;
            alusrca = 0;
            alusrcb = 0;
          end else if (fncode == 6'h9) begin  //JALR
            regdst = 1;
            regwrite = 1;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 3;
            pcwritecond = 0;
            jump = 1;
            threecycle = 1;
            memread = 0;
            memwrite = 0;
            byteenable = 0;
            memtoreg = 0;
            aluop = 0;
            alusrca = 0;
            alusrcb = 1;
          end
        end
        6'h1: begin  //REGIMM     BLTZ, BLTZAL, BGEZ, BGEZAL
          if (regimm < 2) begin  //BLTZ, BGEZ
            regwrite = 0;
            regdst = 0;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 1;
            pcwritecond = 1;
            jump = 0;
            threecycle = 1;
            memread = 0;
            memwrite = 0;
            byteenable = 0;
            memtoreg = 0;
            aluop = regimm == 0 ? 7 : 4;
            alusrca = 1;
            alusrcb = 0;
          end else begin  //BLTZAL, BGEZAL
            regdst = 2;
            regwrite = 1;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 1;
            pcwritecond = 1;
            jump = 0;
            threecycle = 1;
            memread = 0;
            memwrite = 0;
            byteenable = 0;
            memtoreg = 0;
            aluop = regimm == 16 ? 7 : 4;
            alusrca = 1;
            alusrcb = 0;
          end
        end
        6'h2: begin  //J
          regwrite = 0;
          regdst = 0;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 2;
          pcwritecond = 0;
          jump = 1;
          threecycle = 1;
          memread = 0;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 0;
          aluop = 0;
          alusrca = 0;
          alusrcb = 0;
        end
        6'h3: begin  //JAL
          regdst = 1;
          regwrite = 1;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 2;
          pcwritecond = 0;
          jump = 1;
          threecycle = 1;
          memread = 0;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 0;
          aluop = 0;
          alusrca = 0;
          alusrcb = 1;
        end
        6'h4: begin  //BEQ
          regwrite = 0;
          regdst = 0;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 1;
          pcwritecond = 1;
          jump = 0;
          threecycle = 1;
          memread = 0;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 0;
          aluop = 3;
          alusrca = 1;
          alusrcb = 0;
        end
        6'h8: begin  //ADDIU
          regdst = 0;
          regwrite = 1;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          threecycle = 1;
          memread = 0;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 0;
          aluop = 0;
          alusrca = 1;
          alusrcb = 2;
        end
        6'hc || 6'hd || 6'he: begin  //ANDI, ORI, XORI
          regdst = 0;
          regwrite = 1;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          threecycle = 1;
          memread = 0;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 0;
          aluop = opcode == 6'hc ? 0 : opcode == 6'hd ? 0 : 0; //TODO: correct when i instructions are in alu control
          alusrca = 1;
          alusrcb = 4;
        end
        6'h23: begin  //LW
          regdst = 0;
          regwrite = exec2;
          iord = 1;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          threecycle = 0;
          memread = exec1;
          memwrite = 0;
          byteenable = 0;
          memtoreg = 1;
          aluop = 0;
          alusrca = 1;
          alusrcb = 2;
        end
        6'h2b: begin  //SW
          regdst = 0;
          regwrite = 0;
          iord = 1;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          threecycle = 1;
          memread = 0;
          memwrite = 1;
          byteenable = 4'b1111;
          memtoreg = 0;
          aluop = 0;
          alusrca = 1;
          alusrcb = 2;
        end

      endcase
    end
  end


endmodule
