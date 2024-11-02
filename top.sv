module top(
input logic clk,
input logic reset,
output logic [31:0] WriteData,
output logic [31:0] DataAdr,
output logic MemWrite
);

logic [31:0] PC, Instr, ReadData;

riscvsingle sc(
.clk(clk),
.reset(reset),
.PC(PC),
.Instr(Instr),
.MemWrite(MemWrite),
.ALUResult(DataAdr),
.WriteData(WriteData),
.ReadData(ReadData)
);

imem imem(
.a(PC),
.rd(Instr)
);

dmem dmem(
.CLK(clk),
.WE(MemWrite),
.DataAdr(DataAdr),
.WriteData(WriteData),
.ReadData(ReadData)
);

endmodule