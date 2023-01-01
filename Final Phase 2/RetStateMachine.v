module RetStateMachine (
	input clk, retSignal,
	output reg flushSignal
);

	reg [1:0] state;
	// 00 => do nothing
	// 01 => Flush
	// 10 => Flush

	initial begin
		state = 2'b00;
		flushSignal = 0;
	end

	always @(posedge retSignal) begin
		state = 2'b01;
	end

	always @(posedge clk) begin
		if (state == 2'b01) begin
			flushSignal = 1;
			state = 2'b10;
		end else if (state == 2'b10) begin
			flushSignal = 1;
			state = 2'b11;
		end else if (state == 2'b11) begin
			flushSignal = 0;
			state = 2'b00;
		end
	end

endmodule