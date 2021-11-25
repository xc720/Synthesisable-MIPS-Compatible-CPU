module memory(
    input logic[31:0] address,
    input logic[31:0] data,
    output logic[31:0] mem_data
    );
    
    assign mem_data = address ; 

endmodule