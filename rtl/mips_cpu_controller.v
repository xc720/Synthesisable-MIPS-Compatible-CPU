//this is just copy and pasted

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

  


endmodule