module maindec(
input logic [6:0] op,
output logic [1:0] ResultSrc,
output logic MemWrite,
output logic Branch,
output logic AluSrc,
output logic RegWrite,
output logic Jump,
output logic [1:0] ImmSrc,
output logic [1:0] ALUOp
);

logic [10:0] controls;
assign {RegWrite, ImmSrc, AluSrc, MemWrite,
ResultSrc, Branch, ALUOp, Jump} = controls;

always_comb begin
	case(op)
	7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
	7'b0100011: controls = 11'b0_01_1_1_xx_0_00_0; // sw
	7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // R-type
	7'b1100011: controls = 11'b0_10_0_0_xx_1_01_0; // beq
	7'b0010011: controls = 11'b1_00_1_0_00_0_10_0; // I-type_ALU
	7'b1101111: controls = 11'b1_11_x_0_10_0_xx_1; // jal
	default: 	controls = 11'bx_xx_x_x_xx_x_xx_x; // ?
	endcase
end
endmodule