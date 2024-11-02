module addr #(parameter N = 32)(
input logic [N-1:0] srcA,
input logic [N-1:0] srcB,
output logic [N-1:0] res
);

assign res = srcA + srcB;

endmodule