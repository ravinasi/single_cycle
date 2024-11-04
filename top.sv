module top(
input logic clk,
input logic reset,
output logic [31:0] WriteData,
output logic [31:0] DataAdr,
output logic MemWrite
);

logic [31:0] PC, Instr, ReadData;
logic [3:0] MemWriteByte;

riscvsingle sc(
.clk(clk),
.reset(reset),
.PC(PC),
.Instr(Instr),
.MemWrite(MemWrite),
.ALUResult(DataAdr),
.WriteData(WriteData),
.ReadData(ReadData),
.MemWriteByte(MemWriteByte)
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
.ReadData(ReadData),
.web(MemWriteByte)
);

endmodule