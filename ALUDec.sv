module ALUDec(
input logic opb5,
input logic [2:0] funct3,
input logic funct7b5,
input logic [1:0] ALUOp,
output logic [2:0] ALUControl
);

logic RtypeSub;
assign RtypeSub = opb5 & funct7b5; // TRUE for R-type

always_comb begin 
case(ALUOp)
2'b00: ALUControl = 3'b000; // add
2'b01: ALUControl = 3'b001; // sub
default: case(funct3)
		3'b000: if(RtypeSub) ALUControl = 3'b001; // sub
				else ALUControl = 3'b000; // add
		3'b010: ALUControl = 3'b101; // slt
		3'b110: ALUControl = 3'b011; // or
		3'b111: ALUControl = 3'b010; // and
		default: ALUControl = 3'bxxx; // ??
		endcase
endcase
end
endmodule