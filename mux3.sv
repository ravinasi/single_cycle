module mux3 #(parameter N = 32)(
input logic [N-1:0] d0,
input logic [N-1:0] d1,
input logic [N-1:0] d2,
input logic [1:0] s,
output logic [N-1:0] y
);

assign y = s[1] ? d2 : (s[0] ? d1 : d0);

endmodule
