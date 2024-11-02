module datapath(
input logic clk,
input logic reset,
input logic [1:0] ResultSrc,
input logic PCSrc,
input logic ALUSrc,
input logic RegWrite,
input logic [1:0] ImmSrc,
input logic [2:0] ALUControl,
output logic Zero,
output logic [31:0] PC,
input logic [31:0] Instr,
output logic [31:0] ALUResult,
output logic [31:0] WriteData,
input logic [31:0] ReadData
); 

logic [31:0] PCNext, pcPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] Result, SrcA, SrcB;

// next pc instruction
flopr #(32) pcreg(
.clk(clk),
.reset(reset),
.d(PCNext),
.q(PC)
);

addr #(32) pcadd4(
.srcA(PC), 
.srcB(32'd4),
.res(pcPlus4)
);

addr #(32) pcTarget(
.srcA(PC), 
.srcB(ImmExt),
.res(PCTarget)
);

mux2 #(32) pcmux(
.d0(pcPlus4),
.d1(PCTarget),
.s(PCSrc),
.y(PCNext)
);


// register file
regfile rf(
.clk(clk),
.we3(RegWrite),
.a1(Instr[19:15]),
.a2(Instr[24:20]), 
.a3(Instr[11:7]),
.wd3(Result),
.rd1(SrcA),
.rd2(WriteData)
);

extend ext(
.instr(Instr[31:7]),
.immSrc(ImmSrc),
.ImmExt(ImmExt)
);


// ALU
mux2 #(32) srcbMux(
.d0(WriteData),
.d1(ImmExt),
.s(ALUSrc),
.y(SrcB)
);

ALU alu(
.SrcA(SrcA),
.SrcB(SrcB),
.ALUControl(ALUControl),
.ALUResult(ALUResult),
.zero(Zero)
);

mux3 #(32) resultmux(
.d0(ALUResult),
.d1(ReadData),
.d2(pcPlus4),
.s(ResultSrc),
.y(Result)
); 

endmodule

