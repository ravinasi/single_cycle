module datapath(
input logic clk,
input logic reset,
input logic [1:0] ResultSrc,
input logic PCSrc,
input logic ALUSrc,
input logic RegWrite,
input logic [1:0] ImmSrc,
input logic [3:0] ALUControl,
output logic Zero,
output logic [31:0] PC,
input logic [31:0] Instr,
output logic [31:0] ALUResult,
output logic [31:0] WriteData,
input logic [31:0] ReadData
); 

logic [31:0] PCNext, pcPlus4, PCTarget;
logic [31:0] ImmExt;
logic [31:0] Result, SrcA, SrcB, temp;
logic [6:0] opCode;
logic [2:0] funct3;

// size of Result
always_comb begin 
opCode = Instr[6:0];
funct3 = Instr[14:12];
if(opCode == 7'b0000011) // I-type
	case(funct3)
	3'b000: temp = {{24{ReadData[7]}},ReadData[7:0]}; 	// byte
	3'b001: temp = {{26{ReadData[15]}},ReadData[15:0]}; // half
	3'b100: temp = {24'b0,ReadData[7:0]}; 				// byte unsigned
	3'b101: temp = {26'b0,ReadData[15:0]}; 				// half unsigned
	default: temp = ReadData;  							// word
	endcase
end

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
.d1(temp),
.d2(pcPlus4),
.s(ResultSrc),
.y(Result)
); 

endmodule

