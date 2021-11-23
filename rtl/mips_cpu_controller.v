module controler (
    input logic [5:0] opcode,
    input logic [5:0] fncode,
    input logic [2:0] state,
    input logic waitrequest,

    output logic regdst,
    output logic regwrite,
    output logic iord,
    output logic irwrite,
    output logic pcwrite,
    output logic pcsource,
    output logic memread,
    output logic memwrite,
    output logic memtoreg,
    output logic [1:0] aluop,
    output logic alusrc

);
  logic fetch, decode, exec1, exec2;

  always_comb begin
    fetch  = (state == 1);
    decode = (state == 2);
    exec1  = (state == 3);
    exec2  = (state == 4);
  end



  always_comb begin
    if (fetch) begin
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 0;
      memread = 1;
      memwrite = 0;
      memtoreg = 0;
      aluop = 0;
      alusrc = 0;

    end else if (decode) begin
      regdst = 0;
      regwrite = 0;
      iord = 0;
      irwrite = 1;
      memread = 0;
      memwrite = 0;
      memtoreg = 0;
      aluop = 0;
      alusrc = 0;

    end else begin
      case (opcode)
        6'h0: begin  //Rtype
          regdst = 1;
          regwrite = exec2;
          iord = 0;
          irwrite = 0;
          memread = 0;
          memwrite = 0;
          memtoreg = 0;
          alusrc = 0;
          aluop = 2;
        end
        6'h23: begin  //lw
          regdst = 0;
          regwrite = exec2;
          iord = 1;
          irwrite = 0;
          memread = exec1;
          memwrite = 0;
          memtoreg = 1;
          aluop = 0;
          alusrc = 1;
        end
        6'h2b: begin  //sw
          regdst = 0;
          regwrite = 0;
          iord = 1;
          irwrite = 0;
          memread = 0;
          memwrite = exec2;
          memtoreg = 0;
          aluop = 0;
          alusrc = 1;
        end
        6'h4: begin  //beq
          regwrite = 0;
          regdst = 0;
          iord = 1;
          irwrite = 0;
          memread = 0;
          memwrite = 0;
          memtoreg = 0;
          aluop = 1;
          alusrc = 0;
        end

        default: begin
          $fatal(1, "opcode not yet implemented");
        end
      endcase
    end
  end


endmodule
