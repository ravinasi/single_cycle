module dmem(
input logic CLK,
input logic WE,
input logic [31:0] DataAdr,
input logic [31:0] WriteData,
output logic [31:0] ReadData
);

logic [31:0] RAM[63:0];
assign ReadData = RAM[DataAdr[31:2]]; 

always_ff@(posedge CLK)
if(WE) RAM[DataAdr[31:2]] <= WriteData;

endmodule