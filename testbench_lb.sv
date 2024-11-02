module testbench();

logic clk, reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;

top dut(
.clk(clk),
.reset(reset),
.WriteData(WriteData),
.DataAdr(DataAdr),
.MemWrite(MemWrite)
);

initial 
begin
reset <= 1; #22; reset <= 0; 
end

always
begin
clk <= 1; #5; clk <= 0; #5;
end

always @(negedge clk)
	begin 
	if(MemWrite) begin
		if(DataAdr === 100 & WriteData === 1100) begin
		$display("simulation succeeded");
		$stop;
	end 
		else if (DataAdr !== 96 & DataAdr !== 100) begin
		$display("simulation failed, DataAdr = 0x%h", DataAdr);
		$stop;
	end
	end
end


endmodule