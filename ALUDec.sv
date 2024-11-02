module ALUDec(
input logic opb5,
input logic [2:0] funct3,
input logic funct7b5,
input logic [1:0] ALUOp,
output logic [3:0] ALUControl
);

logic RtypeSub;
assign RtypeSub = opb5 & funct7b5; // TRUE for R-type

always_comb begin 
case(ALUOp)
2'b00: ALUControl = 4'b0000; // add
2'b01: ALUControl = 4'b0001; // sub
default: case(funct3)
		3'b000: if(RtypeSub) ALUControl = 4'b0001; 	// sub
				else ALUControl = 4'b0000; 			// add
		3'b001: ALUControl = 4'b0100; 				// shift left
		3'b010: ALUControl = 4'b0101; 				// slt
		3'b100: ALUControl = 4'b0110; 				// xor
		3'b101: if(funct7b5) ALUControl = 4'b1000; 	// Shift Right Arithmetic Immediate
				else ALUControl = 4'b0111;			// Shift Right
		3'b110: ALUControl = 4'b0011; 				// or
		3'b111: ALUControl = 4'b0010; 				// and
		
		default: ALUControl = 4'bxxxx; // ??
		endcase
endcase
end
endmodule