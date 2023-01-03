module WriteBack (
	input clk, memOrReg,
	input [15:0] memData, aluData,
	output [15:0] outputRes,
	output reg [15:0] outputToEx
);

	assign outputRes = memOrReg ? aluData : memData;

	always @(posedge clk) begin
		outputToEx = outputRes;
	end

endmodule
