module regfile(
input logic clk,
input logic we3,
input logic [4:0] a1,
input logic [4:0] a2,
input logic [4:0] a3,
input logic [31:0] wd3,
output logic [31:0] rd1,
output logic [31:0] rd2,
input logic [3:0] web
);

parameter logic NUM_BYTES = 4;
parameter logic BYTE = 8;

logic [31:0] rf[31:0];
logic i;

always_ff@(posedge clk)
if(we3) begin
	for (i=0; i<NUM_BYTES; i++)begin
		if(web[i]) begin
			rf[a3][i*BYTE +: BYTE] <= wd3[i*BYTE +: BYTE];
		end
	end
 end

assign rd1 = (a1 != 0) ? rf[a1] : 0;
assign rd2 = (a2 != 0) ? rf[a2] : 0; 
endmodule

