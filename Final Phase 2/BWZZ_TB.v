module BWZZ_TB();

localparam N = 10;

reg clk, reset, interrupt;

BWZZ yarb(clk, reset, interrupt);

initial begin
	clk = 1'b0;
	reset = 1'b1;
	interrupt = 1'b0;

	#(N*2);

	reset = 1'b0;


end

always #N clk = !clk;

endmodule