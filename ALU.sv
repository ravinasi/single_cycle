module ALU(
input logic [31:0] SrcA,
input logic [31:0] SrcB,
input logic [3:0] ALUControl,
output logic [31:0] ALUResult,
output logic zero
);
logic neg;
assign zero = 1'b0;

always_comb begin
case(ALUControl)
	// Add
	4'b0000: ALUResult = SrcA + SrcB;
	// Substract
	4'b0001: ALUResult = SrcA - SrcB; 
	// AND
	4'b0010: ALUResult = SrcA & SrcB;
	// OR
	4'b0011: ALUResult = SrcA | SrcB;
	// Shift left
	4'b0100: ALUResult = SrcA << SrcB;
	// SLT
	4'b0101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;
	// XOR
	4'b0110: ALUResult = SrcA ^ SrcB; 
	// Shift Right
	4'b0111: ALUResult = SrcA >> SrcB;
	// Shift Right Arithmetic Immediate
	4'b1000: ALUResult = SrcA >>> SrcB
	default: ALUResult = 32'b0;
endcase
end
assign zero = (ALUResult === 32'b0) ? 1'b1 : 1'b0;

endmodule