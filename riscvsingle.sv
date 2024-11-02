module riscvsingle(
input logic clk,
input logic reset,
output logic [31:0] PC,
input logic [31:0] Instr,
output logic MemWrite,
output logic [31:0] ALUResult,
output logic [31:0] WriteData,
input logic [31:0] ReadData
);

logic ALUSrc, RegWrite, Zero, PCSrc;
logic [1:0] ResultSrc, ImmSrc;
logic [4:0] ALUControl;

controller c(
.op(Instr[6:0]),
.funct3(Instr[14:12]),
.funct7b5(Instr[30]),
.zero(Zero),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.PCSrc(PCSrc),
.ALUSrc(ALUSrc),
.RegWrite(RegWrite),
.ImmSrc(ImmSrc),
.ALUControl(ALUControl)
);

datapath dp(
.clk(clk),
.reset(reset),
.ResultSrc(ResultSrc),
.PCSrc(PCSrc),
.ALUSrc(ALUSrc),
.RegWrite(RegWrite),
.ImmSrc(ImmSrc),
.ALUControl(ALUControl),
.Zero(Zero),
.PC(PC),
.Instr(Instr),
.ALUResult(ALUResult),
.WriteData(WriteData),
.ReadData(ReadData)
); 

endmodule