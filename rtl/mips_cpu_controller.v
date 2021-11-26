module controler (
    input logic [5:0] opcode,
    input logic [5:0] fncode,
    input logic [2:0] state,

    output logic regdst,
    output logic regwrite,
    output logic iord,
    output logic irwrite,
    output logic pcwrite,
    output logic [1:0] pcsource,
    output logic pcwritecond,
    output logic jump,
    output logic memread,
    output logic memwrite,
    output logic memtoreg,
    output logic [3:0] aluop,
    output logic alusrca,
    output logic [1:0] alusrcb

);

  logic exec1, exec2;

  always_comb begin
    exec1 = (state == 3);
    exec2 = (state == 4);

    if (state == 1) begin
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 1;
      pcwrite = 1;
      pcsource = 0;
      pcwritecond = 0;
      jump = 0;
      memread = 1;
      memwrite = 0;
      memtoreg = 0;
      aluop = 0;
      alusrca = 0;
      alusrcb = 1;

    end else if (state == 2) begin
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 0;
      pcwrite = 0;
      pcsource = 0;
      pcwritecond = 0;
      jump = 0;
      memread = 0;
      memwrite = 0;
      memtoreg = 0;
      aluop = 0;
      alusrca = 0;
      alusrcb = 3;

    end else begin
      case (opcode)
        6'h0: begin  //Rtype
          if (fncode >= 5'h20 && fncode <= 5'h26) begin  //Arithmetic and logical
            regdst = 1;
            regwrite = exec2;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 0;
            pcwritecond = 0;
            jump = 0;
            memread = 0;
            memwrite = 0;
            memtoreg = 0;
            aluop = 2;
            alusrca = 1;
            alusrcb = 0;
          end else if (fncode == 5'h8) begin  //JR
            regdst = 0;
            regwrite = 0;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 3;
            pcwritecond = 0;
            jump = 1;
            memread = 0;
            memwrite = 0;
            memtoreg = 0;
            aluop = 0;
            alusrca = 0;
            alusrcb = 0;
          end else if (fncode == 5'h9) begin  //JALR
            regdst = 1;
            regwrite = exec1;
            iord = 0;
            irwrite = 0;
            pcwrite = 0;
            pcsource = 3;
            pcwritecond = 0;
            jump = 1;
            memread = 0;
            memwrite = 0;
            memtoreg = 0;
            aluop = 0;
            alusrca = 0;
            alusrcb = 1;
          end
        end
        6'h23: begin  //lw
          regdst = 0;
          regwrite = exec2;
          iord = 1;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          memread = exec1;
          memwrite = 0;
          memtoreg = 1;
          aluop = 0;
          alusrca = 1;
          alusrcb = 2;
        end
        6'h2b: begin  //sw
          regdst = 0;
          regwrite = 0;
          iord = 1;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 0;
          pcwritecond = 0;
          jump = 0;
          memread = 0;
          memwrite = exec2;
          memtoreg = 0;
          aluop = 0;
          alusrca = 1;
          aluscr2 = 2;
        end
        6'h4: begin  //beq
          regwrite = 0;
          regdst = 0;
          iord = 0;
          irwrite = 0;
          pcwrite = 0;
          pcsource = 1;
          pcwritecond = 1;
          jump = 0;
          memread = 0;
          memwrite = 0;
          memtoreg = 0;
          aluop = 1;
          alusrca = 1;
          aluscrb = 0;
        end

        default: begin
          $fatal(1, "opcode not yet implemented");
        end
      endcase
    end
  end


endmodule
