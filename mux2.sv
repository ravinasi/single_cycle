module mux2  #(parameter N = 2)(
input logic [N-1:0] d0,
input logic [N-1:0] d1,
input logic s,
output logic [N-1:0] y
);

assign y = (s)? d1 : d0;

endmodule