module dmem(
input logic CLK,
input logic WE,
input logic [31:0] DataAdr,
input logic [31:0] WriteData,
output logic [31:0] ReadData,
input logic [3:0] web
);

parameter logic NUM_BYTES = 4;
parameter logic BYTE = 8;

logic i;
logic [31:0] RAM[63:0];
assign ReadData = RAM[DataAdr[31:2]]; 

always_ff@(posedge CLK)
if(WE) begin
	for (i=0; i<NUM_BYTES; i++)begin
		if(web[i]) begin
			RAM[DataAdr[31:2]][i*BYTE +: BYTE] <= WriteData[i*BYTE +: BYTE];
		end
	end
 end
 
endmodule