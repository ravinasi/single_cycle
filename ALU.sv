module ALU(
input logic [31:0] SrcA, SrcB,
input logic [2:0] ALUControl,
output logic [31:0] ALUResult,
output logic zero
);
logic neg;
assign zero = 1'b0;

always_comb begin
case(ALUControl)
	// Add
	3'b000: ALUResult = SrcA + SrcB;
	// Substract
	3'b001: ALUResult = SrcA - SrcB; 
	// AND
	3'b010: ALUResult = SrcA & SrcB;
	// OR
	3'b011: ALUResult = SrcA | SrcB;
	// SLT
	3'b101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;

	default: ALUResult = 32'b0;
endcase
end
assign zero = (ALUResult === 32'b0) ? 1'b1 : 1'b0;

endmodule